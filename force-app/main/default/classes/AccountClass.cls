public with sharing class AccountClass {
    @AuraEnabled
    public static String getAccount(Id id){
        String sObjectName = id.getSObjectType().getDescribe().getName();

        if(sObjectName == 'Opportunity'){
            Opportunity opp = [SELECT AccountId FROM Opportunity WHERE Id =: id WITH SECURITY_ENFORCED LIMIT 1];
            Account acct = [SELECT Id, Name FROM Account WHERE Id =: opp.AccountId WITH SECURITY_ENFORCED];
            return String.valueOf(acct.Id);
        }

        if(sObjectName == 'Quote'){
            Quote quote = [SELECT AccountId FROM Quote WHERE Id =: id WITH SECURITY_ENFORCED LIMIT 1];
            Account acct = [SELECT Id, Name FROM Account WHERE Id =: quote.AccountId WITH SECURITY_ENFORCED];
            return String.valueOf(quote.Id);
        }
        return '';
    }
}