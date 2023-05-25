trigger AccountStakeHolderTrigger on Account_Stakeholder__c (before insert, before update) {
    if(Trigger.isBefore && Trigger.isInsert){
        System.debug('insert trigger');
        AccountStakeHolderTriggerHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
    }
}