public with sharing class OpportunityStakeHolderTriggerHandler {
    public static void beforeInsert(List<Opportunity_Stakeholder__c> accStakeHoldersArg){
        
        mapFields(accStakeHoldersArg);

    }
    public static void mapFields(List<Opportunity_Stakeholder__c> accStakeHoldersArg){
        Set<Id> stakeholderIds = new Set<Id>();
        for(Opportunity_Stakeholder__c accstakeLooper : accStakeHoldersArg){
            stakeholderIds.add(accstakeLooper.Stakeholder__c);
        }
        Map<Id, Stakeholder__c> newMap = new Map<Id, Stakeholder__c>([SELECT Id, Name FROM Stakeholder__c WHERE Id IN :stakeholderIds]);

        System.debug('map 1');

        for(Opportunity_Stakeholder__c oshLooper : accStakeHoldersArg){
        System.debug('map 2');
        System.debug(newMap.size());
            oshLooper.name = newMap.get(oshLooper.Stakeholder__c).Name;
        }
    }
}