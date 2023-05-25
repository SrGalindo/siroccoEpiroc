public with sharing class ItemTemplateLwc {
    @AuraEnabled
    public String itemNumber { get; set;}
    @AuraEnabled
    public String itemDescription { get; set;}
    @AuraEnabled
    public String extraItemDescription { get; set;}
    @AuraEnabled
    public String unitOfMessure { get; set;}
    @AuraEnabled
    public Integer lastTransactionDate { get; set;}
    @AuraEnabled
    public Double listPrice { get; set;}
    @AuraEnabled
    public Double weight { get; set;}
    @AuraEnabled
    public String productDivision { get; set;}
    @AuraEnabled
    public String productLineCode { get; set;}
    @AuraEnabled
    public Double cPnetPrice { get; set;}
    @AuraEnabled
    public String cPdiscountPercent { get; set;}
    @AuraEnabled
    public Double cPlistPrice { get; set;}
    @AuraEnabled
    public String gac { get; set;}
    @AuraEnabled
    public String gacDescription { get; set;}
    @AuraEnabled
    public String pgc { get; set;}
    @AuraEnabled
    public String pgcDescription { get; set;}
    @AuraEnabled
    public Integer vendorNumber { get; set;}
    @AuraEnabled
    public String vendorName { get; set;}
    @AuraEnabled
    public Double freeStock { get; set;}
    @AuraEnabled
    public Double quantity { get; set;}
    @AuraEnabled
    public Boolean cPnetPriceRetrieved { get; set;}
    @AuraEnabled
    public Boolean cPdiscountPercentRetrieved { get; set;}
    @AuraEnabled
    public Boolean cPlistPriceRetrieved { get; set;}
    @AuraEnabled
    public String Product_Family { get; set;}
}