public with sharing class AccountStakeHolderTriggerHandler {
    public static void beforeInsert(List<Account_Stakeholder__c> accStakeHoldersArg){
        
        mapFields(accStakeHoldersArg);

    }
    public static void mapFields(List<Account_Stakeholder__c> accStakeHoldersArg){
        Set<Id> stakeholderIds = new Set<Id>();
        for(Account_Stakeholder__c accstakeLooper : accStakeHoldersArg){
            stakeholderIds.add(accstakeLooper.Stakeholder__c);
        }
        Map<Id, Stakeholder__c> newMap = new Map<Id, Stakeholder__c>([SELECT Id, Name FROM Stakeholder__c WHERE Id IN :stakeholderIds]);

        System.debug('map 1');

        for(Account_Stakeholder__c ashLooper : accStakeHoldersArg){
        System.debug('map 2');
        System.debug(newMap.size());

            ashLooper.name = newMap.get(ashLooper.Stakeholder__c).Name;
        }
    }
}