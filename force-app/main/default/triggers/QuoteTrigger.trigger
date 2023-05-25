trigger QuoteTrigger on Quote (before insert, after insert, before update, after update) {
    if(Trigger.isBefore && Trigger.isInsert){
        QuoteTriggerHandler.beforeInsert(Trigger.new);
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
        QuoteTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
    }
}