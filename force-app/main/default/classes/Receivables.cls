public with sharing class Receivables {
    @AuraEnabled
        public static CallbackWrapper getReceivables(String recordId){
            List<Account> accList = [SELECT Id, CCUST__c, FAM_Code__c, Source_System__c FROM Account WHERE Id =: recordId];
            if(accList.size() == 0) throw new AuraHandledException('Component only available on Account');
            Account currentAcc = accList[0];
            String ccust = String.valueOf(currentAcc.CCUST__c);
            String famCode = currentAcc.FAM_Code__c;
            String sourceSystem = currentAcc.Source_System__c;
            // Boolean isSandbox = [SELECT IsSandbox FROM Organization LIMIT 1][0].IsSandbox;
            // if(isSandbox){
            //     //Map fam codes from test to prod
            //     famCode = Util.switchFamCode(famCode);
            // }
            System.debug('famCode');
            System.debug(famCode);
            System.debug('ccust2');
            System.debug(currentAcc.CCUST__c);
        CallbackWrapper callback = new CallbackWrapper();
        callback.status = 'error';
        callback.message = 'No data found';
        try {
            String argumentsString = '';
            if(ccust != null){
                argumentsString += ccust;
            }else {
                return callback;
            }
            
            System.debug('Argumentstring: '+argumentsString);
            HttpRequest req = new HttpRequest();
            String uriWithParam = 'callout:erp/source/sales/v1/accounts-receivables/customers/' +argumentsString;
            System.debug(uriWithParam);
            req.setEndpoint('callout:azure_dev_integration/erp/source/sales/v1/accounts-receivables/customers/' +argumentsString);
            //req.setEndpoint('callout:azure_integration/bpcs/source/proxy/v1/accounts-receivables?cRcustNo=220005');
            req.setMethod('GET');
            req.setTimeout(120000);
            req.setHeader('unitCode', famCode);
            req.setHeader('sourceSystem', sourceSystem);
            System.debug(req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());

            if (!res.getBody().contains('invoiceNumber')) {
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