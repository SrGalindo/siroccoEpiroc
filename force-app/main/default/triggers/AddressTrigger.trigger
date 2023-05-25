trigger AddressTrigger on Address__c (before insert, before update) {
    if(Trigger.isBefore && Trigger.isInsert){
        AddressTriggerHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        AddressTriggerHandler.beforeUpdate(Trigger.new);
    }
}