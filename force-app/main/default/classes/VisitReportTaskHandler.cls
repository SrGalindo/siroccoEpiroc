public with sharing class VisitReportTaskHandler {
    @AuraEnabled
    public static String getVistReportTasks(String recordId){
        Visit_Report__c currentVisitReport = [SELECT id, Account__c, CreatedDate FROM Visit_Report__c WHERE id =: recordId WITH SECURITY_ENFORCED];
        List<Visit_Report__c> visitReports = [SELECT id, Name, CreatedDate FROM Visit_Report__c WHERE Account__c =: String.valueOf(currentVisitReport.Account__c) and CreatedDate <: currentVisitReport.CreatedDate WITH SECURITY_ENFORCED];
        Set<Id> visitReportIds = (new Map<Id, Visit_Report__c>(visitReports)).keySet();
        List<Task> tasks = [SELECT id, Status, Subject, Type, WhatId, Description, CreatedDate FROM Task WHERE WhatId IN :visitReportIds and Status != 'Completed' WITH SECURITY_ENFORCED];
        List<PreviousVisitReport> preVisitReports= new List<PreviousVisitReport>();
        System.debug(recordId);
        System.debug(visitReports.size());
        try{
            for(Visit_Report__c vr : visitReports){
                PreviousVisitReport preVisitReport = new PreviousVisitReport();
                preVisitReport.id = vr.id;
                preVisitReport.name = vr.Name;
                preVisitReport.createdDate = vr.CreatedDate.format('dd-MM-YYYY');
                preVisitReport.tasks = new List<UnclosedTask>();
                System.debug('First Loop');
                System.debug(vr);
                for(Task t : tasks){
                    if(t.WhatId == vr.id){
                        System.debug('second loop');
                        System.debug(t);
                        UnclosedTask ut = new UnclosedTask();
                        ut.id = t.Id;
                        ut.subject = t.Subject;
                        ut.description = t.Description;
                        ut.type = t.Type;
                        ut.status = t.Status;
                        ut.createdDate = t.CreatedDate.format('dd-MM-YYYY');
                        preVisitReport.tasks.add(ut);
                    }
                }
                System.debug('out first loop');
                System.debug(preVisitReport);
                if(preVisitReport.tasks.size() != 0){
                    System.debug('add report to list');
                    System.debug(preVisitReport);
                    preVisitReports.add(preVisitReport);
                } else {
                    System.debug('No Tasks');
                    System.debug(preVisitReport);
                }
            }
        } catch(Exception error) {
            System.debug('error: ' + error.getMessage());
            //throw new AuraHandledException('Something went wrong' + error.getMessage());
        }

        System.debug('done');

        System.debug(preVisitReports);
        Response response = new Response();
        response.previousVisitReports = preVisitReports;
        String result = JSON.serialize(preVisitReports);
        System.debug(result);
        return result;
    }

    @AuraEnabled
    public static String updateTaskStatus(String taskId, String status){
        Task task = [SELECT Id, Status FROM Task WHERE Id =: taskId WITH SECURITY_ENFORCED];
        task.Status = status;
        System.debug(task.Status);
        update task;
        return task.Status;
    }
    

    public class Response{
        List<PreviousVisitReport> previousVisitReports;
    }

    public class PreviousVisitReport{
        Id id;
        String name;
        String createdDate;
        List<UnclosedTask> tasks;
    }

    public class UnclosedTask{
        Id id;
        String status;
        String subject;
        String description;
        String type;
        String createdDate;
    }
}