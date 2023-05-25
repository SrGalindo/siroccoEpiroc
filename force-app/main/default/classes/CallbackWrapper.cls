public with sharing class CallbackWrapper {
    @AuraEnabled
    public String status { get; set;}
    @AuraEnabled
    public String message { get; set;}
    @AuraEnabled
    public String id { get; set;}
}