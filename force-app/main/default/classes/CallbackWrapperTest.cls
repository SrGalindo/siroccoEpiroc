@isTest
private class CallbackWrapperTest {
    @isTest static void createCallbackWrapperTest() {
        CallbackWrapper cw = new CallbackWrapper();
        cw.message = 'something happend';
        cw.status = 'sucess';
        cw.id = '123nkkji';
        System.assert(cw != null, 'callback wrapper have not assigned');
    }
}