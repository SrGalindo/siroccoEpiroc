trigger UserTrigger on User (before insert, after insert) {
    if(Trigger.isInsert && Trigger.isBefore){
        UserTriggerHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isInsert && Trigger.isAfter){
        UserTriggerHandler.afterInsert(Trigger.new);
    }
}