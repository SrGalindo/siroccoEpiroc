trigger OpportunityStakeHolderTrigger on Opportunity_Stakeholder__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        System.debug('insert trigger');
        OpportunityStakeHolderTriggerHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
    }
    
}