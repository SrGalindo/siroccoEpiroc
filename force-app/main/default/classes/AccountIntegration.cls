@RestResource(urlMapping='/Account/*')
global with sharing class AccountIntegration {

  @HttpPost
    global static String doPost() {
        RestRequest req = RestContext.request;
        Blob body = req.requestBody;
        String content = RestContext.request.requestBody.toString();
        System.debug('Find  me');
        System.debug(content);
        String requestString = body.toString();
        requestString = requestString.replaceAll('ship-tos', 'ship_tos');
        //System.debug(requestString);
        Id customerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Customer').getRecordTypeId();
        Id partnerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Partner').getRecordTypeId();
        Id prospectRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospect').getRecordTypeId();
        List<Country__c> countryList = [SELECT Id, Alpha_2_Code__c FROM Country__c];
        Map<String, Id> countryToIdMap = new Map<String, Id>();
        for(Country__c country : countryList){
            countryToIdMap.put(country.Alpha_2_Code__c, country.Id);
        }
    
        Id billToAddressTypeId;
        Id shipToAddressTypeId;
        List<Address_Type__c> addressTypes = [SELECT Id, Name FROM Address_Type__c];
        for(Address_Type__c type : addressTypes){
            if(type.name == 'Ship-to') shipToAddressTypeId = type.Id;
            if(type.name == 'Bill-to') billToAddressTypeId = type.Id;
        }
        list<CustomerTemplate> customerTemplates = (List<CustomerTemplate>)JSON.deserialize(requestString, List<CustomerTemplate>.class);
        System.debug('Amount of inc customers: '+customerTemplates.size());
        Set <Integer> incomingCustomerNo = new Set<Integer>();
        Set <String> incomingCustomerNoString = new Set<String>();
        Set <String> salesforceids = new Set<String>();
        Map<String, CustomerTemplate> uniqueStringToCustomerMap = new Map<String, CustomerTemplate>();
        Map<String, CustomerTemplate> uniqueStringToCustomerMapDynamic = new Map<String, CustomerTemplate>();
        for(CustomerTemplate looper : customerTemplates){
            System.debug('Kundnummer: '+looper.cMcustNo);
            System.debug('Kundnummer: '+looper.cMsalesforceID);
            incomingCustomerNo.add(looper.cMcustNo);
            incomingCustomerNoString.add(String.valueOf(looper.cMcustNo));
            String custnoAndFam = getUniqueCustomerTag(looper.cmCustNo, looper.cmfamCode);
            if(looper.cMsalesforceID  != null && looper.cMsalesforceID != '' && looper.cMsalesforceID != ' '){
                System.debug('Putting salesforce  id');
                salesforceids.add(looper.cMsalesforceID);
                uniqueStringToCustomerMap.put(looper.cMsalesforceID, looper);
                uniqueStringToCustomerMapDynamic.put(looper.cMsalesforceID, looper);
            } else {
                System.debug('Putting famcode');
                uniqueStringToCustomerMap.put(custnoAndFam, looper);
                uniqueStringToCustomerMapDynamic.put(custnoAndFam, looper);
            }
        }
        List<Account> accList1 = [SELECT Id, Ccust__c, FAM_Code__c, RecordTypeId FROM Account WHERE Ccust__c IN :incomingCustomerNoString];
        List<Account> accList2 = [SELECT Id, Ccust__c, FAM_Code__c, RecordTypeId FROM Account WHERE Id IN :salesforceids];
        accList1.addAll(accList2);
        Set<Account> uniqueAccs = new Set<Account>(accList1);
        List<Account> accList = new List<Account> (uniqueAccs);
        List<Account> upsertAccounts = new List<Account>();
        if(accList.size() >0){
            //Existing accounts handler
            for(Account accLooper : accList){
                System.debug('Acc id i början: '+accLooper.Id);
                String custnoAndFam = getUniqueCustomerTag(accLooper.CCUST__c, accLooper.FAM_Code__c);
                System.debug('1an: '+custnoAndFam);
                if (uniqueStringToCustomerMap.containsKey(accLooper.Id)){
                    CustomerTemplate currentCT = uniqueStringToCustomerMap.get(accLooper.Id);
                    System.debug('Unik existerande kund (Via salesforce id): '+custnoAndFam);
                    Id savedId = accLooper.Id;
                    String customerCountryCode = currentCT.cMcountry;
                    String custFamCode = currentCT.cMcustFam;
                    String famCode = currentCT.cMfamCode;
                    String calculatedCountryCode = FieldMappingTables.getTwoCharCountryCodeWithBackup(customerCountryCode, custFamCode,  famCode);
                    Id countryId = countryToIdMap.get(calculatedCountryCode);
                    accLooper = mapAccountFields(currentCT, accLooper, countryId, customerRecordTypeId, partnerRecordTypeId, prospectRecordTypeId);
                    accLooper.Id = savedId;
                    upsertAccounts.add(accLooper);
                    System.debug('Acc id: '+accLooper.Id);
                    System.debug('Removing: '+accLooper.Id);
                    uniqueStringToCustomerMapDynamic.remove(accLooper.Id);
                    System.debug('removed?: '+uniqueStringToCustomerMapDynamic.get(accLooper.Id));
                }
                else if(uniqueStringToCustomerMap.containsKey(custnoAndFam)){
                    CustomerTemplate currentCT = uniqueStringToCustomerMap.get(custnoAndFam);
                    Id savedId = accLooper.Id;
                    String customerCountryCode = currentCT.cMcountry;
                    String custFamCode = currentCT.cMcustFam;
                    String famCode = currentCT.cMfamCode;
                    System.debug('Unik existerande kund: '+custnoAndFam);
                    String calculatedCountryCode = FieldMappingTables.getTwoCharCountryCodeWithBackup(customerCountryCode, custFamCode,  famCode);
                    Id countryId = countryToIdMap.get(calculatedCountryCode);
                    accLooper = mapAccountFields(currentCT, accLooper, countryId, customerRecordTypeId, partnerRecordTypeId, prospectRecordTypeId);
                    accLooper.Id = savedId;
                    upsertAccounts.add(accLooper);
                    System.debug('Acc id: '+accLooper.Id);
                    System.debug('Removing: '+custnoAndFam);
                    uniqueStringToCustomerMapDynamic.remove(custnoAndFam);
                    System.debug('removed?: '+uniqueStringToCustomerMapDynamic.get(custnoAndFam));
                }
            }
        }
        //Dynamic map now only contains new customers that need to be inserted.
        for(CustomerTemplate ct : uniqueStringToCustomerMapDynamic.values()){
            if(ct.cMIbosEvent == '2' || ct.cMrecordID == 'CZ'){
                System.debug('Dead/deleted customer. Aborting');
                continue;
            }
            String custnoAndFam = getUniqueCustomerTag(ct.cmCustNo, ct.cMfamCode);
            System.debug('2an: '+custnoAndFam);
            String customerCountryCode = ct.cMcountry;
            String calculatedCountryCode = FieldMappingTables.getTwoCharCountryCodeWithBackup(customerCountryCode, ct.cMcustFam, ct.cMfamCode);
            Id countryId = countryToIdMap.get(calculatedCountryCode);
            Account newAccount = mapAccountFields(ct, null, countryId, customerRecordTypeId, partnerRecordTypeId, prospectRecordTypeId);
            upsertAccounts.add(newAccount);
        }
        String returner = 'success';
        Boolean anyError = false;
        List<Apex_log__c> logList = new List<Apex_log__c>();
        if(upsertAccounts.size() > 0) {
            Database.UpsertResult[] results = Database.Upsert(upsertAccounts, false);
            for(Integer index = 0, size = results.size(); index < size; index++) {
                if(!results[index].isSuccess()) {
                    returner = 'error';
                    anyError = true;
                    System.debug('Error in customerNo: '+upsertAccounts[index].Ccust__c +  ' Unitcode: '+upsertAccounts[index].FAM_code__c);
                    for(Database.Error err : results[index].getErrors()) {
                    System.debug('The following Account error has occurred.');                
                    System.debug(err.getFields());                
                    System.debug(err.getMessage());                
                    returner += (': ' + err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                    Apex_log__c log = new Apex_log__c();
                    log.name = 'Account log';
                    log.Unit_code__c = upsertAccounts[index].FAM_Code__c;
                    log.ccust__c = upsertAccounts[index].ccust__c;
                    log.log__c += '     Account info. CustomerNo: '+upsertAccounts[index].Ccust__c +' Unitcode: '+upsertAccounts[index].FAM_Code__c;
                    log.Full_Record_Representation__c = JSON.Serialize(upsertAccounts[index]);
                    logList.add(log);
                    }
                }
                }
            // for(Database.upsertResult resultLooper : result){
            //     if (!resultLooper.isSuccess()) {
            //             returner = 'error';
            //             anyError = true;
            //         for(Account acc : upsertAccounts){
            //             System.debug('Acc name: '+acc.Name +' Unitcode: '+acc.fam_code__c +' CustNo: '+acc.ccust__c);
            //         }
            //         for(Database.Error err : resultLooper.getErrors()) {
            //             System.debug('The following error has occurred.');                
            //             System.debug(err.getFields());                
            //             System.debug(err.getMessage());                
            //             returner += (': ' + err.getStatusCode() + ': ' + err.getMessage());
            //             System.debug('Account fields that affected this error: ' + err.getFields());
            //             Apex_log__c log = new Apex_log__c();
            //             log.name = 'Account log';
            //             log.log__c = err.getFields() + err.getMessage() + '    Possible account failures: ';
            //             for(Account acc : upsertAccounts){
            //                 log.log__c += 'Acc name: '+acc.Name +' Unitcode: '+acc.fam_code__c +' CustNo: '+acc.ccust__c;
            //             }
            //             logList.add(log);
            //            }
            //         }
            // }
        }
        if(logList.size() >0){
            insert logList;
        }
        Map<Id, Address__c> existingAddresses = new Map<Id, Address__c>([SELECT Id, Account__r.Id, Account__r.Ccust__c, Ccust__c, Fam_code__c, Ship_to_Number__c, Address_Type__r.name FROM Address__c WHERE Account__c IN :upsertAccounts]);
        //Generate unique string for getting a specific address.
        Map<String, Address__c> uniqueStringToAddressMap = new Map<String, Address__c>();
        for(Address__c addr : existingAddresses.values()){
            String uniqueString;
            if(addr.Ship_to_Number__c != null) {
                //Found existing ship-to
                uniqueString = addr.Account__r.Ccust__c + addr.account__c + addr.Ship_to_Number__c;
                uniqueStringToAddressMap.put(uniqueString, addr);
            }
            //Found existing bill-to
            //It's important we only get 1 Salesforce bill-to here, as we can only sync one bill-to down.
            //This integration is setting fam code. Nowhere else will this happen as this attribute is only relevant on account.
            else if(addr.Address_Type__r.name == 'Bill-to' && addr.FAM_Code__c != null){
                uniqueString = addr.Ccust__c + addr.Fam_code__c;
                uniqueStringToAddressMap.put(uniqueString, addr);
            }
            // if(addr.Address_Type__r.name == 'Ship-to'){
            // }
            // else if(addr.Address_Type__r.name == 'Bill-to' && addr.FAM_Code__c != null){
            // }
        }
        //Prequeries done. Now loop incoming accounts and check addresses
        List<Address__c> upsertAddresses = new List<Address__c>();
        for(Account accLooper : upsertAccounts){
            String custnoAndFam = getUniqueCustomerTag(accLooper.ccust__c, accLooper.FAM_Code__c);
            CustomerTemplate ct = uniqueStringToCustomerMap.get(custnoAndFam);
            if(ct  == null){
                ct = uniqueStringToCustomerMap.get(accLooper.Id);
            }
            //Ship-to to Ship-to Address__c mapping.
            if(ct == null) return 'Provided Salesforce ID does not exist';
            if(ct.ship_tos != null){
                System.debug('Ship-to amount: '+ct.ship_tos.size());
                System.debug('Customer shiptos:  '+ct.ship_tos.size());
             if(ct.ship_tos.size() > 0){
                for(CustomerTemplate.Ship_tos shipto : ct.ship_tos){
                    System.debug('Ok kör');
                    System.debug(shipto.sTaddr1);
                    System.debug(shipto.sTcountry);
                    System.debug(shipto.sTshipToNo);
                    String unique = String.valueOf(ct.cMcustNo) + accLooper.Id + String.valueOf(shipto.sTshipToNo);
                    Address__c addr = mapShiptoFieldsToAddress(ct, shipto, accLooper.Id, shipToAddressTypeId, ct.cMcustFam, ct.cmfamCode, ct.cmCustNo);
                    //Find if existing address exist. If so; give addr its id. We dont fully trust the address unique tag, so doublecheck account id.
                    if(uniqueStringToAddressMap.get(unique) != null){
                        if(uniqueStringToAddressMap.get(unique).Account__c == accLooper.Id){
                            Id existingId = uniqueStringToAddressMap.get(unique).Id;
                            addr.Id = existingId;
                        }
                    }
                    
                    upsertAddresses.add(addr);
                }
            }
        }

        //Customer address to Bill-to Address mapping.
        //Existing Address
        String addressUniqueString = accLooper.Ccust__c + accLooper.Fam_code__c;
        String addressAccountId = accLooper.Id;
        Address__c existingAddress;
        if(uniqueStringToAddressMap.get(addressUniqueString) != null){
            existingAddress = uniqueStringToAddressMap.get(addressUniqueString);
        }
        // else 
        // if(uniqueStringToAddressMap.get(addressAccountId) != null){
        //     existingAddress = uniqueStringToAddressMap.get(addressAccountId);
        // }
        if(existingAddress != null){
            Id savedId = existingAddress.Id;
            String customerCountryId = countryToIdMap.get(ct.cMcountry);
            existingAddress = mapBillingAddressFields(ct, billToAddressTypeId, accLooper.Id, customerCountryId);
            existingAddress.Id = savedId;
            upsertAddresses.add(existingAddress);
        }
        //New Address
        else{
            String customerCountryId = countryToIdMap.get(ct.cMcountry);
            Address__c newBillingAddress = mapBillingAddressFields(ct, billToAddressTypeId, accLooper.Id, customerCountryId);
            upsertAddresses.add(newBillingAddress);
        }
        }
        List<Apex_Log__c> logListAddress = new List<Apex_Log__c>();
        //if(upsertAddresses.size() > 0) upsert upsertAddresses;
        if(upsertAddresses.size() > 0) {
            Database.UpsertResult[] results = Database.Upsert(upsertAddresses, false);
            for(Integer index = 0, size = results.size(); index < size; index++) {
                if(!results[index].isSuccess()) {
                    returner = 'error';
                    anyError = true;
                    for(Database.Error err : results[index].getErrors()) {
                    System.debug('The following Address error has occurred.');                
                    System.debug(err.getFields());                
                    System.debug(err.getMessage());                
                    returner += (': ' + err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Address fields that affected this error: ' + err.getFields());
                    Apex_log__c log = new Apex_log__c();
                    log.name = 'Address log';
                    log.Unit_code__c = upsertAddresses[index].FAM_Code__c;
                    log.ccust__c = upsertAddresses[index].ccust__c;
                    log.Time_registered__c = Datetime.now();
                    log.log__c = '     Address info. Fields: ' +err.getFields() + ' Message: '+err.getMessage();
                    log.Full_Record_Representation__c = JSON.Serialize(upsertAddresses[index]);
                    logListAddress.add(log);
                    }
                }
            }
            // for(Database.upsertResult resultLooper : result){
            //     if (!resultLooper.isSuccess()) {
            //         returner = 'error';
            //         anyError =  true;
            //         for(Database.Error err : resultLooper.getErrors()) {
            //             System.debug('The following error has occurred.');                    
            //             returner += (': ' + err.getStatusCode() + ': ' + err.getMessage());
            //             System.debug('Address fields that affected this error: ' + err.getFields());
            //             Apex_log__c log = new Apex_log__c();
            //             log.name = 'Address log';
            //             log.log__c = 'Address error. '+err.getFields() + err.getMessage();
            //             logListAddress.add(log);
            //            }
            //         }
            // }
        }
        if(logListAddress.size() > 0){
            insert logListAddress;
        }
        if(customerTemplates.size() == 1 && anyError == true){
            //throw new DmlException(returner);
        }
        return returner;
    }
    
   
    public static Account mapAccountFields(CustomerTemplate customerTemplate, Account existingAcc, Id countryId, Id customerRecordTypeId, Id partnerRecordTypeId, Id prospectRecordTypeId){
        System.debug('Name22: '+customerTemplate.cMname);
        //String customerCountryCode = customerTemplate.cMcountry;
        //String famCode = customerTemplate.cMcustFam;
        //String calculatedCountryCode = FieldMappingTables.getTwoCharCountryCodeWithBackup(customerCountryCode, famCode);
        Account acc = new Account();
        if(existingAcc != null){
            //Prospect mapping will be done only once: when a prospect is converted.
            if(existingAcc.RecordTypeId == prospectRecordTypeId){
                // if(FieldMappingTables.usePartnerMapping(customerTemplate.cMsalesmanName)){
                //     acc.RecordTypeId = partnerRecordTypeId;
                // } else 
                acc.RecordTypeId = customerRecordTypeId;
            }
        }
        //For insertions, use basic record type mapping.
        else {
            // if(FieldMappingTables.usePartnerMapping(customerTemplate.cMsalesmanName)){
            //     acc.RecordTypeId = partnerRecordTypeId;
            // } else 
            acc.RecordTypeId = customerRecordTypeId;
        }
        acc.Country__c = countryId;
        acc.import_tag__c = 'A4';
        acc.ERP_Sync__c = true;
        acc.FAM_Code__c  = customerTemplate.cMfamCode;
        if(customerTemplate.cMIbosEvent != null) acc.External_State__c = FieldMappingTables.getExternalState(customerTemplate.cMIbosEvent, customerTemplate.cMrecordID);
        if(customerTemplate.cMname != null) acc.Name = customerTemplate.cMname;
        if(customerTemplate.cMfamCode != null) acc.FAM_Code__c = customerTemplate.cMfamCode;
        if(customerTemplate.cMcustNo != null) acc.Ccust__c = String.valueOf(customerTemplate.cMcustNo);
        if(customerTemplate.cMphoneNo != null) acc.Phone = customerTemplate.cMphoneNo;
        if(customerTemplate.cMOpenOrderAmt != null) acc.Open_Order_Amount__c = customerTemplate.cMOpenOrderAmt;
        if(customerTemplate.cMterms != null) acc.Payment_Terms__c = FieldMappingTables.paymentTermsMapping(customerTemplate.cMterms,customerTemplate.cMfamCode);
        if(customerTemplate.cMytdSalesAmt != null) acc.YTD_Sales_Amount__c = customerTemplate.cMytdSalesAmt;
        if(customerTemplate.cMamountDue != null) acc.Accounts_Receivable_Open_Invoices_Total__c = customerTemplate.cMamountDue;
        if(customerTemplate.cMCurrency != null) acc.CurrencyIsoCode = FieldMappingTables.currencyMapping(customerTemplate.cMCurrency);
        if(customerTemplate.cMnaicsCode != null) acc.NAICS__c = customerTemplate.cMnaicsCode;
        if(customerTemplate.cMtype != null) acc.Customer_Type__c = customerTemplate.cMtype;
        if(customerTemplate.cMshopOnline != null) {
            if(customerTemplate.cMshopOnline == 'Yes' || customerTemplate.cMshopOnline == 'yes') acc.ShopOnline_customer__c = true;
            else acc.ShopOnline_customer__c = false;
        }
        //New field mappings since 10 nov
        if(customerTemplate.cMsic != null) acc.Sic = customerTemplate.cMsic;
        if(customerTemplate.cMcreditLimit != null) acc.Amount_Credit_Limit__c = customerTemplate.cMcreditLimit;
        if(customerTemplate.cMmtdSalesAmt != null) acc.MTD_Sales_Amount__c = customerTemplate.cMmtdSalesAmt;
        if(customerTemplate.cMlastYTDSalesAmt != null) acc.Last_YTD_Sales_Amount__c = customerTemplate.cMlastYTDSalesAmt;
        if(customerTemplate.cMytdCostSales != null) acc.YTD_Cost_of_Sales__c = customerTemplate.cMytdCostSales;
        if(customerTemplate.cMlastYTDCostSales != null) acc.Last_YTD_Cost_of_Sales__c = customerTemplate.cMlastYTDCostSales;
        if(customerTemplate.cMmtdCostSales != null) acc.MTD_Cost_of_Sales__c = customerTemplate.cMmtdCostSales;
        if(customerTemplate.cMtaxCode != null) acc.Customer_Tax_Code__c = customerTemplate.cMtaxCode;
        if(customerTemplate.cMdunNo != null) acc.DUNS__c = customerTemplate.cMdunNo;
        if(customerTemplate.cMfaxNo != null) acc.Fax = customerTemplate.cMfaxNo;
        //if(customerTemplate.cMemail != null) acc.Email__c = FieldMappingTables.emailMapping(customerTemplate.cMemail);
        if(customerTemplate.cMInterCompanyFlag != null) acc.IntercompanyFlag__c = customerTemplate.cMInterCompanyFlag;
        //if(customerTemplate.cMdunNo != null) acc.Last_YTD_Sales_Amount__c = Decimal.valueOf(customerTemplate.cMdunNo);
        //if(customerTemplate.cMCurrency != null) acc.CurrencyIsoCode = String.valueOf(customerTemplate.cMCurrency);
        return acc;

    }
    public static Account mapShiptoFieldsToAccount(CustomerTemplate.Ship_tos integrationShipTo, Id shiptoRecordTypeId, Id connectedAccountId){
        Account acc = new Account();
        acc.Name = integrationShipTo.sTname;
        acc.Ship_to_Number__c = integrationShipTo.sTshipToNo;
        acc.Customer__c = connectedAccountId;
        acc.ParentId = connectedAccountId;
        acc.RecordTypeId = shiptoRecordTypeId;
        acc.Import_tag__c = 'A1';
        return acc;
    }
    public static Address__c mapShiptoFieldsToAddress(CustomerTemplate ct, CustomerTemplate.Ship_tos integrationShipTo, Id connectedAccountId, Id addressTypeId, String custFamCode, String famCode, Integer ccust){
        String calculatedCountryCode = FieldMappingTables.getTwoCharCountryCodeWithBackup(ct.cMcountry, custFamCode, famCode);
        Address__c addr = new Address__c();
        System.debug('mapShiptoFieldsToAddress');
        if(connectedAccountId != null) {
            addr.Account__c = connectedAccountId;
        } else {
            addr.Account__c = 'Account was not inserted. Aborting';
            System.debug('Failing customer template:');
            System.debug(ct);
        }
        addr.Address_Type__c = addressTypeId;
        //Address type fields
        if(integrationShipTo.sTaddr1 != null) addr.Address__Street__s = integrationShipTo.sTaddr1;
        if(integrationShipTo.sTaddr3 != null) addr.Address__City__s = integrationShipTo.sTaddr3;
        //if(integrationShipTo.sTstate != null) addr.Address__StateCode__s = integrationShipTo.sTstate;
        if(integrationShipTo.sTcountry != null) addr.Address__countryCode__s = calculatedCountryCode;
        System.debug('countryCode: '+addr.Address__CountryCode__s);
        System.debug('Billing original country: '+ct.cMcountry);

        if(integrationShipTo.sTpostCode != null) addr.Address__postalCode__s = integrationShipTo.sTpostCode;
        //State
        if(integrationShipTo.sTstate != null && integrationShipTo.sTstate != '.' && integrationShipTo.sTstate != '') {
            addr.State__c = integrationShipTo.sTstate;
            if(FieldMappingTables.countryWithRegionMapping(calculatedCountryCode)){
                addr.Address__StateCode__s = FieldMappingTables.stateMapping(integrationShipTo.sTstate);
            }
        }
        //Text type address fields
        if(integrationShipTo.sTaddr1 != null) addr.Address_Line_1__c = integrationShipTo.sTaddr1;
        if(integrationShipTo.sTaddr2 != null) addr.Address_Line_2__c = integrationShipTo.sTaddr2;
        if(integrationShipTo.sTaddr3 != null) addr.Address_Line_3__c = integrationShipTo.sTaddr3;
        if(integrationShipTo.sTshipToNo != null) addr.Ship_to_Number__c = integrationShipTo.sTshipToNo;
        if(integrationShipTo.sTpostCode != null) addr.Postal_code__c = integrationShipTo.sTpostCode;
        addr.FAM_Code__c = famCode;
        addr.Ccust__c = String.valueOf(ccust);
        addr.Import_tag__c = 'A1';
        return addr;
    }
    public static Address__c mapBillingAddressFields(CustomerTemplate customerTemplate, Id billToAddressTypeId, Id connectedAccountId, Id countryId){
        Address__c billingAddress = new Address__c();
        if(connectedAccountId != null) {
            billingAddress.Account__c = connectedAccountId;
        } else {
            billingAddress.Account__c = 'Account was not inserted. Aborting';
            System.debug(customerTemplate);
        }
        billingAddress.Address_Type__c = billToAddressTypeId;
        String calculatedCountryCode = FieldMappingTables.getTwoCharCountryCodeWithBackup(customerTemplate.cMcountry, customerTemplate.cMcustFam, customerTemplate.cMfamCode);
         //Address type fields
        if(customerTemplate.cMaddr1 != null) billingAddress.Address__Street__s = customerTemplate.cMaddr1;
        if(customerTemplate.cMaddr2 != null) billingAddress.Address__City__s = customerTemplate.cMaddr2;
        if(customerTemplate.cMcountry != null) billingAddress.Address__countryCode__s = calculatedCountryCode;
        System.debug('Billing countryCode: '+billingAddress.Address__CountryCode__s);
        System.debug('Billing original country: '+customerTemplate.cMcountry);
        if(customerTemplate.cMpostCode != null) billingAddress.Address__postalCode__s = customerTemplate.cMpostCode;
        //Text type address fields
        billingAddress.Country__c = countryId;
        if(customerTemplate.cMaddr1 != null) billingAddress.Address_Line_1__c = customerTemplate.cMaddr1;
        if(customerTemplate.cMaddr2 != null) billingAddress.Address_Line_2__c = customerTemplate.cMaddr2;
        if(customerTemplate.cMaddr3 != null) billingAddress.Address_Line_3__c = customerTemplate.cMaddr3;
        if(customerTemplate.cMpostCode != null) billingAddress.Postal_code__c = customerTemplate.cMpostCode;
        //State mapping
        //if(customerTemplate.cMstate != null && customerTemplate.cMstate != '.' && customerTemplate.cMstate != '' && customerTemplate.cMcountry == 'US') {
        if(customerTemplate.cMstate != null && customerTemplate.cMstate != '.' && customerTemplate.cMstate != '') {
            billingAddress.State__c = customerTemplate.cMstate;
            //Map only state for these countries. State__c is freetext and will work anyway.
            if(FieldMappingTables.countryWithRegionMapping(calculatedCountryCode)){
                billingAddress.Address__StateCode__s = FieldMappingTables.stateMapping(customerTemplate.cMstate);
            }
        }
        //billingAddress.Primary__c = true;
        billingAddress.Import_tag__c = 'A1';
        billingAddress.Fam_code__c = customerTemplate.cmfamCode;
        billingAddress.Ccust__c = String.valueOf(customerTemplate.cMcustNo);
        return billingAddress;

    }
    public static String getUniqueCustomerTag(Integer ccust, String fam){
        return String.valueOf(ccust) + fam;
    }
    public static String getUniqueCustomerTag(String ccust, String fam){
        return ccust + fam;
    }
}