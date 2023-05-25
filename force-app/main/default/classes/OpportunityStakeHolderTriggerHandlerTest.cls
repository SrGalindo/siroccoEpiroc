@isTest

public class OpportunityStakeHolderTriggerHandlerTest {
    
    @isTest static void beforeInsertTest(){
        Stakeholder__c stk= TestDataFactory.createStakeholderWithoutCreate();
        insert stk;
        
        Opportunity opp= TestDataFactory.createOppWithAccountWithAddress('OpportunityStakeHolderTrigHand, beforeInsert');
        
        Opportunity_Stakeholder__c  opp_stk = new Opportunity_Stakeholder__c(Name='TestOpp Stakeholder',Opportunity__c =opp.Id, Stakeholder__c = stk.Id);
        insert opp_stk;
        
        
        Test.startTest();
        Opportunity_Stakeholder__c acc_St = [select Id,Stakeholder__c from Opportunity_Stakeholder__c where Id=:opp_stk.Id];
        System.assertEquals(acc_St.Stakeholder__c, stk.Id);
        Test.stopTest();
    }

}