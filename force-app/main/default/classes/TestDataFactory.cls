@isTest
public class TestDataFactory {
    
    // public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
    //     List<Account> accts = new List<Account>();
    //     for(Integer i=0;i<numAccts;i++) {
    //         Account a = new Account(Name='TestAccount' + i);
    //         accts.add(a);
    //     }
    //     insert accts;
    //     List<Opportunity> opps = new List<Opportunity>();
    //     for (Integer j=0;j<numAccts;j++) {
    //         Account acct = accts[j];
    //         // For each account just inserted, add opportunities
    //         for (Integer k=0;k<numOppsPerAcct;k++) {
    //             opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
    //                                    StageName='Prospecting',
    //                                    CloseDate=System.today().addMonths(1),
    //                                    AccountId=acct.Id));
    //         }
    //     }
    //     // Insert all opportunities for all accounts.
    //     insert opps;
    //     return accts;
    // }
    
    // public static List<Opportunity> createOpportunitiesWithAccount(Integer numOpps) {
    //     Account acct = new Account(Name='TestAccount');
    //     insert acct;
    //     List<Opportunity> opps = new List<Opportunity>();
        
    //     for (Integer j=0;j<numOpps;j++) {
    //             opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + j,
    //                                    StageName='Prospecting',
    //                                    CloseDate=System.today().addMonths(1),
    //                                    AccountId=acct.Id));
    //     }
    //     insert opps;
    //     return opps;
    // }

    public static Opportunity createOppWithAccountWithAddress(String flavour) {
        return createOppWithTypeWithAccountWithAddress(flavour, 'Simple Opportunity');
        /*
        Country__c spain = new Country__c();
        spain.Alpha_2_Code__c = 'ES';
        insert spain;
        String genName = 'TestAccount' +flavour;
        Account acct = new Account(Name=genName);
        acct.Country__c = spain.id;
        List<Account> accList = [SELECT Id, Name FROM Account];
        System.debug('Size of acc');
        System.debug(accList.Size());
        System.debug('New acc');
        System.debug(acct);
        for(Account acc : accList){
            System.debug('Existing accs');
            System.debug(acc);
        }
        insert acct;
        
       
        Address__c addr = createSingelAddress(acct, spain.id);
        Address__c billToAddr = createSingleBilltoAddress(acct, spain.id);
        Opportunity opp = new Opportunity();
        
        opp.Name = 'Test Name 23'; 
        opp.StageName='New';
        opp.RecordTypeId=Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosByName().get('Simple Opportunity').getRecordTypeId();
        opp.CloseDate=System.today().addMonths(1);
        opp.AccountId=acct.Id;
        opp.Pricebook2Id = Test.getStandardPricebookId();
        opp.Bill_To__c = billToAddr.Id;
        opp.Ship_To__c = addr.Id;
        opp.CurrencyIsoCode = 'EUR';
        System.debug('opp.AccountId: '+opp.AccountId);
        insert opp;
        System.debug('OKOK');
        System.debug(opp.Pricebook2Id);
        System.debug(opp.id);
        System.debug(opp.name);
        return opp;

         */
    }

    public static List<Address__c> createAddressesWithoutInsert(){
        Country__c portugal = new Country__c();
        portugal.Alpha_2_Code__c = 'PT';
        insert portugal;
        List<Address__c> returnList = new List<Address__c>();
        Address__c addr = new Address__c();
        addr.Address__CountryCode__s = 'AX';
        addr.Country_code_3__c = 'AFG';
        addr.Country__c = portugal.id;
        returnList.add(addr);
        return returnList;
    }
    
    public static Event createEvent(){
        List<Event> returnList = new List<Event>();
        
        Country__c spain = new Country__c();
        spain.Alpha_2_Code__c = 'ES';
        insert spain;
        Account parentAcct = new Account(Name='Test Parent Account22');
        parentAcct.Country__c = spain.id;
        insert parentAcct;
        Account acct = new Account(Name='TestAccount',parentId=parentAcct.Id);
        acct.Country__c = spain.id;
        insert acct;
        
        Event evnt = new Event();
        evnt.StartDateTime = Date.TODAY();
        evnt.EndDateTime = Date.TODAY()+1;
        evnt.Subject = 'Test Event';
        evnt.WhatId = acct.Id;
        insert evnt;
        
        return evnt;
    }
    
