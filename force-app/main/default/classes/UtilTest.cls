@isTest
private class UtilTest {
    @isTest static void testSwitchFamCodeWithZAT() {
        String famCode = 'ZAT';
        Test.startTest();
        String result = Util.switchFamCode(famCode);
        Test.stopTest();
        System.assertEquals(famCode, result, 'faild to swith famcode when SwichFramCode');
    }

    @isTest static void testSwitchFamCodeWithZAM() {
        String famCode = 'ZAM';
        Test.startTest();
        String result = Util.switchFamCode(famCode);
        Test.stopTest();
        System.assertEquals('ZAT', result, 'faild to swith famcode when SwichFramCode');
    }

    @isTest static void testSwitchFamCodeForMolWithZAT(){
        String famCode = 'ZAT';
        Test.startTest();
        String result = Util.switchFamCodeForMol(famCode);
        Test.stopTest();
        System.assertEquals('ZAM', result, 'faild to swith famcode when SwichFramCodeForMol');
    }

    @isTest static void testSwitchFamCodeForMolWithZAM(){
        String famCode = 'ZAM';
        Test.startTest();
        String result = Util.switchFamCodeForMol(famCode);
        Test.stopTest();
        System.assertEquals(famCode, result, 'faild to swith famcode when SwichFramCodeForMol');
    }
}