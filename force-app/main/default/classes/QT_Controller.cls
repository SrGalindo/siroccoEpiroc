global with sharing class QT_Controller {
    
    public string selectedLang { get; set; }
    public String PdfName{get;set;}
    public Quote quote { get; private set; }
    public Id relatedQuote { get; set; }
    public boolean show{get;set;}
    public boolean showpdf{get;set;} 
    
    public QT_Controller(ApexPages.StandardController controller) {
        relatedQuote = ApexPages.CurrentPage().getparameters().get('id');
        //relatedQuote = '0Q01x000001st6UCAQ';
        quote = (relatedQuote == null) ?
            new Quote() :
        [SELECT Id, Name,Estimated_Time_of_Delivery__c ,Account.Owner.Name,VAT_Country__r.Tax_level__c,Transport_Fee__c ,Admin_Fee__c , Email,Account.CCUST__c,Account.Owner.Phone,Account.Owner.Email,Tax , Phone,Account.Account_owner__c, Payment_Terms__c, ExpirationDate, Lead_Time__c,Transport__c, Incoterms__c, AdditionalName,Subtotal, Discount, TotalPrice, ShippingHandling, TaxPerc__c, GrandTotal,Language__c, QuoteNumber, CurrencyIsoCode, Customer_Reference__c,Account.Name, Account.KAM__r.Name,Ship_to__r.Name,Contact_Name__c ,CreatedBy.Name,Contact_Email__c ,Quote_Expiration_Date__c , CreatedBy.Email,Contact_Phone__c ,Other_Payment_Terms__c , CreatedBy.Phone,Bill_to__r.Name,TaxFormula__c,CreatedDate FROM Quote WHERE Id = :relatedQuote];

  }
    
    public List<QuoteLineItem> getQuoteLines() {
        List<QuoteLineItem> QuoteLines = [SELECT Id,List_price__c,Unit_of_Measure__c, Description,Description__c , Quantity, LineNumber, UnitPrice, TotalPrice, Available__c, Name__c, Discount, Item_number__c,TaxFormula__c FROM QuoteLineItem WHERE QuoteId = :this.relatedQuote];
        
        
        return QuoteLines;
    }
    
    @AuraEnabled
    public static void savePdfToQuote(Id quoteId) {
        
        Quote quote = [SELECT Id,VAT_Country__r.Tax_level__c,Account.Owner.Name,Estimated_Time_of_Delivery__c,Transport_Fee__c ,Admin_Fee__c , Name, Email,Tax, Account.Owner.Phone,Account.Owner.Email, Phone,Account.Account_owner__c, Payment_Terms__c, ExpirationDate, Lead_Time__c,Transport__c, Incoterms__c, AdditionalName,Subtotal, Discount, TotalPrice, ShippingHandling, TaxPerc__c, GrandTotal,Language__c, QuoteNumber, CurrencyIsoCode, Customer_Reference__c,Account.Name, Account.KAM__r.Name,Ship_to__r.Name,Contact_Name__c,CreatedBy.Name, CreatedBy.Email,Quote_Expiration_Date__c ,Contact_Email__c ,Contact_Phone__c , CreatedBy.Phone,Bill_to__r.Name FROM Quote WHERE Id = :quoteId];
        
        PageReference savepage ;
        savepage = Page.QuoteTemplate;
        savepage.getParameters().put('id',quoteId);
        
        blob pdfBlob = (!Test.isRunningTest()) ? savepage.getContent() : Blob.valueOf('Test') ;
        List<ContentDocumentLink> notesattch = [select id, ContentDocument.Title,LinkedEntityId from ContentDocumentLink where LinkedEntityId =: quoteId order by ContentDocument.Title asc];
        
        string PdfName = (notesattch.size() > 0) ? 'Quote Document - Iteration('+ notesattch.size()+')' : 'Quote Document';
        ContentVersion conVer = new ContentVersion(
            ContentLocation = 'S',
            PathOnClient = PdfName+'.pdf',
            Title = PdfName,
            VersionData = pdfBlob
        );
        
        insert conVer;  
        
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        
        ContentDocumentLink conDocLink = New ContentDocumentLink(
            LinkedEntityId = quoteId,
            ContentDocumentId = conDoc,
            shareType = 'V'
        );
        insert conDocLink;
        //update quote;
        
        
    }
    
}