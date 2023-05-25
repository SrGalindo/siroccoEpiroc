trigger EventTrigger on Event (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        EventTriggerHandler.createRecordInParentForEvent(Trigger.new);
    }
}