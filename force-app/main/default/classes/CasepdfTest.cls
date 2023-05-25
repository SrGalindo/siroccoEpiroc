@isTest

public class CasepdfTest {
    
    @testSetup
    public static void setup(){
        
        // Insert Visit Report
        Visit_Report__c rep = new Visit_Report__c(Name='Test Report', Reason_for_visit__c='Test');
        insert rep;
    }
    
    @isTest static void CasepdfTest(){
        
         List<Visit_Report__c> repList = [Select Id from Visit_Report__c Limit 1]; 
        
        PageReference pageRef = Page.visitReportPDF;
        Test.setCurrentPage(pageRef);
        
        // put the Visit Report id as a parameter
        ApexPages.currentPage().getParameters().put('id',repList[0].id);
  
        Test.startTest();
        Casepdf obj = new Casepdf();
        obj.getVR();
        Test.stopTest();
    }
    
}