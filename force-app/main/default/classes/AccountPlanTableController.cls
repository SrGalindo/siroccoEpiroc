public with sharing class AccountPlanTableController extends BaseController{
    
    // Get the Account Plan table settings
    @AuraEnabled
    public static Map<String, Object> getAccountPlanTableSettings(String tabName, Id recordId){
        Map<String, Object> result = getActionSuccessful(null);
        try{
            String objectName = '';
            String fieldsToQuery = '';
            Boolean isEditable = false;
            List<Account_Plan_Settings__mdt> accPlanSettings = [Select is_Editable__c, Tab_column__c, columns__c, object_name__c, Api_Fields_Name__c From Account_Plan_Settings__mdt where Tab_column__c = :tabName Limit 1];
            List<String> columnsList = new List<String>();
            
            for(Account_Plan_Settings__mdt accPlanSetting : accPlanSettings){
                for(String column : accPlanSetting.columns__c.split(',')){
                    columnsList.add(column);
                }
                objectName = accPlanSetting.object_name__c;
                fieldsToQuery = accPlanSetting.Api_Fields_Name__c;
                isEditable = accPlanSetting.is_Editable__c;
            }

            result.put('accPlanSettings', accPlanSettings);
            result.put('columnsList', columnsList);
            List<String> apiFieldsList = fieldsToQuery.split(','); 
            result.put('apiFieldsList', apiFieldsList);
            result.put('isEditable', isEditable);
            result.put('existingRecords', getExistingRecords(recordId, objectName, fieldsToQuery));
        }catch(Exception e) {
            result = getActionFailed(e);
        }
        return result;
    }

    @AuraEnabled
    public static Map<String, Object> createRecord(String objectTypeName, Id accountPlan){
        Map<String, Object> result = getActionSuccessful(null);
        try{
            String jsonObject = '{ "Account_plan_2_0__c": '+JSON.serialize(accountPlan)+'}';
            sObject mySObject;

            Type objectType = Type.forName(objectTypeName);
            mySObject = (sObject)objectType.newInstance();
            mySObject = (sObject)JSON.deserialize(jsonObject, objectType);
            insert mySObject;
        }catch(Exception e) {
            result = getActionFailed(e);
        }
        return result;
    }

    @AuraEnabled
    public static Map<String, Object> linkContact(Id accountPlanId, Id contactId){
        Map<String, Object> result = getActionSuccessful(null);
        try{
            List<Account_Plan_Contacts__c> accPlanContactsList = [Select Id From Account_Plan_Contacts__c where Account_plan_2_0__c = :accountPlanId AND Contact__c = :contactId];
            if(accPlanContactsList.size()>0){
                result = getActionFailed('Record already exists');
            }else{
                Account_Plan_Contacts__c acContact = new Account_Plan_Contacts__c(Account_plan_2_0__c = accountPlanId, Contact__c = contactId);
                insert acContact;
            }
        }catch(Exception e) {
            result = getActionFailed(e);
        }
        return result;
    }

    @AuraEnabled
    public static Map<String, Object> linkAccount(Id accountPlanId, Id accountId){
        Map<String, Object> result = getActionSuccessful(null);
        try{
            List<Account_Plan_Accounts__c> accPlanAccountsList = [Select Id From Account_Plan_Accounts__c where Account_plan_2_0__c = :accountPlanId AND Account__c = :accountId];
            if(accPlanAccountsList.size()>0){
                result = getActionFailed('Record already exists');
            }else{
                Account_Plan_Accounts__c acAccount = new Account_Plan_Accounts__c(Account_plan_2_0__c = accountPlanId, Account__c = accountId);
                insert acAccount;
            }
        }catch(Exception e) {
            result = getActionFailed(e);
        }
        return result;
    }

    @AuraEnabled
    public static Map<String, Object> deleteRecord(Id rowId, String objectTypeName){
        Map<String, Object> result = getActionSuccessful(null);
        try{
            sObject mySObject = Schema.getGlobalDescribe().get(objectTypeName).newSObject();
            mySObject.Id = rowId;
            delete mySObject;
        }catch(Exception e) {
            result = getActionFailed(e);
        }
        return result;
    }

    
    public static List<Object> getExistingRecords(Id recordId, String objectName, String fieldsToQuery){
        String query = 'SELECT ' + fieldsToQuery + ' FROM '+objectName+' Where Account_plan_2_0__c = \''+recordId+'\'';
        List<Object> recordsList = Database.query(query);
        return recordsList;
    }
}