    public static Task createTask(){
        Country__c spain = new Country__c();
        spain.Alpha_2_Code__c = 'ES';
        insert spain;
        Account parentAcct = new Account(Name='Test Parent Account');
        parentAcct.country__c = spain.id;
        insert parentAcct;
        Account acct = new Account(Name='TestAccount',parentId=parentAcct.Id);
        acct.country__c = spain.id;
        insert acct;
        
        Task tsk = new Task();
        tsk.OwnerId = UserInfo.getUserId();
        tsk.Type = 'Call';
        tsk.Subject = 'Test Task';
        tsk.Status = 'Not started';
        tsk.Priority = 'Normal';
        tsk.WhatId = acct.Id;
        insert tsk;
        
        return tsk;
    }
    
    public static Stakeholder__c createStakeholderWithoutCreate(){
        
        Stakeholder__c stk = new Stakeholder__c(Name='Test Stakeholderr');
        return stk;
    }

    public static Account createAccountWithoutCreate(){
        
        Account acct = new Account(Name='TestAccount');
                
        return acct ;
    }

    public static Address__c createSingelAddress(Account acc, Id countryId){
        Address__c addr = new Address__c();
        Address_Type__c type =  new Address_Type__c();
        type.name = 'Ship-to';
        insert type;
        addr.Address_Type__c = type.id;
        addr.Address__Street__s = 'Drottninggatan 92';
        addr.Address__PostalCode__s = '111 36';
        addr.Address__CountryCode__s = 'SE';
        addr.Address__City__s = 'Stockholm';
        addr.Account__c = acc.Id;
        addr.Country__c = countryId;
        insert addr;
        return addr;
    }
    public static Address__c createSingleBilltoAddress(Account acc, Id countryId){
        Address__c addr = new Address__c();
        Address_Type__c type =  new Address_Type__c();
        type.name = 'Bill-to';
        insert type;
        addr.Address_Type__c = type.id;
        addr.Address__Street__s = 'Drottninggatan 92';
        addr.Address__PostalCode__s = '111 36';
        addr.Address__CountryCode__s = 'SE';
        addr.Address__City__s = 'Stockholm';
        addr.Account__c = acc.Id;
        addr.Country__c = countryId;
        insert addr;
        return addr;
    }

    public static Account createSingelAccount(){
        Country__c spain = new Country__c();
        spain.Alpha_2_Code__c = 'ES';
        insert spain;
        Account acct = new Account(
            Name='TestAccount',
            CCUST__c = '220005', 
            FAM_Code__c = 'ZAT',
            Country__c = spain.id);
            insert acct;
            Address__c addr = createSingelAddress(acct, spain.id);
        return acct;
    }
    public static Account createAccountWithAddresses(){
        Country__c spain = new Country__c();
        spain.Alpha_2_Code__c = 'ES';
        insert spain;
        Account acct = new Account(
            Name='TestAccount',
            CCUST__c = '220005', 
            FAM_Code__c = 'ZAM',
            Country__c = spain.id);
        insert acct;
        Address__c addr = createSingelAddress(acct, spain.id);
        createSingleBilltoAddress(acct, spain.id);
        createSingelAddress(acct, spain.id);
        return acct;
    }

    public static List<Account> createAccountsForAccountIntegration(Integer numbOfAccounts){
        List<Account> accounts = new List<Account>();
        Country__c zambia = new Country__c();
        zambia.Alpha_2_Code__c = 'ZA';
        insert zambia;
        for(Integer i = 0; i < numbOfAccounts; i++){
            Account acct = new Account(
                Name='TestAccount Nr.' + String.valueOf(i),
                CCUST__c = '4830', 
                FAM_Code__c = 'ZAT',
                Country__c = zambia.id);
                Address__c addr = createSingelAddress(acct, zambia.id);
            accounts.add(acct);
        }

        insert accounts;
        return accounts;
    }

