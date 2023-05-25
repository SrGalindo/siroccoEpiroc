@isTest public with sharing class UserTriggerHandlerTest {
    @TestSetup
    static void makeData(){
        User user = TestDataFactory.buildUserForTriggerTest('1');
        insert user;
        
    }
    @isTest public static void afterInsertTest() {
        User user = TestDataFactory.buildUserForTriggerTest('2');
        Test.startTest();
        insert user;
        Test.stopTest();
    }
    @isTest public static void beforeInsertTest() {
        User user = TestDataFactory.buildUserForTriggerTest('3');
        Test.startTest();
        insert user;
        Test.stopTest();
    }
}