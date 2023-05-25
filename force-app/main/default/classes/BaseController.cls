public virtual with sharing class BaseController {

    @TestVisible private static Savepoint sp;
    @TestVisible private static final String DEFAULT_SUCCESSFUL_MESSAGE = 'Operation successful!';
    @TestVisible private static final String DEFAULT_ERROR_MESSAGE = 'Operation failed!';

    public static final String RESPONSE_ERROR_KEY = 'error';
    public static final String RESPONSE_MESSAGE_KEY = 'message';

    /**
    * Use this method to return the usual error message.
    * If your controller needs to return extra information, you can add it to the map like:
    *
    *   Map<String, Object> result = getActionFailed('success!');
    *   result.put('myObject', Object);
    *   return result;
    */
    public static Map<String, Object> getActionFailed(String message) {
        message = String.isNotBlank(message) ? message : DEFAULT_ERROR_MESSAGE;

        Map<String, Object> result = new Map<String, Object>();
        result.put(RESPONSE_ERROR_KEY, true);
        result.put(RESPONSE_MESSAGE_KEY, message);
        return result;
    }

    /**
    * Use this method to return the usual successful message.
    * If your controller needs to return extra information, you can add it to the map like:
    *
    *   Map<String, Object> result = getActionSuccessful('success!');
    *   result.put('myObject', Object);
    *   return result;
    */
    public static Map<String, Object> getActionSuccessful(String message) {
        message = String.isNotBlank(message) ? message : DEFAULT_SUCCESSFUL_MESSAGE;

        Map<String, Object> result = new Map<String, Object>();
        result.put(RESPONSE_ERROR_KEY, false);
        result.put(RESPONSE_MESSAGE_KEY, message);
        return result;
    }

    /**
    * Use this method to return an error message that comes from an exception. It prettifies the DML exceptions too.
    * If your controller needs to return extra information, you can add it to the map like:
    *
    *   Map<String, Object> result = getActionFailed(ex);
    *   result.put('myObject', Object);
    *   return result;
    */
    public static Map<String, Object> getActionFailed(Exception ex) {
        return getActionFailed(null, ex);
    }

    /**
    * Use this method to return an error message that comes from an exception, but adding extra text at the beginning of
    * the error message. It prettifies the DML exceptions before returning it.
    * If your controller needs to return extra information, you can add it to the map like:
    *
    *   Map<String, Object> result = getActionFailed(messagePrefix, ex);
    *   result.put('myObject', Object);
    *   return result;
    */
    public static Map<String, Object> getActionFailed(String messagePrefix, Exception ex) {

        String errorMessage = messagePrefix != null ? messagePrefix + ': ' : '';
        if (ex instanceof DmlException) {
            errorMessage += ((DmlException) ex).getDmlMessage(0);
        } else {
            errorMessage += ex.getMessage();
        }

        return getActionFailed(errorMessage);
    }

    /**
    * Use this method to do a rollback and then return an error the usual error message.
    * If your controller needs to return extra information, you can add it to the map like:
    *
    *   Map<String, Object> result = getActionFailedRollback(ex);
    *   result.put('myObject', Object);
    *   return result;
    */
    public static Map<String, Object> getActionFailedRollback(String message) {
        rollbackSavepoint();
        return getActionFailed(message);
    }

    /**
    * Use this method to do a rollback and then return an error message that comes from an exception.
    * If your controller needs to return extra information, you can add it to the map like:
    *
    *   Map<String, Object> result = getActionFailedRollback(ex);
    *   result.put('myObject', Object);
    *   return result;
    */
    public static Map<String, Object> getActionFailedRollback(Exception ex) {
        rollbackSavepoint();
        return getActionFailed(ex);
    }

    public static void setSavepoint() {
        sp = Database.setSavepoint();
    }

    public static void rollbackSavepoint() {
        if (sp == null) {
            throw new DeveloperExceptions.MissingArgumentsException('The savepoint is missing. Can\'t perform a rollback.');
        }
        Database.rollback(sp);
    }

}