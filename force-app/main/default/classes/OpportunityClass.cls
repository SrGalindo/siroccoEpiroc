/**
 * @description       : 
 * @author            : Ahmad Nawaz
 * @group             : 
 * @last modified on  : 19-09-2022
 * @last modified by  : Ahmad Nawaz
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   25-11-2022   Ahmad Nawaz   Initial Version
 * Tested By : OpportunityTriggerHandlerTest
**/
public with sharing class OpportunityClass {
    public static void connectBilltoAddresses(Opportunity opportunityInc, Address__c addressInc){
        if(addressInc.Address__City__s != null) opportunityInc.Bill_To_Address__City__s = addressInc.Address__City__s;
        if(addressInc.Address__countryCode__s != null) opportunityInc.Bill_To_Address__countryCode__s = addressInc.Address__countryCode__s;
        if(addressInc.Address__postalCode__s != null) opportunityInc.Bill_To_Address__postalCode__s = addressInc.Address__postalCode__s;
        if(addressInc.Address__StateCode__s != null) opportunityInc.Bill_To_Address__StateCode__s = addressInc.Address__StateCode__s;
        if(addressInc.Address__Street__s != null) opportunityInc.Bill_To_Address__Street__s = addressInc.Address__Street__s;
        if(addressInc.Address_Line_1__c != null) opportunityInc.Bill_to_Address_1__c = addressInc.Address_Line_1__c;
        if(addressInc.Address_Line_2__c != null) opportunityInc.Bill_to_Address_2__c = addressInc.Address_Line_2__c;
        if(addressInc.Address_Line_3__c != null) opportunityInc.Bill_to_Address_3__c = addressInc.Address_Line_3__c;
        if(addressInc.Postal_code__c != null) opportunityInc.Bill_to_Postal_code__c = addressInc.Postal_code__c;
        if(addressInc.Id != null) opportunityInc.Bill_to__c = addressInc.Id;
    }
    
    public static void connectShiptoAddresses(Opportunity opportunityInc, Address__c addressInc){
        if(addressInc.Address__City__s != null) opportunityInc.Ship_To_Address__City__s = addressInc.Address__City__s;
        if(addressInc.Address__countryCode__s != null) opportunityInc.Ship_To_Address__countryCode__s = addressInc.Address__countryCode__s;
        if(addressInc.Address__postalCode__s != null) opportunityInc.Ship_To_Address__postalCode__s = addressInc.Address__postalCode__s;
        if(addressInc.Address__Street__s != null) opportunityInc.Ship_To_Address__Street__s = addressInc.Address__Street__s;
        if(addressInc.Address__StateCode__s != null) opportunityInc.Ship_To_Address__StateCode__s = addressInc.Address__StateCode__s;

        opportunityInc.Ship_to__c = addressInc.Id;
    }
    /*@AuraEnabled
    public static String generateOpportunityName(Id accIdInc){
        try {
            Account acc = [SELECT Id, Customer__r.Name FROM Account WHERE Id = :accIdInc];
            Address__c addr = [SELECT Id, Country__r.Alpha_2_Code__c FROM Address__c WHERE Account__c =:acc.Id];
            String oppName = acc.Customer__r.Name + '-' + addr.Country__r.Alpha_2_Code__c;
            return oppName;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }*/
}