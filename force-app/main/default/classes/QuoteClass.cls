public with sharing class QuoteClass {
    public static void connectBilltoAddresses(Quote quoteInc, Address__c addressInc){
        quoteInc.Bill_To__c = addressInc.Id;
        quoteInc.BillingCity = addressInc.Address__City__s;
        quoteInc.BillingCountryCode = addressInc.Address__CountryCode__s;
        quoteInc.BillingPostalCode = addressInc.Address__PostalCode__s;
        quoteInc.BillingStateCode = addressInc.Address__StateCode__s;
        quoteInc.BillingStreet = addressInc.Address__Street__s;
        quoteInc.Bill_to_Postal_code__c = addressInc.Postal_code__c;
        quoteInc.Bill_to_Address_Line_1__c = addressInc.Address_Line_1__c;
        quoteInc.Bill_to_Address_Line_2__c = addressInc.Address_Line_2__c;
        quoteInc.Bill_to_Address_Line_3__c = addressInc.Address_Line_3__c;
    }

    public static void connectShiptoAddresses(Quote quoteInc, Address__c addressInc){
        quoteInc.ShippingCity = addressInc.Address__City__s;
        quoteInc.ShippingCountryCode = addressInc.Address__CountryCode__s;
        quoteInc.ShippingPostalCode = addressInc.Address__PostalCode__s;
        quoteInc.ShippingStateCode = addressInc.Address__StateCode__s;
        quoteInc.ShippingStreet = addressInc.Address__Street__s;
        quoteInc.Ship_to_Postal_code__c = addressInc.Postal_code__c;
        quoteInc.Ship_to_Address_Line_1__c = addressInc.Address_Line_1__c;
        quoteInc.Ship_to_Address_Line_2__c = addressInc.Address_Line_2__c;
        quoteInc.Ship_to_Address_Line_3__c = addressInc.Address_Line_3__c;
        quoteInc.Ship_to__c = addressInc.id;
    }

    public static void connectBilltoAddresses(Quote quoteInc, Opportunity oppInc){
        quoteInc.Bill_To__c = oppInc.Bill_to__c;
        quoteInc.BillingCity = oppInc.Bill_To_Address__City__s;
        quoteInc.BillingCountryCode = oppInc.Bill_To_Address__CountryCode__s;
        quoteInc.BillingPostalCode = oppInc.Bill_To_Address__PostalCode__s;
        quoteInc.BillingStateCode = oppInc.Bill_To_Address__StateCode__s;
        quoteInc.BillingStreet = oppInc.Bill_To_Address__Street__s;
        quoteInc.Bill_to_Postal_code__c = oppInc.Bill_to_Postal_code__c ;
        quoteInc.Bill_to_Address_Line_1__c = oppInc.Bill_to_Address_1__c;
        quoteInc.Bill_to_Address_Line_2__c = oppInc.Bill_to_Address_2__c;
        quoteInc.Bill_to_Address_Line_3__c = oppInc.Bill_to_Address_3__c;
    }

    public static void connectShiptoAddresses(Quote quoteInc, Opportunity oppInc){
        quoteInc.ShippingCity = oppInc.Ship_To_Address__City__s;
        quoteInc.ShippingCountryCode = oppInc.Ship_To_Address__CountryCode__s;
        quoteInc.ShippingPostalCode = oppInc.Ship_To_Address__PostalCode__s;
        quoteInc.ShippingStateCode = oppInc.Ship_To_Address__StateCode__s;
        quoteInc.ShippingStreet = oppInc.Ship_To_Address__Street__s;
        quoteInc.Ship_to_Postal_code__c = oppInc.Ship_to__r.Postal_code__c;
        quoteInc.Ship_to_Address_Line_1__c = oppInc.Ship_to__r.Address_Line_1__c;
        quoteInc.Ship_to_Address_Line_2__c = oppInc.Ship_to__r.Address_Line_2__c;
        quoteInc.Ship_to_Address_Line_3__c = oppInc.Ship_to__r.Address_Line_3__c;
        quoteInc.Ship_to__c = oppInc.Ship_to__c;
    }
}