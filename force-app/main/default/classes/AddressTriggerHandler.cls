public with sharing class AddressTriggerHandler {
    public static void beforeInsert(List<Address__c> addressesArg){
       mapFields(addressesArg);
    }
    public static void beforeUpdate(List<Address__c> addressesArg){
       mapFields(addressesArg);
    }

    public static void mapFields(List<Address__c> addressesArg){
        List<Country__c> countryList = [SELECT Id, Name, Alpha_2_Code__c FROM Country__c];
        Map<String, Id> countryNameToCountryIdMap = new Map<String, Id>();
        for(Country__c country : countryList){
            countryNameToCountryIdMap.put(country.Alpha_2_Code__c, country.id);
        }
        for(Address__c addressLooper: addressesArg){
            String alpha2Code = addressLooper.Address__countryCode__s;
            if(countryNameToCountryIdMap.get(alpha2Code) != null){
                addressLooper.Country__c = countryNameToCountryIdMap.get(alpha2Code);
            }
            if(addressLooper.Nickname__c != null){
                addressLooper.Name = addressLooper.Nickname__c;
            }
            else {
                addressLooper.Name = addressLooper.Address__Street__s + ',' + addressLooper.Address__City__s + ',' + addressLooper.Address__countryCode__s;
            }
            System.debug('Address1: '+addressLooper.Address__CountryCode__s);
            if(addressLooper.Address__CountryCode__s == null) continue;
            addressLooper.Country_code_3__c =  FieldMappingTables.getThreeCharCountryCode(addressLooper.Address__CountryCode__s);
        }
    }
}