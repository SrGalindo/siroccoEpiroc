trigger QuoteLineTrigger on QuoteLineItem (before insert, before update, after update) {
    if(Trigger.isBefore && Trigger.isInsert){
        QuoteLineTriggerHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        QuoteLineTriggerHandler.beforeUpdate(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        QuoteLineTriggerHandler.afterUpdate(Trigger.new);
    }
}