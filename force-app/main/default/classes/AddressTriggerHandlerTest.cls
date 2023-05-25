@isTest
public class AddressTriggerHandlerTest {
    @IsTest
    static void mapFieldsTest(){
        List<Address__c> addrList= TestDataFactory.createAddressesWithoutInsert();
        insert addrList;
        
        Test.startTest();
        List<Address__c> addrQueriedList= [SELECT Id,Country_code_3__c FROM Address__c WHERE Address__CountryCode__s =: 'AX'];
        System.assertEquals(addrQueriedList[0]?.Country_code_3__c, 'ALA');
        Test.stopTest();
        
    }
    
    @IsTest
    static void updateAddress(){
        List<Address__c> addrList= TestDataFactory.createAddressesWithoutInsert();
        insert addrList;
        
        List<Address__c> listToUpdate= new List<Address__c>();
        
        for(Address__c looper:addrList){
            looper.Address__CountryCode__s = 'AF';
            listToUpdate.add(looper);
        }
        
        update listToUpdate;
        
        Test.startTest();
        List<Address__c> addrQueriedList= [SELECT Id,Country_code_3__c FROM Address__c WHERE Address__CountryCode__s =: 'AF'];
        System.assertEquals(addrQueriedList[0]?.Country_code_3__c, 'AFG');
        Test.stopTest();
        
    }
}