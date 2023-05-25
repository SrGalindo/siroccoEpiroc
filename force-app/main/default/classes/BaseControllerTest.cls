@IsTest
public with sharing class BaseControllerTest {

    @IsTest
    private static void getActionFailed_noMessage_defaultErrorMessage() {
        // Given
        String customMessage = null;

        // When
        Map<String, Object> controllerResponse = BaseController.getActionFailed(customMessage);

        // Then
        System.assertEquals(true, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to true.');
        System.assertEquals(BaseController.DEFAULT_ERROR_MESSAGE, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected the default error message.');
    }

    @IsTest
    private static void getActionFailed_customMessageSpecified_customErrorMessageReturned() {
        // Given
        String customMessage = 'October 21, 2015';

        // When
        Map<String, Object> controllerResponse = BaseController.getActionFailed(customMessage);

        // Then
        System.assertEquals(true, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to true.');
        System.assertEquals(customMessage, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected the custom error message.');
    }

    @IsTest
    private static void getActionSuccessful_noMessage_defaultErrorMessage() {
        // Given
        String customMessage = null;

        // When
        Map<String, Object> controllerResponse = BaseController.getActionSuccessful(customMessage);

        // Then
        System.assertEquals(false, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to false.');
        System.assertEquals(BaseController.DEFAULT_SUCCESSFUL_MESSAGE, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected the default success message.');
    }

    @IsTest
    private static void getActionSuccessful_customMessageSpecified_customErrorMessageReturned() {
        // Given
        String customMessage = 'Back to the future!';

        // When
        Map<String, Object> controllerResponse = BaseController.getActionSuccessful(customMessage);

        // Then
        System.assertEquals(false, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to false.');
        System.assertEquals(customMessage, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected the custom success message.');
    }

    @IsTest
    private static void getActionFailed_withException_exceptionMessageReturned() {
        // Given
        String customMessage = 'Nobody - calls me - chicken!';
        TestUtils.TestException testException = new TestUtils.TestException(customMessage);

        // When
        Map<String, Object> controllerResponse = BaseController.getActionFailed(testException);

        // Then
        System.assertEquals(true, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to true.');
        System.assertEquals(customMessage, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected to get the error message contained in the exception.');
    }

    @IsTest
    private static void getActionFailed_withDMLException_exceptionMessageReturned() {
        // Given
        DmlException testException = TestUtils.getDmlException();

        // When
        Map<String, Object> controllerResponse = BaseController.getActionFailed(testException);

        // Then
        System.assertEquals(true, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to true.');
        System.assertEquals(TestUtils.GENERIC_DML_EXCEPTION_MESSAGE, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected to get the error message contained in the DML exception without any stack trace info.');
    }

    @IsTest
    private static void getActionFailed_withExceptionAndCustomMessage_composedMessageReturned() {
        // Given
        String customMessagePrefix = 'Delivered in';
        String customMessage = '1985';
        TestUtils.TestException testException = new TestUtils.TestException(customMessage);

        // When
        Map<String, Object> controllerResponse = BaseController.getActionFailed(customMessagePrefix, testException);

        // Then
        System.assertEquals(true, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to true.');
        System.assertEquals(customMessagePrefix + ': ' + customMessage, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected to get the error message contained in the exception.');
    }

    @IsTest
    private static void getActionFailed_withDMLExceptionAndCustomMessage_composedMessageReturned() {
        // Given
        String customMessagePrefix = '1995';
        DmlException testException = TestUtils.getDmlException();

        // When
        Map<String, Object> controllerResponse = BaseController.getActionFailed(customMessagePrefix, testException);

        // Then
        System.assertEquals(true, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to true.');
        System.assertEquals(customMessagePrefix + ': ' + TestUtils.GENERIC_DML_EXCEPTION_MESSAGE, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected to get the error message contained in the DML exception without any stack trace info.');
    }

    @IsTest
    private static void getActionFailedRollback_noMessage_defaultErrorMessageAndRollback() {
        // Given
        BaseController.setSavepoint();
        Account testAccount = new Account(Name = 'Run out of imagination');
        insert testAccount;

        String customMessage = null;

        // When
        Map<String, Object> controllerResponse = BaseController.getActionFailedRollback(customMessage);

        // Then
        System.assertEquals(true, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to true.');
        System.assertEquals(BaseController.DEFAULT_ERROR_MESSAGE, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected the default error message.');
        System.assertNotEquals(null, testAccount.Id,
                'The account should have got an Id during the insert.');
        Integer accountsAmount = Database.countQuery('SELECT count() FROM Account WHERE ID = \'' + testAccount.Id + '\'');
        System.assertEquals(0, accountsAmount,
                'The account should not be in the database.');
    }

    @IsTest
    private static void getActionFailedRollback_customMessageSpecified_customErrorMessageReturnedAndRollback() {
        // Given
        BaseController.setSavepoint();
        Account testAccount = new Account(Name = 'Run out of imagination');
        insert testAccount;

        String customMessage = 'October 21, 2015';

        // When
        Map<String, Object> controllerResponse = BaseController.getActionFailedRollback(customMessage);

        // Then
        System.assertEquals(true, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to true.');
        System.assertEquals(customMessage, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected the custom error message.');
        System.assertNotEquals(null, testAccount.Id,
                'The account should have got an Id during the insert.');
        Integer accountsAmount = Database.countQuery('SELECT count() FROM Account WHERE ID = \'' + testAccount.Id + '\'');
        System.assertEquals(0, accountsAmount,
                'The account should not be in the database.');
    }

    @IsTest
    private static void getActionFailedRollback_withException_exceptionMessageReturnedAndRollback() {
        // Given
        BaseController.setSavepoint();
        Account testAccount = new Account(Name = 'Run out of imagination');
        insert testAccount;

        String customMessage = 'Too lazy';
        TestUtils.TestException testException = new TestUtils.TestException(customMessage);

        // When
        Map<String, Object> controllerResponse = BaseController.getActionFailedRollback(testException);

        // Then
        System.assertEquals(true, controllerResponse.get(BaseController.RESPONSE_ERROR_KEY),
                'Expected the error key to be set to true.');
        System.assertEquals(customMessage, controllerResponse.get(BaseController.RESPONSE_MESSAGE_KEY),
                'Expected to get the error message contained in the exception.');
        System.assertNotEquals(null, testAccount.Id,
                'The account should have got an Id during the insert.');
        Integer accountsAmount = Database.countQuery('SELECT count() FROM Account WHERE ID = \'' + testAccount.Id + '\'');
        System.assertEquals(0, accountsAmount,
                'The account should not be in the database.');
    }

    @IsTest
    private static void setSavepoint_setPointCorrectlySet() {
        // Given
        System.assertEquals(null, BaseController.sp, 'The save point should not be set by default');

        // When
        BaseController.setSavepoint();

        // Then
        System.assertNotEquals(null, BaseController.sp, 'The save point should have been set.');
    }

    @IsTest
    private static void rollbackSavepoint_noSavePointSet_DeveloperExceptionThrown() {
        // Given
        System.assertEquals(null, BaseController.sp, 'The save point should not be set by default');

        // When
        try {
            BaseController.rollbackSavepoint();
            System.assert(false, 'An DeveloperException was expected.');
        } catch (DeveloperExceptions.MissingArgumentsException ex) {
            // Then
            System.assertEquals('The savepoint is missing. Can\'t perform a rollback.', ex.getMessage());
        }
    }

    @IsTest
    private static void rollbackSavepoint_savePointSet_rollbackPerformed() {
        // Given
        BaseController.setSavepoint();
        Account testAccount = new Account(Name = 'McQueen95');
        insert testAccount;

        // When
        BaseController.rollbackSavepoint();

        // Then
        System.assertNotEquals(null, testAccount.Id, 'The account should have got an Id during the insert.');
        Integer accountsAmount = Database.countQuery('SELECT count() FROM Account WHERE ID = \'' + testAccount.Id + '\'');
        System.assertEquals(0, accountsAmount, 'The account should not be in the database.');
    }

    public static void checkResultSuccessful(Map<String, Object> controllerResult, String expectedMessage) {
        System.assertEquals(false, controllerResult.get('error'), 'Expected a successful result.');
        System.assertEquals(expectedMessage, controllerResult.get('message'), 'Unexpected message returned by the controller.');
    }

    public static void checkResultFailed(Map<String, Object> controllerResult, String expectedErrorMessage) {
        System.assertEquals(true, controllerResult.get('error'), 'Expected a failed result.');
        System.assertEquals(expectedErrorMessage, controllerResult.get('message'), 'Unexpected error message.');
    }

    private class TestBaseController extends BaseController {}
}