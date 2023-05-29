public with sharing class OrderController {
    @AuraEnabled
        public static CallbackWrapper getOrders(String recordId, Integer numberOfOrders){
            CallbackWrapper callback = new CallbackWrapper();
            List<Account> accList = [SELECT Id, CCUST__c, FAM_Code__c, Source_system__c FROM Account WHERE Id =: recordId WITH SECURITY_ENFORCED];
            if(accList.size() == 0){
                callback.status = 'error';
                callback.message = 'Component only available on Account';
                return callback;
                //throw new AuraHandledException('Component only available on Account');
            }

            Account currentAcc = accList[0];
            String ccust = String.valueOf(currentAcc.CCUST__c);
            String famCode = currentAcc.FAM_Code__c;
            String sourceSystem = currentAcc.Source_system__c;
            Boolean isSandbox = [SELECT IsSandbox FROM Organization LIMIT 1][0].IsSandbox;
            if(isSandbox){
                //Map fam codes from test to prod
                //famCode = Util.switchFamCode(famCode);
            }
            System.debug('famCode');
            System.debug(famCode);
            System.debug('ccust2');
            System.debug(currentAcc.CCUST__c);

        try {
            String argumentsString = '';
            if(ccust != null){
                argumentsString += ccust;
                if(numberOfOrders != null){
                    argumentsString += '?amountOfOrders=' + numberOfOrders;
                } else {
                    argumentsString += '?amountOfOrders=100';
                }
            } else{
                callback.status = 'error';
                callback.message = 'No data found';
                return callback;
            } 

            System.debug('Argumentstring: '+argumentsString);
            HttpRequest req = new HttpRequest();
            String uriWithParam = 'callout:/erp/source/sales/v1/orders/customers/' +argumentsString;
            System.debug(uriWithParam);
            req.setEndpoint('callout:azure_dev_integration/erp/source/sales/v1/orders/customers/' +argumentsString);
            req.setMethod('GET');
            req.setTimeout(120000);
            req.setHeader('unitCode', famCode);
            req.setHeader('sourceSystem', sourceSystem);
            //req.setHeader('X-Consumer', 'Sales Force');
            System.debug(req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());

            if(!res.getBody().contains('orderNumber')){
                return callback;
            }

            callback.status = 'success';
            callback.message = res.getBody();
            return callback;
        } catch (Exception e) {
            callback.status = 'error';
            callback.message = e.getMessage();
            return callback;
            //throw new AuraHandledException(e.getMessage());
        }
    }
}