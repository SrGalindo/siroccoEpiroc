public with sharing class ForeignEquipment {
    @AuraEnabled
        public static CallbackWrapper getItems(String recordId){
            List<Account> accountList = [SELECT Id, CCUST__c, FAM_Code__c FROM Account WHERE Id =: recordId WITH SECURITY_ENFORCED];
            List<Account_Plan__c> accPlanList = [SELECT id,Name,Account__r.CCUST__c,Account__r.FAM_Code__c FROM Account_Plan__c WHERE id =: recordId WITH SECURITY_ENFORCED];
            String customerNumber;
            String customerCenterFamCode;
            if(accountList.size() >0){
                customerNumber = String.valueOf(accountList[0].CCUST__c);
                customerCenterFamCode = String.valueOf(accountList[0].FAM_Code__c);
            } 
            else if(accPlanList.size() >0){
                customerNumber = String.valueOf(accPlanList[0].Account__r.CCUST__c);
                customerCenterFamCode = String.valueOf(accPlanList[0].Account__r.FAM_Code__c);
            }
            else throw new AuraHandledException('Component only available on account and account plan');
        CallbackWrapper callback = new CallbackWrapper();
        callback.status = 'error';
        callback.message = 'No data found';
        try {
            String argumentsString = '?pagingIndex=1&pagingSize=50&';
            if(customerNumber != null){
                argumentsString += '&CustomerNumber=' + customerNumber;
                argumentsString += '&FamCode=' + customerCenterFamCode;
            } else {
                return callback;
            }
            
            System.debug('Argumentstring: '+argumentsString);
            HttpRequest req = new HttpRequest();
            String uriWithParam = 'callout:azure_integration/foreign/equipment/read/proxy/v1/foreignmachines' +argumentsString;
            System.debug(uriWithParam);
            req.setEndpoint('callout:azure_integration/foreign/equipment/read/proxy/v1/foreignmachines' +argumentsString);
            req.setMethod('GET');
            req.setTimeout(120000);
            req.setHeader('X-Consumer', 'Sales Force');
            System.debug(req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());

            if(!res.getBody().contains('serialNumber')){
                return callback;
            }

            callback.status = 'success';
            callback.message = res.getBody();
            return callback;
        } catch (Exception e) {
            callback.message = e.getMessage();
            callback.status = 'error';
            return callback;
            //throw new AuraHandledException(e.getMessage());
        }
    }
}