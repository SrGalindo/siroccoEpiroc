@IsTest
public with sharing class FieldMappingTableTest {
    @IsTest
    public static void getThreeCharCountryCodeTest(){
        String countryCode = 'AX';
        String countryCodeReturn = FieldMappingTables.getThreeCharCountryCode(countryCode);
        System.assert(countryCodeReturn == 'ALA');
    }
    @IsTest
    public static void getTwoCharCountryCodeTest(){
        String countryCode = 'ALA';
        String countryCodeReturn = FieldMappingTables.getTwoCharCountryCode(countryCode);
        System.assert(countryCodeReturn == 'AX');
    }
    @IsTest
    public static void paymentTermsMappingTest(){
        String paymentTerms = 'Net 90 days';
        String FAMCode = 'ESC';
        String paymentTermsReturn = FieldMappingTables.paymentTermsMapping(paymentTerms,FAMCode);
        System.assert(paymentTermsReturn == '90 DAYS');
    }
    @IsTest
    public static void usePartnerMappingTest(){
        String inputString = 'cmsalesman';
        Boolean outputString = FieldMappingTables.usePartnerMapping(inputString);
        System.assert(outputString == false);
    }
    @IsTest
    public static void countryCodeToFamCodeTest(){
        String inputString = 'badstring';
        String outputString = FieldMappingTables.countryCodeToFamCode(inputString);
        System.assert(outputString == 'error');
    }
    @IsTest
    public static void getTwoCharCountryCodeWithBackupTest(){
        String outputString = FieldMappingTables.getTwoCharCountryCodeWithBackup('abcc', 'abc', 'abc');
        System.assert(outputString == 'error');
    }
    @IsTest
    public static void currencyMappingTest(){
        String outputString = FieldMappingTables.currencyMapping('abcc');
        System.assert(outputString == 'USD');
    }
    @IsTest
    public static void emailMappingTest(){
        String outputString = FieldMappingTables.emailMapping('a');
        System.assert(outputString == 'a');
    }
    @IsTest
    public static void countryWithRegionMappingTest(){
        Boolean outputString = FieldMappingTables.countryWithRegionMapping('fail');
        System.assert(outputString == false);
    }
    @IsTest
    public static void stateMappingTest(){
        String outputString = FieldMappingTables.stateMapping('fake');
        System.assert(outputString == 'fake');
    }
}