@isTest
public class QuoteTriggerHandlerTest {
    
    @isTest static void beforeInsertTest(){
        Account acc = TestDataFactory.createAccountWithAddresses();
        Opportunity opp = TestDataFactory.createOpportunity(acc);
        Quote quote = TestDataFactory.createQuote(acc, opp);
        Address__c billto = [SELECT Id FROM Address__c WHERE Account__c =: acc.Id AND Address_Type__r.Name = 'Bill-to'];
        quote.Name = 'TestQuote updated';
        quote.Bill_to__c = billto.Id;
        System.debug(billto.Id);
        update quote;
        
        Test.startTest();
        Quote qt = [SELECT Id,Name,OpportunityId FROM Quote where Id=:quote.Id];
        System.assertEquals(qt.Name, 'TestQuote updated');
        Test.stopTest();
    }

}