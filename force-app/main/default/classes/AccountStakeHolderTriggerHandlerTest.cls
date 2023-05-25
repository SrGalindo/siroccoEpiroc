@isTest
public class AccountStakeHolderTriggerHandlerTest {
    
    @isTest static void beforeInsertTest(){
        Stakeholder__c stk= TestDataFactory.createStakeholderWithoutCreate();
        insert stk;
        
        Account acc= TestDataFactory.createSingelAccount();
        
        Account_Stakeholder__c  acct_stk = new Account_Stakeholder__c(Name='TestAccount Stakeholder',Account__c =acc.Id, Stakeholder__c = stk.Id);
        insert acct_stk;
        
        
        Test.startTest();
        Account_Stakeholder__c acc_St = [select Id,Stakeholder__c from Account_Stakeholder__c where Id=:acct_stk.Id];
        System.assertEquals(acc_St.Stakeholder__c, stk.Id);
        Test.stopTest();
    }

}