trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, before update, after insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        OpportunityLineItemTriggerHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        OpportunityLineItemTriggerHandler.beforeUpdate(Trigger.newMap);
    }
    // if(Trigger.isAfter && Trigger.isInsert){
    //     OpportunityLineItemTriggerHandler.afterInsert(Trigger.new);
    // }
}