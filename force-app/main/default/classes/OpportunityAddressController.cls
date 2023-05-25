public without sharing class OpportunityAddressController {
    @AuraEnabled(cacheable=false)
    public static List<Object> searchRecords(String searchKey, String objectApiName, String recordId, List<Id> selectedIds, String type){
        String key ='%'+ searchKey + '%';
        if(objectApiName == 'Opportunity'){
            Opportunity opp = [SELECT Id, AccountId, End_Customer__c FROM Opportunity WHERE ID =:recordId];
            List<Object> ret = [SELECT Id,Name FROM Address__c WHERE Name LIKE :key AND Id NOT IN :selectedIds AND (Account__c =:opp.AccountId OR Account__c =: opp.End_Customer__c) AND Address_Type__r.Name = :type AND Account__c != null];
            if(ret.size() == 0) ret = [SELECT Id,Name FROM Address__c WHERE Id NOT IN :selectedIds AND (Account__c =:opp.AccountId OR Account__c =: opp.End_Customer__c) AND Address_Type__r.Name = :type AND Account__c != null];
            return ret;
        }
        else if(objectApiName == 'Quote'){
            Quote quote = [SELECT Id, AccountId FROM Quote WHERE ID =:recordId];
            List<Object> ret = [SELECT Id,Name FROM Address__c WHERE Name LIKE :key AND Id NOT IN :selectedIds AND (Account__c =:quote.AccountId) AND Address_Type__r.Name = :type AND Account__c != null];
            if(ret.size() == 0) ret = [SELECT Id,Name FROM Address__c WHERE Id NOT IN :selectedIds AND (Account__c =:quote.AccountId) AND Address_Type__r.Name = :type AND Account__c != null];
            return ret;
        }
        throw new AuraHandledException('Component only available on Quote and Opportunity');
    }
    @AuraEnabled
    public static List<Object> getPreselectedAddress(String objectApiName, String recordId, String type){
        try {
        if(objectApiName == 'Opportunity'){
            Opportunity opp = [SELECT Id, AccountId, Bill_to__c, Ship_to__c FROM Opportunity WHERE ID =:recordId];
            List<Object> ret = [SELECT Id,Name FROM Address__c WHERE (Id =:opp.Bill_to__c OR Id =: opp.Ship_to__c) AND Address_Type__r.Name = :type];
            return ret;
        }
        else if(objectApiName == 'Quote'){
            Quote quote = [SELECT Id, AccountId, Bill_to__c, Ship_to__c FROM Quote WHERE ID =:recordId];
            List<Object> ret = [SELECT Id,Name FROM Address__c WHERE (Id =:quote.Bill_to__c OR Id =: quote.Ship_to__c) AND Address_Type__r.Name = :type];
            return ret;
        }
        throw new AuraHandledException('Unexpected error');
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static CallbackWrapper saveAddress(String objectApiName, String recordId, String addressId, String type){
        CallbackWrapper cb = new CallbackWrapper();
        cb.status = 'success';
        try {
            if(objectApiName == 'Opportunity'){
                Opportunity opp = new Opportunity();
                opp.Id = recordId;
                if(type == 'Bill-To') opp.Bill_to__c = addressId;
                if(type == 'Ship-To') opp.Ship_to__c = addressId;
                update opp;
            }
            else if(objectApiName == 'Quote'){
                Quote quote = new Quote();
                quote.Id = recordId;
                if(type == 'Bill-To') quote.Bill_to__c = addressId;
                if(type == 'Ship-To') quote.Ship_to__c = addressId;
                update quote;
            }
            return cb;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static CallbackWrapper deleteAddress(String objectApiName, String recordId, String addressId, String type){
        CallbackWrapper cb = new CallbackWrapper();
        cb.status = 'success';
        try {
            if(objectApiName == 'Opportunity'){
                Opportunity opp = new Opportunity();
                opp.Id = recordId;
                if(type == 'Bill-To') opp.Bill_to__c = null;
                if(type == 'Ship-To') opp.Ship_to__c = null;
                update opp;
            }
            else if(objectApiName == 'Quote'){
                Quote quote = new Quote();
                quote.Id = recordId;
                if(type == 'Bill-To') quote.Bill_to__c = null;
                if(type == 'Ship-To') quote.Ship_to__c = null;
                update quote;
            }
            return cb;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    // public class LookupWrapper{
    //     @AuraEnabled public ID Id;
    //     @AuraEnabled public String Name;
    //     public LookupWrapper(User u){
    //         this.Id = u.ContactId;
    //         this.Name = u.Contact.Name;
    //     }
    // }
}