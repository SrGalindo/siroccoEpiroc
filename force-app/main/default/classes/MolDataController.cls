public with sharing class MolDataController {

    public static HttpResponse apiCallout(String request, String endPoint){
        try {
            HttpRequest req = new HttpRequest();
            String username = 'SalesForce';
            String pwd = 'Gofe3=Baco5#Bag3}Vaz6';
            req.setEndpoint(endPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            Blob headerValue = Blob.valueOf(username + ':' + pwd);
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authorizationHeader);
            req.setBody(request);
            req.setTimeout(120000);

            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug('DEBUGGING RESPOSE: ' + res.getStatusCode() + ' > ' + res.getStatus() + '  >  ' + res.getBody());
            return res;
        } catch (Exception e) {
            System.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static CallbackWrapper getMachinesByCustomerNumber(String recordId){
        
        CallbackWrapper callback = new CallbackWrapper();
        Account account = [Select id, CCUST__c, FAM_Code__c From Account Where id =: recordId WITH SECURITY_ENFORCED];
        if(account == null){
            throw new AuraHandledException('Component only available on Account');
        }

        String customerNumber = String.valueOf(account.CCUST__c);
        String customerCenterFamCode = String.valueOf(account.FAM_Code__c);
        Boolean isSandbox = [SELECT IsSandbox FROM Organization LIMIT 1][0].IsSandbox;
        if(isSandbox){
            //Map fam codes from test to prod
            customerCenterFamCode = Util.switchFamCodeForMol(customerCenterFamCode);
        }

        if(customerNumber == null && customerCenterFamCode == null){
            callback.message = ('No data found');
            callback.status = 'error';
            return callback;
        }

        try {
            CustomerSpecifiction customSpec = new CustomerSpecifiction();
            customSpec.customerNumber = customerNumber;
            customSpec.customerCenterFamCode = customerCenterFamCode;
            MolDataRequest molReq = new MolDataRequest();
            molReq.getMachinesByCustomerNumber = customSpec;

            String jsonReq = JSON.serialize(molReq);

            if(jsonReq == null){
                return callback;
            }

            String endPoint = 'callout:azure_integration/mol/machine/proxy/v1/GetMachinesByCustomerNumber';
            HttpResponse res = apiCallout(jsonReq, endPoint);

            if(res.getBody().contains('error')){
                callback.message = 'No data found';
                callback.status = 'error';
                return callback;
            }

            Map<String, Object> customers = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            Map<String, Object>  a = (Map<String, Object>)customers.get('getMachinesByCustomerNumberResponse');
            Map<String, Object> b = (Map<String, Object>)a.get('getMachinesByCustomerNumberResult');
            List<Object> machines = (List<Object>)b.get('MachineItemNumbers');
            callback.message = JSON.serialize(machines);
            callback.status = 'success';
            return callback;
        } catch (Exception e) {
            System.debug(e.getMessage());
            callback.message = e.getMessage();
            callback.status = 'error';
            return callback;
            //throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static CallbackWrapper getMachineDetail(List<String> machineItems){
        List<MachineResponse> machineDetails = new List<MachineResponse>();
        CallbackWrapper callback = new CallbackWrapper();
        String endPoint = 'callout:azure_integration/mol/machine/proxy/v1/GetMachineById';
        try{
            for(String machineItem : machineItems){
                MachineRequest mreq = new MachineRequest();
                MachineId  mid = new MachineId();
                mid.machineId = machineItem;
                mreq.getMachineById = mid;
                String jsonMreq = JSON.serialize(mreq);                
                HTTPResponse res = apiCallout(jsonMreq, endPoint);
    
                if(res.getStatusCode() == 200){
                    JSONToMachineDetail machineFromJson = JSONToMachineDetail.parse(res.getBody());
                    JSONToMachineDetail.Machine machine = machineFromJson.getMachineByIdResponse.getMachineByIdResult.machine;
    
                    MachineResponse machineDetail = new MachineResponse();
                    machineDetail.modelName = machine.modelName;
                    machineDetail.serialNumber = machine.serialNumber;
                    machineDetail.businessLineFamCode = machine.businessLineFamCode;
                    machineDetail.productLine = machine.productLine;
                    machineDetail.commissioningDate = machine.commissioningDate;
                    machineDetail.worksite = machine.worksite;
                    
                    //System.debug(machineDetail);
                    switch on (machine.registrationStatus) {
                        when 4{
                            machineDetail.registrationStatus = 'Customer center received';
                        }
                        when 5 {
                            machineDetail.registrationStatus = 'Customer center shipped';
                        }
                        when 6 {
                            machineDetail.registrationStatus = 'Externally received';
                        }when 7 {
                            machineDetail.registrationStatus = 'Commissioned';
                        }
                        when else {
                            machineDetail.registrationStatus = '';
                        }
                     }
    
                     if(machine.serviceAgreement.serviceAgreementNumber != null){
                        machineDetail.serviceAgreement = machine.serviceAgreement.serviceAgreementNumber;
                     }
                     machineDetails.add(machineDetail);
                }             
            }

            System.debug('Out of loop and and assign data');
            System.debug(machineDetails);
            String jsonResonse = JSON.serialize(machineDetails);
            callback.message = jsonResonse;
            callback.status = 'success';
            return callback;
        }catch(Exception e){
            System.debug(e.getMessage());
            callback.message = e.getMessage();
            callback.status = 'error';
            return callback;
        }
       
    }

    public class MolDataRequest {
        CustomerSpecifiction getMachinesByCustomerNumber;  
    }

    public class CustomerSpecifiction {
        String customerNumber;
        String customerCenterFamCode;    
    }

    public class MachineRequest {
        MachineId getMachineById;
    }

    public class MachineId {
        String machineId;
    }

    public class MachineResponse {
        String modelName;
        String serialNumber;
        String registrationStatus;
        String businessLineFamCode;
        String productLine;
        String commissioningDate;
        String hours = 'Stay tuned';
        String hoursType = 'Stay tuned';
        String worksite;
        String serviceAgreement = 'NO';
    }

}