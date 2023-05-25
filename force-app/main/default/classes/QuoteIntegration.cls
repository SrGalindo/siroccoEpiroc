public with sharing class QuoteIntegration {
    @AuraEnabled
        public static CallbackWrapper getQuotes(String recordId){
            List<Account> accList = [SELECT Id, CCUST__c, FAM_Code__c FROM Account WHERE Id =: recordId WITH SECURITY_ENFORCED];
            if(accList.size() == 0){
                throw new AuraHandledException('Component only available on Account');
            }

            Account currentAcc = accList[0];
            String ccust = String.valueOf(currentAcc.CCUST__c);
            String famCode = currentAcc.FAM_Code__c;
            Boolean isSandbox = [SELECT IsSandbox FROM Organization LIMIT 1][0].IsSandbox;
            if(isSandbox){
                //Map fam codes from test to prod
                //famCode = Util.switchFamCode(famCode);
            }

            CallbackWrapper callback = new CallbackWrapper();
            callback.status = 'error';
            callback.message = 'No data found';
            
            try {
                String argumentsString = '';
                if(ccust != null){
                    argumentsString += '?oRcustNo=' + ccust;
                    argumentsString += '&oRnumberQuotes=20';
                } else {
                    return callback;
                }
                
                System.debug('Argumentstring: '+argumentsString);
                HttpRequest req = new HttpRequest();
                String uriWithParam = 'callout:azure_integration/erp-source/v1/quotes' +argumentsString;
                System.debug(uriWithParam);
                req.setEndpoint('callout:azure_integration/erp-source/v1/quotes' +argumentsString);
                req.setMethod('GET');
                req.setTimeout(120000);
                req.setHeader('UnitCode', famCode);
                System.debug(req);
                Http http = new Http();
                HTTPResponse res = http.send(req);
                System.debug(res.getBody());

                if(!res.getBody().contains('oRcustNo')){
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