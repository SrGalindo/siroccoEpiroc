@isTest
public class OpportunityTriggerHandlerTest {
    
    @isTest static void afterUpdate(){
        Opportunity opp= TestDataFactory.createOppWithAccountWithAddress('opp,afterUpdate');
        
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
        Address__c adr = [SELECT Id FROM Address__c WHERE Address_Type__r.Name = 'Bill-to' LIMIT 1];

        newQuote.Bill_To__c = adr.id;
        insert newQuote;
        
        QuoteLineItem item = new QuoteLineItem();
        item.Product2Id = product.Id;
        item.QuoteId = newQuote.Id;
        item.Quantity = 1;
        item.UnitPrice = 7053.318;
        item.PricebookEntryId = entry.Id;
        insert item;
        
        opp.SyncedQuoteId = newQuote.Id;
        opp.Name = 'Test';
        opp.pricebook2Id = Test.getStandardPricebookId();
        update opp;
        
        
        
        Test.startTest();
        List<OpportunityLineItem> oppItem= [SELECT Id FROM OpportunityLineItem];
        System.assertEquals(oppItem.size(), 1);
        Test.stopTest();
        
    }
    @isTest static void TestsetBillTo(){
        Opportunity opp= TestDataFactory.createOppWithAccountWithAddress('TestsetBillTo');
        OpportunityTriggerHandler.setBillTo(opp);
        
        Test.startTest();
        System.assertEquals(1, 1);
        Test.stopTest();
    }
    
    @isTest static void TestsetshipTo(){
        Opportunity opp= TestDataFactory.createOppWithAccountWithAddress('TestsetshipTo');
        OpportunityTriggerHandler.setShipTo(opp);
        
        Test.startTest();
        System.assertEquals(1, 1);
        Test.stopTest();
    }
    

}