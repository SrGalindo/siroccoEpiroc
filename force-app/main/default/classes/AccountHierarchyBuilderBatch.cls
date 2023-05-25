global class AccountHierarchyBuilderBatch implements Schedulable {

    global void execute(SchedulableContext ctx){
        //buildHierarchy();
    }
    // public void buildHierarchy(){
    //     //Check if any Landing table records have been created. This implies that we need to create accounts to correspond.
        
    //     List<Landing_Table__c> newIntegrationRecords = [SELECT Id, Jsonfield__c FROM Landing_Table__c WHERE Name = 'AnyName'];
    //     if(newIntegrationRecords.size() > 0){
    //         Id customerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Customer').getRecordTypeId();
    //         Id shiptoRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Ship_To').getRecordTypeId();
    //         Id billToAddressTypeRecord = [SELECT Id FROM Address_Type__c WHERE Name = 'Bill-to' LIMIT 1].Id;
    //         Map<Integer, Address__c> custnoBillAddress= new Map<Integer, Address__c>();
    //         List<Account> newGlobalAccounts = new List<Account>();
    //         List<Address__c> custnoBillAddressList = new List<Address__c>();
    //         List<Account> newCustomerAccounts = new List<Account>();
    //         List<Account> newShiptoAccounts = new List<Account>();
    //         Map<Id, Account> landingTableToAccountMap = new Map<Id, Account>();
    //         //First run, create initial batch of new Accounts. Insert and use the AccId to set hierarchy later on.
    //         for(Landing_Table__c looper : newIntegrationRecords){
    //             if(looper.Jsonfield__c != null){
    //                 //Main mapping
    //                 CustomerTemplate customerTemplate = (CustomerTemplate)JSON.deserialize(looper.Jsonfield__c, CustomerTemplate.class);
    //                 Account customerAcc = AccountClass.mapAccountFields(customerTemplate);
    //                 customerAcc.RecordTypeId = customerRecordTypeId;
    //                 // customerAcc.Name = customerTemplate.cMname;
    //                 customerAcc.Import_tag__c = 'AP1';
    //                 //customerAcc.CC_Code__c = customerTemplate.cMname;
    //                 newCustomerAccounts.add(customerAcc);
    //                 landingTableToAccountMap.put(looper.id, customerAcc);
    //             }
    //         }
    //         insert newCustomerAccounts;
    //         for(Landing_Table__c looper : newIntegrationRecords){
    //             Id customerId = landingTableToAccountMap.get(looper.id).Id;
    //             if(looper.Jsonfield__c != null){
    //                 CustomerTemplate customerTemplate = (CustomerTemplate)JSON.deserialize(looper.Jsonfield__c, CustomerTemplate.class);
    //                 //Split customer to customer+billing address objects. 
    //                 Address__c billingAddress = new Address__c();
    //                 Id connectedAccountId = landingTableToAccountMap.get(looper.id).Id;

    //                 billingAddress.Address_Type__c = billToAddressTypeRecord;
    //                 billingAddress.Account__c = connectedAccountId;
    //                 billingAddress.Address_Line_1__c = customerTemplate.cMaddr1;
    //                 billingAddress.Import_tag__c = 'AP';
    //                 custnoBillAddress.put(customerTemplate.cMcustNo, billingAddress);
    //                 custnoBillAddressList.add(billingAddress);

    //                 //Ship tos
    //                 if(customerTemplate.Ship_tos.size() > 0){
    //                     for(CustomerTemplate.Ship_tos shipto : customerTemplate.ship_tos){
    //                         Account newShipToo = new Account();
    //                         newShipToo.Name = customerTemplate.cMname;
    //                         newShipToo.Customer__c = customerId;
    //                         newShipToo.RecordTypeId = shiptoRecordTypeId;
    //                         newShipToo.Import_tag__c = 'AP';
    //                         newShiptoAccounts.add(newShipToo);
    //                     }
    //                 }
    //             }
    //         }
    //         if(newShiptoAccounts.size() > 0) insert newShiptoAccounts;
    //         if(custnoBillAddressList.size() > 0) insert custnoBillAddressList;
    //     }
    //     //
    //     }
    
}