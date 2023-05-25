/**
 * Created by Sirocco on 2022-11-29.
 */

public with sharing class relatedListController {
    public static final String FIELDS_PARAM = 'fields';
    public static final String NUMBER_OF_RECORDS_PARAM = 'numberOfRecords';
    public static final String RECORD_ID_PARAM = 'recordId';
    public static final String SOBJECT_API_NAME_PARAM = 'sobjectApiName';
    public static final String SOBJECT_LABEL_PARAM = 'sobjectLabel';
    public static final String SOBJECT_LABEL_PLURAL_PARAM = 'sobjectLabelPlural';
    public static final String PARENT_RELATIONSHIP_API_NAME_PARAM = 'parentRelationshipApiName';
    public static final String RELATED_FIELD_API_NAME_PARAM = 'relatedFieldApiName';
    public static final String SORTED_DIRECTION_PARAM = 'sortedDirection';
    public static final String SORTED_BY_PARAM = 'sortedBy';
    public static final String RECORDS_PARAM = 'records';
    public static final String ICON_NAME_PARAM = 'iconName';
    public static final String FILTER_BY_PARAM = 'filterBy';
    public static final String MATCH_TO_PARAM = 'matchTo';

    @AuraEnabled
    public static String initData(String jsonData) {
        System.debug(jsonData);
        Map<String, Object> requestMap = (Map<String, Object>) JSON.deserializeUntyped(jsonData);
        Map<String, Object> responseMap = new Map<String, Object>();
        responseMap.put(RECORDS_PARAM, getRecords(jsonData));
        System.debug('ReturnData: getRecords: '+responseMap.get(RECORDS_PARAM));
        String sobjectApiName = (String) requestMap.get(SOBJECT_API_NAME_PARAM);
        responseMap.put(ICON_NAME_PARAM, getIconName(sobjectApiName));
        String recordId = (String) requestMap.get(RECORD_ID_PARAM);
        String relatedFieldApiName = (String) requestMap.get(RELATED_FIELD_API_NAME_PARAM);
        responseMap.put(PARENT_RELATIONSHIP_API_NAME_PARAM, getParentRelationshipName(recordId, sobjectApiName, relatedFieldApiName));

        Schema.SObjectType sobjectType = Schema.getGlobalDescribe().get(sobjectApiName);
        Schema.DescribeSObjectResult sobjectDescribe = sobjectType.getDescribe();
        responseMap.put(SOBJECT_LABEL_PARAM, sobjectDescribe.getLabel());
        responseMap.put(SOBJECT_LABEL_PLURAL_PARAM, sobjectDescribe.getLabelPlural());
        System.debug('RETURN: '+responseMap);
        return JSON.serialize(responseMap);
    }

    @AuraEnabled
    public static List<SObject> getRecords(String jsonData) {
        Map<String, Object> root = (Map<String, Object>) JSON.deserializeUntyped(jsonData);
        String fields = (String) root.get(FIELDS_PARAM);
        Integer numberOfRecords = root.get(NUMBER_OF_RECORDS_PARAM) instanceof String ? Integer.valueOf((String) root.get(NUMBER_OF_RECORDS_PARAM)) : (Integer) root.get(NUMBER_OF_RECORDS_PARAM);
        String recordId = (String) root.get(RECORD_ID_PARAM);
        String relatedFieldApiName = (String) root.get(RELATED_FIELD_API_NAME_PARAM);
        String sobjectApiName = (String) root.get(SOBJECT_API_NAME_PARAM);
        // check what order by is when nothing in sortedBy
        String orderBy = ' ORDER BY ' + (String) root.get(SORTED_BY_PARAM) + ' ' + (String) root.get(SORTED_DIRECTION_PARAM);
        if((String) root.get(SORTED_BY_PARAM) == null || (String) root.get(SORTED_BY_PARAM) == '') orderBy = '';
        String filterBy = '';
        if((String) root.get(FILTER_BY_PARAM) != null && (String) root.get(FILTER_BY_PARAM) != '') filterBy = ' AND ' + (String) root.get(FILTER_BY_PARAM);

        if((String) root.get(MATCH_TO_PARAM) != 'recordId') {
            Id recId = recordId;
            System.debug('recID: '+recId);
            String sobjectName = recId.getSobjectType().getDescribe().getName();
            String matchToQuery = 'SELECT '+ (String) root.get(MATCH_TO_PARAM) + ' FROM ' + sobjectName + ' WHERE Id =: recordId';
            SObject matchToObject = (SObject) Database.query(matchToQuery);
            // if nothing in the field they want to match then unnecessary to do second query.. just return empty list
            if((String) matchToObject.get((String) root.get(MATCH_TO_PARAM)) == null) return new List<SObject>();
            recordId = (String) matchToObject.get((String) root.get(MATCH_TO_PARAM));
        }

        String query = 'SELECT ' + fields + ' FROM ' + sobjectApiName + ' WHERE ' + relatedFieldApiName + '= :recordId' + filterBy + orderBy + ' LIMIT :numberOfRecords';
        System.debug('query: '+query);
        return Database.query(query);
    }

    private static String getParentRelationshipName(Id recordId, String childSobjectApiName, String relatedFieldApiName) {
        System.debug('Inside getParentRelationshipName');
        System.debug('relatedFieldApiName: '+relatedFieldApiName);
        Schema.DescribeSObjectResult descrRes = recordId.getSobjectType().getDescribe();
        String name;
        for (Schema.ChildRelationship cr : descrRes.getChildRelationships()) {
            if (cr.getChildSObject().getDescribe().getName() == childSobjectApiName
                    && cr.getField().getDescribe().getName() == relatedFieldApiName) {
                System.debug('Name: '+cr.getRelationshipName());
                name = cr.getRelationshipName();
                break;
            }
        }
        return name;
    }

    @AuraEnabled
    public static String getIconName(String sobjectApiName) {
        System.debug('Inside getIconName');
        String iconName;
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        List<Schema.DescribeTabResult> tabDesc = new List<Schema.DescribeTabResult>();
        List<Schema.DescribeIconResult> iconDesc = new List<Schema.DescribeIconResult>();

        for (Schema.DescribeTabSetResult tsr : tabSetDesc) {
            tabDesc.addAll(tsr.getTabs());
        }

        for (Schema.DescribeTabResult tr : tabDesc) {
            if (sobjectApiName == tr.getSobjectName()) {
                if (tr.isCustom()) {
                    iconDesc.addAll(tr.getIcons());
                }
                else {
                    iconName = 'standard:' + sobjectApiName.toLowerCase();
                }
            }
        }
        for (Schema.DescribeIconResult ir : iconDesc) {
            if (ir.getContentType() == 'image/svg+xml') {
                iconName = 'custom:' + ir.getUrl().substringBetween('custom/', '.svg').substringBefore('_');
                break;
            }
        }
        if(iconName == null) return 'standard:related_list';
        return iconName;
    }
}