public with sharing class Util {
    public static String switchFamCode(String famCodeInc){
        //Bpcs has multiple famcodes. All apis will use the production one.
        switch on famCodeInc{
            when 'ZAM' {
                return 'ZAT';
            }
            when 'ARO' {
                return 'ARQ';
            }
            when 'ESC' {
                return 'ESQ';
            }
            when 'PRC' {
                return 'PRX';
            }
            when else {
                return famCodeInc;
            }
        }
    }

    public static String switchFamCodeForMol(String famCodeInc){
        //Bpcs has multiple famcodes. All apis will use the production one.
        switch on famCodeInc{
            when 'ZAT' {
                return 'ZAM';
            }
            when 'ARQ' {
                return 'ARO';
            }
            when else {
                return famCodeInc;
                }
            }
        }
    public static Map<String, Id> getCountryMap(){
        List<Country__c> countryList = [SELECT Id, Alpha_2_Code__c FROM Country__c];
        Map<String, Id> countryToIdMap = new Map<String, Id>();
        for(Country__c country : countryList){
            countryToIdMap.put(country.Alpha_2_Code__c, country.Id);
        }
        return countryToIdMap;
        }
}