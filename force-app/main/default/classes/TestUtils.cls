public with sharing class TestUtils {
    private static Integer idCounter = 0;
    public static final String GENERIC_DML_EXCEPTION_MESSAGE = 'cannot specify Id in an insert call';


    // Note that it doesn't accept a custom message
    public static DmlException getDmlException() {
        DmlException exceptionToReturn;

        try {
            // Can't insert a record with an ID.
            insert new Account(Id = getFakeSObjectId(Account.SObjectType));
        } catch (DmlException ex) {
            exceptionToReturn = ex;
        }

        return exceptionToReturn;
    }

    public static Id getFakeSObjectId(Schema.SObjectType sObjectType) {
        String counterString = '' + idCounter++;
        return sObjectType.getDescribe().getKeyPrefix() + counterString.leftPad(12, '0');
    }

    public class TestException extends Exception {}
}