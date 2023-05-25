public with sharing class LookupHandler {
    @AuraEnabled
    public static void setObjectToRecentItems(Id recordId) {
        if (!String.isBlank(recordId)) {
            Schema.SObjectType sObjectType = id.valueOf(recordId).getSobjectType();
            String queryString = String.format('SELECT Id, Name FROM {0} WHERE Id =: recordId FOR VIEW', new List<Object>{sObjectType});
            Database.query(queryString);
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getRecordType(string recordId){
        try {
            String sObjectName = id.valueOf(recordId).getSObjectType().getDescribe().getName();
            System.debug(sObjectName);
            return sObjectName;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void setAddress(string recordId, string addressId){
        try {
            String sObjectName = id.valueOf(recordId).getSObjectType().getDescribe().getName();
            Address__c address = [SELECT Name, Address_Type__r.Name FROM Address__c WHERE Id =: addressId WITH SECURITY_ENFORCED LIMIT 1];
            
            if(sObjectName == 'Opportunity'){
                System.debug('in the opportunity set address');
                System.debug(String.valueOf(address.Address_Type__r.Name));
                Opportunity opp = [SELECT Name, Bill_to__c, Ship_to__c FROM Opportunity WHERE Id =: recordId WITH SECURITY_ENFORCED LIMIT 1];
                System.debug('Before set: ' + opp.Ship_to__c);
                opp.Bill_to__c = String.valueOf(address.Address_Type__r.Name) == 'Bill-to' ? addressId : opp.Bill_to__c;
                opp.Ship_to__c = String.valueOf(address.Address_Type__r.Name) == 'Ship-to' ? addressId : opp.Ship_to__c;
                System.debug('After set: ' + opp.Ship_to__c);

                update opp;
            }

            if(sObjectName == 'Quote'){
                Quote quote = [SELECT Name, Bill_to__c, Ship_to__c FROM Quote WHERE Id =: recordId WITH SECURITY_ENFORCED LIMIT 1];
                System.debug('in the Quote set address');
                quote.Bill_to__c = String.valueOf(address.Address_Type__r.Name)  == 'Bill-to' ? addressId : quote.Bill_to__c;
                quote.Ship_to__c = String.valueOf(address.Address_Type__r.Name)  == 'Ship-to' ? addressId : quote.Ship_to__c;
                update quote;
            }

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}