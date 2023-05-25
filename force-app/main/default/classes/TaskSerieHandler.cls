public with sharing class TaskSerieHandler {
    @AuraEnabled
    public static string createNewTaskSerie(string name, string accountId, string opportunityId, string accountPlanId, string comment){
        try{
            Activity_Serie__c taskSerie = new Activity_Serie__c(
                Name = name
            );

            if(!String.isBlank(accountid)){
                taskSerie.Account__c = id.valueOf(accountId);
            }

            if(!String.isBlank(opportunityId)){
                taskSerie.Opportunity__c = id.valueOf(opportunityId);
            }

            if(!String.isBlank(accountPlanId)){
                taskSerie.Account_Plan__c = id.valueOf(accountPlanId);
            }

            if(!String.isBlank(comment)){
                taskSerie.Comments__c = comment;
            }
            
            insert taskSerie;

            return taskSerie.id;
        } catch(Exception e){
            return 'error ' + e.getMessage();
        }
    }
}