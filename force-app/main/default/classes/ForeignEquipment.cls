public with sharing class ForeignEquipment {
    @AuraEnabled
        public static CallbackWrapper getItems(String recordId){
            List<Account> accList = [SELECT Id, CCUST__c, FAM_Code__c FROM Account WHERE Id =: recordId WITH SECURITY_ENFORCED];
            if(accList.size() == 0) {
                throw new AuraHandledException('Component only available on Account');
            }
            
            Account currentAcc = accList[0];
            String ccust = String.valueOf(currentAcc.CCUST__c);
            System.debug('start');
            System.debug(ccust);
        CallbackWrapper callback = new CallbackWrapper();
        callback.status = 'error';
        callback.message = 'No data found';
        try {
            String argumentsString = '?pagingIndex=1&pagingSize=50&';
            if(ccust != null){
                argumentsString += '&CustomerNumber=' + ccust;
                argumentsString += '&FamCode=' + currentAcc.FAM_code__c;
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