    public static List<Visit_Report__c> createVisitReports(Integer numbOfVisitReport){
        Account account = createSingelAccount();
        List<Visit_Report__c> visitReports = new List<Visit_Report__c>();
        for(Integer i = 1; i <= numbOfVisitReport; i++){
            Visit_Report__c vr = new Visit_Report__c(
                Name = 'Test VR Nr.' + String.valueOf(i),
                Reason_for_visit__c = 'test report test ' + String.valueOf(i),
                Account__c = account.Id
            );
            visitReports.add(vr);
        }
        insert visitReports;
        return visitReports;
    }

    public static List<Task> createTaskWithVisitReports(Integer numbOfTasks, Set<Id> visitReportIds){
        List<Task> taskForinsert = new List<Task>();
        for(Id vrId : visitReportIds){
            List<Task> vrTasks = new List<Task>();
            for(Integer i = 1; i <= numbOfTasks; i++){
                Task vrTask = new Task(
                WhatId = vrId,
                Status = 'Not started',
                Subject = 'Task report nr.' + string.valueOf(i)
                );
                vrTasks.add(vrTask);
            }
            taskForinsert.addAll(vrTasks);
        }
        insert taskForinsert;
        return taskForinsert;
    }
    
    public static Quote createQuote(Account acc, Opportunity opp) {
        Quote qt = new Quote(Name='TestQuote',OpportunityId=opp.Id);
        insert qt;
        return qt;

    }
    public static Quote createQuoteWithOppOld() {
        
        Opportunity opp = createOppWithAccountWithAddress('createQuoteWithOppOld');
        
        Quote qt = new Quote(Name='TestQuote',OpportunityId=opp.Id);
        insert qt;
        
        return qt;
    }
    public static Opportunity createOpportunity(Account acc){
        Opportunity opp = new Opportunity();
        opp.StageName = 'New';
        opp.RecordTypeId=Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosByName().get('Simple Opportunity').getRecordTypeId();
        opp.CloseDate=System.today().addMonths(1);
        opp.AccountId = acc.Id;
        insert opp;
        return opp;
    }
    public static Product2 createProductWithPricebookEntry() {
        Opportunity opp = createOppWithAccountWithAddress('createProductWithPricebookEntry');
        
        Product2 product = new Product2();
        product.Name = 'Simple Item';
        product.IsActive = true;
        insert product;
        
        Pricebook2 book = new Pricebook2();
        book.Name = 'Test Price Book';
        book.isActive = true;
        insert book;
        
        PricebookEntry entry = new PricebookEntry();
        entry.Product2Id = product.Id;
        entry.Pricebook2Id = Test.getStandardPricebookId();
        entry.IsActive = true;
        entry.CurrencyIsoCode = 'EUR';
        entry.UnitPrice = 1000;
        insert entry;
        
        return product;
    }
    
