trigger OpportunityTrigger on Opportunity (before insert, before update, after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        OpportunityTriggerHandler.afterUpdate(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isInsert){
        OpportunityTriggerHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
       OpportunityTriggerHandler.beforeUpdate(Trigger.new, Trigger.old);
    }
}