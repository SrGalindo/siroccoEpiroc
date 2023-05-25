@isTest

public class QuoteLineTriggerHandlerTest {
    
    @testSetup
    public static void setup(){
        
        QuoteLineItem qlItem = TestDataFactory.createQuoteLineItem();
    }
    
    @isTest static void beforeInsertTest(){
        
        List<QuoteLineItem> qlItems = [select Id,UnitPrice from QuoteLineItem Limit 1]; 
        
        Test.startTest();
        System.assertEquals(qlItems[0].UnitPrice, 7053.318);
        Test.stopTest();
    }

}