    public static QuoteLineItem createQuoteLineItem() {
        Opportunity opp = createOppWithAccountWithAddress('createQuoteLineItem');
        
        Product2 product = new Product2();
        product.Name = 'Simple Item';
        product.IsActive = true;
        insert product;
        
        // Pricebook2 book = new Pricebook2();
        // book.Name = 'Test Price Book';
        // book.isActive = true;
        // insert book;
        
        PricebookEntry entry = new PricebookEntry();
        entry.Product2Id = product.Id;
        entry.Pricebook2Id = Test.getStandardPricebookId();
        entry.IsActive = true;
        entry.UnitPrice = 1000;
        entry.CurrencyIsoCode = 'EUR';
        insert entry;
        
        
        Quote newQuote = new Quote();
        newQuote.Name = 'Test Quote';
        newQuote.OpportunityId = opp.Id;
        newQuote.Pricebook2Id = Test.getStandardPricebookId();
        insert newQuote;
        
        QuoteLineItem item = new QuoteLineItem();
        item.Product2Id = product.Id;
        item.QuoteId = newQuote.Id;
        item.Quantity = 1;
        item.UnitPrice = 7053.318;
        item.discount = 0;
        item.PricebookEntryId = entry.Id;
        insert item;
        
        return item;
    }
    public static user buildUserForTriggerTest(String uniquenessFlavour){
        User user = buildUserWithoutInsert(uniquenessFlavour);
        connectEpirocStandardProfile(user);
        return user;
    }
    public static User buildUserWithoutInsert(String uniquenessFlavour){
        User user = new User();
        user.Lastname = 'lastname';
        user.Email = 'fakemail@fake.com';
        user.Username = uniquenessFlavour + 'fakemail@fake.com';
        user.TimeZoneSidKey='America/Los_Angeles';
        user.EmailEncodingKey='UTF-8';
        user.Alias = 't'+uniquenessFlavour;
        user.LanguageLocaleKey='en_US';
        user.LocaleSidKey='en_US';
        return user;
    }
    public static void connectEpirocStandardProfile(User user){
        Profile p = [SELECT Id FROM Profile WHERE Name='Epiroc Standard User']; 
        user.ProfileId = p.Id;
    }
    public static void connectAdminProfile(User user){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        user.ProfileId = p.Id;
    }
    public static User createAdminTestUser(){
        User user = buildUserWithoutInsert('1');
        user.Bypass_validations__c = true;
        connectAdminProfile(user);
        insert user;
        return user;
    }

    public static ItemTemplateLwc createSimpleProductPickerItem() {
        ItemTemplateLwc item = new ItemTemplateLwc();
        item.itemNumber='123456';
        item.itemDescription='Test Item Name';
        item.extraItemDescription = 'Extra Description';
        item.unitOfMessure = 'EA';
        item.weight = 500;
        item.productDivision = 'MR';
        item.productLineCode = 'MRS';
        item.gac = '94';
        item.pgc = '948';
        item.cPlistPrice = 1000000;
        item.quantity=1;
        item.productSourceType = 'Item';
        return item;
    }

    public static ItemTemplateLwc createComplexProductPickerItem() {
        ItemTemplateLwc item = new ItemTemplateLwc();
        item.itemNumber='123456789';
        item.itemDescription='Test Complex Item Name';
        item.Business_Line = 'HAT PS'; // 'MRS'
        item.productDivision = 'MR';
        item.gac = '94';
        item.cPlistPrice = 1000000;
        item.quantity=1;
        item.productSourceType = 'Product';
        return item;
    }

    public static Opportunity createOppWithTypeWithAccountWithAddress(String flavour, String oppRecordType) {
        Country__c spain = new Country__c();
        spain.Alpha_2_Code__c = 'ES';
        insert spain;
        String genName = 'TestAccount' +flavour;
        Account acct = new Account(Name=genName);
        acct.Country__c = spain.id;
        insert acct;

        Address__c addr = createSingelAddress(acct, spain.id);
        Address__c billToAddr = createSingleBilltoAddress(acct, spain.id);
        Opportunity opp = new Opportunity();

        opp.Name = 'Test Name 23';
        opp.StageName='New';
        opp.RecordTypeId=Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosByName().get(oppRecordType).getRecordTypeId();
        opp.CloseDate=System.today().addMonths(1);
        opp.AccountId=acct.Id;
        opp.Pricebook2Id = Test.getStandardPricebookId();
        opp.Bill_To__c = billToAddr.Id;
        opp.Ship_To__c = addr.Id;
        opp.CurrencyIsoCode = 'EUR';
        if (oppRecordType == 'Complex Opportunity') {
            opp.Amount = 1000000;
        }
        insert opp;
        return opp;
    }

    public static Opportunity createComplexOppWithAccountWithAddress(String flavour) {
        return createOppWithTypeWithAccountWithAddress(flavour, 'Complex Opportunity');
    }
}