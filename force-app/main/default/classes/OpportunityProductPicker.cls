public with sharing class OpportunityProductPicker {
    @AuraEnabled
    public static String addProductToOpportunity(String opportunityId, List<ItemTemplateLwc> itemsArg){
        System.debug(itemsArg.size());
        System.debug(itemsArg);
        System.debug(itemsArg[0].itemDescription);
        List<Opportunity> oppList = [SELECT Id, Pricebook2Id, CurrencyIsoCode, RecordType.DeveloperName FROM Opportunity WHERE Id =: opportunityId];
        System.debug('1');

        List<Quote> quoteList = [SELECT Id, Pricebook2Id, CurrencyIsoCode, OpportunityId FROM Quote WHERE Id =: opportunityId];
        Product2 prod = [SELECT Id FROM product2 WHERE Name = 'Simple Item' LIMIT 1];
        System.debug('3');

        if(oppList.size() > 0){
            try {
                Opportunity opp = oppList[0];
                List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
                PricebookEntry entry = [SELECT Id FROM PricebookEntry WHERE Product2Id = :prod.id AND CurrencyIsoCode =: opp.CurrencyIsoCode];
                for(ItemTemplateLwc itemLooper : itemsArg){
                    OpportunityLineItem oli = new OpportunityLineItem();
                    if(opp.RecordType.DeveloperName == 'Simple_Opportunity'){
                        //We need itemnumber in the frontend as a unique ID. For complex we do not have itemNumber. To solve this we set itemNumber = Product_Model_Internal.
                        //This will reach apex, and we will in that case for Complex not map it.
                        //Simple specific mapping
                        oli.Description = itemLooper.itemDescription != null ? itemLooper.itemDescription : null;
                        oli.Unit_of_Measure__c = itemLooper.unitOfMessure != null ? itemLooper.unitOfMessure : null;
                        oli.Item_number__c = itemLooper.itemNumber;
                    }
                    else {
                        //Complex specific mapping
                        oli.Description = itemLooper.productLineCode != null ? itemLooper.productLineCode : null;
                    }
                    oli.name__c = itemLooper.itemDescription;
                    oli.opportunityid = opportunityId;
                    System.debug('Pricing fields');
                    System.debug(itemLooper.cPlistPrice);
                    oli.List_Price__c = itemLooper.cPlistPrice != null ? itemLooper.cPlistPrice : 0;
                    //oli.Totalprice = itemLooper.cPnetPrice != null ? Decimal.valueOf(itemLooper.cPnetPrice) * itemLooper.quantity: 0;
                    oli.unitprice = itemLooper.cPlistPrice != null ? Decimal.valueOf(itemLooper.cPlistPrice) : 0;
                    oli.Discount = itemLooper.cPdiscountPercent != null ? Decimal.valueOf(itemLooper.cPdiscountPercent) : 0;
                    //oli.unitprice = itemLooper.listPrice != null ? Decimal.valueOf(itemLooper.listPrice) : 0;
                    //oli.Discount = itemLooper.cPdiscountPercent != null ? Decimal.valueOf(itemLooper.cPdiscountPercent) : 0;
                    System.debug('Product fields');
                    oli.GAC__c = itemLooper.gac != null ? itemLooper.gac : null;
                    oli.Division__c = itemLooper.productDivision != null ? itemLooper.productDivision : null;
                    oli.quantity = itemLooper.quantity;
                    oli.Business_line__c = itemLooper.productLineCode;
                    oli.Available__c = itemLooper.freeStock != null ? itemLooper.freeStock : null;
                    oli.Product2Id = prod.id;
                    oli.PricebookEntryId = entry.id;
                    oliList.add(oli);
                }
                System.debug('opp');
                System.debug('entry');
                System.debug(entry);
                insert oliList;
                return 'success';
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }

        }
        else if(quoteList.size() > 0){
            try {
                Quote quote = quoteList[0];
                Opportunity quoteOpp = [SELECT Id, Pricebook2Id, CurrencyIsoCode, RecordType.DeveloperName FROM Opportunity WHERE Id =: quote.OpportunityId];
                PricebookEntry entry = [SELECT Id FROM PricebookEntry WHERE Product2Id = :prod.id AND CurrencyIsoCode =: quote.CurrencyIsoCode];
                List<QuoteLineItem> qlList = new List<QuoteLineItem>();
                for(ItemTemplateLwc itemLooper : itemsArg){
                    QuoteLineItem qli = new QuoteLineItem();
                    if(quoteOpp.RecordType.DeveloperName == 'Simple_Opportunity'){
                        //We need itemnumber in the frontend as a unique ID. For complex we do not have itemNumber. To solve this we set itemNumber = Product_Model_Internal.
                        //This will reach apex, and we will in that case for Complex not map it.
                        //Simple specific mapping
                        qli.Description = itemLooper.itemDescription != null ? itemLooper.itemDescription : null;
                        qli.GAC__c = itemLooper.gac != null ? itemLooper.gac : null;
                        qli.Unit_of_Measure__c = itemLooper.unitOfMessure != null ? itemLooper.unitOfMessure : null;
                        qli.Item_number__c = itemLooper.itemNumber;
                    }
                    else {
                        //Complex specific mapping
                        qli.Description = itemLooper.productLineCode != null ? itemLooper.productLineCode : null;
                    }
                    qli.name__c = itemLooper.itemDescription;
                    qli.quoteid = quote.id;
                    qli.Product2Id = prod.id;
                    System.debug('1');
                    qli.List_price__c = itemLooper.listPrice != null ? Decimal.valueOf(itemLooper.listPrice) : 0;
                    qli.unitprice = itemLooper.cPlistPrice != null ? Decimal.valueOf(itemLooper.cPlistPrice) : 0;
                    qli.Discount = itemLooper.cPdiscountPercent != null ? Decimal.valueOf(itemLooper.cPdiscountPercent) : 0;
                    //qli.Totalprice = itemLooper.cPnetPrice != null ? Decimal.valueOf(itemLooper.cPnetPrice) * itemLooper.quantity: 0;
                    System.debug('2');
                    qli.quantity = itemLooper.quantity;
                    System.debug('3');
                    qli.Division__c = itemLooper.productDivision;
                    qli.Business_line__c = itemLooper.productLineCode;
                    qli.Available__c = itemLooper.freeStock;
                    qli.PricebookEntryId = entry.id;
                    qlList.add(qli);
                }
                System.debug('opp');
                System.debug('entry');
                System.debug(entry);
                insert qlList;
                return 'success';
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    return 'error';
    }
}