public class Casepdf {
    
    public Visit_Report__c values { get; private set; }
    
    public Casepdf(){
        values = [SELECT Id,Name,Account__r.Name,CreatedBy.Name,Agenda_of_visit__c,Reason_for_visit__c,Status__c,Division_Multi__c,
                  Subject__c,Date_Time__c,Type_of_Visit__c,Additional_attendance_to_the_meeting__c,Attendance_Contact_person_in_meeting__r.Name,
                  Description__c,Notes__c,Positive_feedback__c,Negative_feedback__c,Pain_Points__c,Accomplishments__c
                  FROM Visit_Report__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        
    }
    public Visit_Report__c getVR() {
        return values;
    }
    
    public List<Task> getTasks() {
        List<Task> tasks = [SELECT Id, Subject, Owner.Name, ActivityDate, Status, Priority FROM Task WHERE WhatId = :ApexPages.currentPage().getParameters().get('id')];
        return tasks;
    }
}