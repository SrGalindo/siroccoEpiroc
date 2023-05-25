/**
 * Created by Sirocco on 2022-12-01.
 */

@IsTest
private class relatedListController_Test {

    @TestSetup
    public static void testSetup() {
        Account acc = TestDataFactory.createSingelAccount();
        Contact cnt = new Contact(LastName = 'test', AccountId = acc.Id, Title='TestBoss', Email='Testy@McTestisson.com', Phone='+46706500000');
        insert cnt;
        Contact cnt2 = new Contact(LastName = 'test', FirstName='test2', AccountId = acc.Id, Title='TestWorker', Email='Testman@McTestisson.com', Phone='+46707500000');
        insert cnt2;
    }

    @IsTest
    public static void testInitWithRecordId(){
        Contact cnt = [SELECT Id, AccountId FROM Contact WHERE FirstName = NULL LIMIT 1];
        Integer AMOUNT_OF_RECORDS = 1;
        Map<String, Object> requestMap = new Map<String, Object>();
        requestMap.put(relatedListController.FIELDS_PARAM, 'Name, Title, Email, Phone');
        requestMap.put(relatedListController.RELATED_FIELD_API_NAME_PARAM, 'AccountId');
        requestMap.put(relatedListController.RECORD_ID_PARAM, cnt.AccountId);
        requestMap.put(relatedListController.NUMBER_OF_RECORDS_PARAM, AMOUNT_OF_RECORDS);
        requestMap.put(relatedListController.SOBJECT_API_NAME_PARAM, 'Contact');
        requestMap.put(relatedListController.SORTED_BY_PARAM, 'Name');
        requestMap.put(relatedListController.SORTED_DIRECTION_PARAM, 'ASC');
        requestMap.put(relatedListController.FILTER_BY_PARAM, 'FirstName = NULL');
        requestMap.put(relatedListController.MATCH_TO_PARAM, 'recordId');

        Test.startTest();
        String jsonData = relatedListController.initData(JSON.serialize(requestMap));
        Test.stopTest();
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(jsonData);
        List<Object> records = (List<Object>)responseMap.get(relatedListController.RECORDS_PARAM);
        Assert.areEqual('Contact', responseMap.get(relatedListController.SOBJECT_LABEL_PARAM));
        Assert.areEqual('Contacts', responseMap.get(relatedListController.PARENT_RELATIONSHIP_API_NAME_PARAM));
        Assert.areEqual('standard:contact', responseMap.get(relatedListController.ICON_NAME_PARAM));
        Assert.isFalse(records.isEmpty());
        Assert.isTrue(records.size() == AMOUNT_OF_RECORDS);
        Map<String, Object> rec = (Map<String, Object>) records[0];
        Assert.areEqual(cnt.Id, rec.get('Id'));
    }

    @IsTest
    public static void testInitWithOtherMatchTo(){
        Contact cnt = [SELECT Id, AccountId, Account.Id FROM Contact WHERE FirstName = NULL LIMIT 1];
        Integer AMOUNT_OF_RECORDS = 1;
        Map<String, Object> requestMap = new Map<String, Object>();
        requestMap.put(relatedListController.FIELDS_PARAM, 'Name, Title, Email, Phone');
        requestMap.put(relatedListController.RELATED_FIELD_API_NAME_PARAM, 'AccountId');
        requestMap.put(relatedListController.RECORD_ID_PARAM, cnt.AccountId);
        requestMap.put(relatedListController.NUMBER_OF_RECORDS_PARAM, AMOUNT_OF_RECORDS);
        requestMap.put(relatedListController.SOBJECT_API_NAME_PARAM, 'Contact');
        requestMap.put(relatedListController.SORTED_BY_PARAM, 'Name');
        requestMap.put(relatedListController.SORTED_DIRECTION_PARAM, 'ASC');
        requestMap.put(relatedListController.FILTER_BY_PARAM, 'FirstName = NULL');
        requestMap.put(relatedListController.MATCH_TO_PARAM, 'Id');

        Test.startTest();
        String jsonData = relatedListController.initData(JSON.serialize(requestMap));
        Test.stopTest();
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(jsonData);
        List<Object> records = (List<Object>)responseMap.get(relatedListController.RECORDS_PARAM);
        Assert.areEqual('Contact', responseMap.get(relatedListController.SOBJECT_LABEL_PARAM));
        Assert.areEqual('Contacts', responseMap.get(relatedListController.PARENT_RELATIONSHIP_API_NAME_PARAM));
        Assert.areEqual('standard:contact', responseMap.get(relatedListController.ICON_NAME_PARAM));
        Assert.isFalse(records.isEmpty());
        Assert.isTrue(records.size() == AMOUNT_OF_RECORDS);
        Map<String, Object> rec = (Map<String, Object>) records[0];
        Assert.areEqual(cnt.Id, rec.get('Id'));
    }
}