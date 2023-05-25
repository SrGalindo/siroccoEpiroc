trigger TaskTrigger on Task (after insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        EventTriggerHandler.createRecordInParentForTask(Trigger.new);
    }
    
}