@IsTest
public class OpportunityProductPickerTest {
    
    @isTest static void addProductToOpportunityTest(){
        
        List<ItemTemplateLwc> itemsArg = new List<ItemTemplateLwc>();
        
        Opportunity opp = TestDataFactory.createOppWithAccountWithAddress('addProductToOpportunityTest');
        ItemTemplateLwc item = new ItemTemplateLwc();
        item.itemDescription='Desc';
        item.quantity=1;
        itemsArg.add(item);
        
        Product2 prod = new Product2();
        prod.Name = 'Simple Item';
        insert prod;
        
        Pricebook2 book = new Pricebook2();
        book.Name = 'Test Price Book';
        book.isActive = true;
        insert book;
        
        PricebookEntry entry = new PricebookEntry();
        entry.Product2Id = prod.Id;
        entry.Pricebook2Id = Test.getStandardPricebookId();
        entry.IsActive = true;
        entry.CurrencyIsoCode = 'EUR';
        entry.UnitPrice = 1000;
        insert entry;
        
        opp.Pricebook2Id = Test.getStandardPricebookId();
        update opp;
        
        Quote newQuote = new Quote();
        newQuote.Name = 'Test Quote';
        newQuote.OpportunityId = opp.Id;
        newQuote.Pricebook2Id = Test.getStandardPricebookId();
        Address__c adr = [SELECT Id FROM Address__c WHERE Address_Type__r.Name = 'Bill-to' LIMIT 1];

        newQuote.Bill_To__c = adr.id;
        insert newQuote;
        
        OpportunityProductPicker.addProductToOpportunity(opp.Id,itemsArg);     
        OpportunityProductPicker.addProductToOpportunity(newQuote.Id,itemsArg); 
        
        Test.startTest();
        //Quote qt = [select Id,Name,OpportunityId from Quote where Id=:quote.Id];
        //System.assertEquals(qt.Name, 'TestQuote updated');
        Test.stopTest();
    }

}