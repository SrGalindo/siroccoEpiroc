@isTest
private class EventTriggerHandlerTest {
    
    @isTest static void testEvent() {
        Event newEvent = TestDataFactory.createEvent();
        
        Test.startTest();
        Account parentAcc= [SELECT Id,parentId FROM Account WHERE Id =: newEvent.WhatId];
        FeedItem parentFeed= [SELECT Id,parentId FROM FeedItem WHERE ParentId =: parentAcc.parentId];
        System.assertEquals(parentFeed.parentId, parentAcc.parentId);
        Test.stopTest();
    }
    
    @isTest static void testTask() {
        Task newTask = TestDataFactory.createTask();
        
        Test.startTest();
        Account parentAcc= [SELECT Id,parentId FROM Account WHERE Id =: newTask.WhatId];
        FeedItem parentFeed= [SELECT Id,parentId FROM FeedItem WHERE ParentId =: parentAcc.parentId];
        System.assertEquals(parentFeed.parentId, parentAcc.parentId);
        Test.stopTest();
    }
    
    

}