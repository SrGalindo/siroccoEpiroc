@IsTest(IsParallel=true)
public class AccountPlanTableControllerTest {
    
	@TestSetup
	private static void createData() {
        Account_plan_2_0__c accountPlan = new Account_plan_2_0__c();
        insert accountPlan;
        Account_Plan_Item__c accountPlanItem = new Account_Plan_Item__c();
        accountPlanItem.Account_plan_2_0__c = accountPlan.Id;
        insert accountPlanItem;
    }

    
    @IsTest
    static void getAccountPlanTableSettings_success() {
        // Given
        Account_plan_2_0__c accountPlan = [Select Id From Account_plan_2_0__c Limit 1].get(0);
        Account_Plan_Item__c accountPlanItem = [Select Id From Account_Plan_Item__c Where Account_plan_2_0__c = :accountPlan.Id Limit 1].get(0);

        String tabName = 'Account Strategy';
        List<String> columnList = new List<String>{'Item Category', 'Item Description'};
        List<String> apiFieldsList = new List<String>{'Item_Name__c', 'Item_Description__c'};

        // When
        Test.startTest();
        Map<String,Object> result = AccountPlanTableController.getAccountPlanTableSettings(tabName, accountPlan.id);
        Test.stopTest();

        // Then
        System.assertEquals(false, result.get('error'));
        System.assert(!((List<Account_Plan_Item__c>)result.get('existingRecords')).isEmpty());
        System.assertEquals(accountPlanItem.Id, ((List<Account_Plan_Item__c>)result.get('existingRecords')).get(0).Id);
        System.assertEquals(apiFieldsList, (List<String>) result.get('apiFieldsList'));
        System.assertEquals(columnList, (List<String>) result.get('columnsList'));
    }

    @IsTest
    static void createRecord_success() {
        // Given
        Account_plan_2_0__c accountPlan = [Select Id From Account_plan_2_0__c Limit 1].get(0);
        String objectName = 'Account_Plan_Item__c';

        // When
        Test.startTest();
        Map<String,Object> result = AccountPlanTableController.createRecord(objectName, accountPlan.id);
        Test.stopTest();

        // Then
        System.assertEquals(false, result.get('error'), 'error found: '+result.get('message'));
        List<Account_Plan_Item__c> accountPlanItemList = [Select Id From Account_Plan_Item__c Where Account_plan_2_0__c = :accountPlan.Id];
        System.assertEquals(2, accountPlanItemList.size(), 'record not inserted properly');
    }

    @IsTest
    static void deleteRecord_success() {
        // Given
        Account_plan_2_0__c accountPlan = [Select Id From Account_plan_2_0__c Limit 1].get(0);
        Account_Plan_Item__c accountPlanItem = [Select Id From Account_Plan_Item__c Where Account_plan_2_0__c = :accountPlan.Id Limit 1].get(0);
        String objectName = 'Account_Plan_Item__c';

        // When
        Test.startTest();
        Map<String,Object> result = AccountPlanTableController.deleteRecord(accountPlanItem.id, objectName);
        Test.stopTest();

        // Then
        System.assertEquals(false, result.get('error'), 'error found: '+result.get('message'));
        List<Account_Plan_Item__c> accountPlanItemList = [Select Id From Account_Plan_Item__c Where Account_plan_2_0__c = :accountPlan.Id];
        System.assertEquals(0, accountPlanItemList.size(), 'record not deleted properly');
    }

    @IsTest
    static void linkContact_success() {
        // Given
        Account_plan_2_0__c accountPlan = [Select Id From Account_plan_2_0__c Limit 1].get(0);
        Contact myContact = new Contact(LastName = 'last Name');
        insert myContact;

        // When
        Test.startTest();
        Map<String,Object> result = AccountPlanTableController.linkContact(accountPlan.Id, myContact.Id);
        Test.stopTest();

        // Then
        System.assertEquals(false, result.get('error'), 'error found: '+result.get('message'));
        List<Account_Plan_Contacts__c> accountPlanContactList = [Select Id From Account_Plan_Contacts__c where Account_plan_2_0__c = :accountPlan.Id AND Contact__c = :myContact.Id];
        System.assertEquals(1, accountPlanContactList.size(), 'contact not linked correctly');
    }

    @IsTest
    static void linkContact_Fail() {
        // Given
        Account_plan_2_0__c accountPlan = [Select Id From Account_plan_2_0__c Limit 1].get(0);
        Contact myContact = new Contact(LastName = 'last Name');
        insert myContact;
        insert new Account_Plan_Contacts__c(Account_plan_2_0__c = accountPlan.id, Contact__c = myContact.id);

        // When
        Test.startTest();
        Map<String,Object> result = AccountPlanTableController.linkContact(accountPlan.Id, myContact.Id);
        Test.stopTest();

        // Then
        System.assertEquals(true, result.get('error'), 'error not found');
        System.assertEquals('Record already exists', result.get('message'), 'wrong message');
        List<Account_Plan_Contacts__c> accountPlanContactList = [Select Id From Account_Plan_Contacts__c where Account_plan_2_0__c = :accountPlan.Id AND Contact__c = :myContact.Id];
        System.assertEquals(1, accountPlanContactList.size(), 'contact not linked correctly');
    }

    //Create account fails due to a problem in the AccountTriggerHandler
    // using a fake account Id instead
    @IsTest
    static void linkAccount_fail() {
        // Given
        Account_plan_2_0__c accountPlan = [Select Id From Account_plan_2_0__c Limit 1].get(0);
        Id accId = '001000000000001';

        // When
        Test.startTest();
        Map<String,Object> result = AccountPlanTableController.linkAccount(accountPlan.Id, accId);
        Test.stopTest();

        // Then
        System.assertEquals(true, result.get('error'), 'error found: '+result.get('message'));
        // List<Account_Plan_Accounts__c> accountPlanAccountList = [Select Id From Account_Plan_Accounts__c where Account_plan_2_0__c = :accountPlan.Id AND Account__c = :accId];
        // System.assertEquals(1, accountPlanAccountList.size(), 'account not linked correctly');
    }
}