public with sharing class Receivables {
    @AuraEnabled
        public static CallbackWrapper getReceivables(String recordId){
            List<Account> accList = [SELECT Id, CCUST__c, FAM_Code__c FROM Account WHERE Id =: recordId];
            if(accList.size() == 0) throw new AuraHandledException('Component only available on Account');
            Account currentAcc = accList[0];
            String ccust = String.valueOf(currentAcc.CCUST__c);
            String famCode = currentAcc.FAM_Code__c;
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
                argumentsString += '?cRcustNo=' + ccust;
            }else {
                return callback;
            }
            
            System.debug('Argumentstring: '+argumentsString);
            HttpRequest req = new HttpRequest();
            String uriWithParam = 'callout:erp-source/v1/accounts-receivables' +argumentsString;
            System.debug(uriWithParam);
            req.setEndpoint('callout:azure_integration/erp-source/v1/accounts-receivables' +argumentsString);
            //req.setEndpoint('callout:azure_integration/bpcs/source/proxy/v1/accounts-receivables?cRcustNo=220005');
            req.setMethod('GET');
            req.setTimeout(120000);
            req.setHeader('UnitCode', famCode);
            System.debug(req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());

            if (!res.getBody().contains('cRcustNo')) {
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