@IsTest
private class VisitReportTaskHandlerTest {
    @isTest static void getVistReportTasksTest() {
        List<Visit_Report__c> visitReports = TestDataFactory.createVisitReports(3);
        Integer addDays = 0;
        for(Visit_Report__c vr : visitReports){
            Test.setCreatedDate(vr.Id, Datetime.now().addDays(addDays));
            addDays++;
        }
        Set<Id> visitReportIds = (new Map<Id, Visit_Report__c>(visitReports)).keySet();
        List<Task> vrTasks = TestDataFactory.createTaskWithVisitReports(3, visitReportIds);
        
        Test.startTest();
        String previousTasks = VisitReportTaskHandler.getVistReportTasks(string.valueOf(visitReports[2].id));
        Test.stopTest();
        
        System.assert(previousTasks != null, 'failed to get previous tasks');
    }

    @isTest static void updateTaskStatusTest(){
        Test.startTest();
        List<Visit_Report__c> visitReports = TestDataFactory.createVisitReports(3);
        Set<Id> visitReportIds = (new Map<Id, Visit_Report__c>(visitReports)).keySet();
        List<Task> vrTasks = TestDataFactory.createTaskWithVisitReports(3, visitReportIds);
        String expectedValue = 'Completed';
        String actualValue = VisitReportTaskHandler.updateTaskStatus(String.valueOf(vrTasks[0].Id), expectedValue);
        Test.stopTest();
        System.assertEquals(expectedValue, actualValue, 'missmatch');
    }
}