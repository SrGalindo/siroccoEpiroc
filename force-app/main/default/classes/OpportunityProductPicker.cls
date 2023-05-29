public with sharing class OpportunityProductPicker {
    @AuraEnabled
    public static String addProductToOpportunity(String opportunityId, List<ItemTemplateLwc> itemsArg){
        System.debug(itemsArg.size());
        System.debug(itemsArg);
        System.debug(itemsArg[0].itemDescription);
        System.debug('itemNumber: '+itemsArg[0].itemNumber);
        System.debug('cPlistPrice: '+itemsArg[0].cPlistPrice);
        System.debug('listPrice: '+itemsArg[0].listPrice);
        // currency? from opp/quote?
        List<Opportunity> oppList = [SELECT Id, Pricebook2Id, CurrencyIsoCode, RecordType.DeveloperName FROM Opportunity WHERE Id =: opportunityId];
        System.debug('1');

        List<Quote> quoteList = [SELECT Id, Pricebook2Id, CurrencyIsoCode, OpportunityId FROM Quote WHERE Id =: opportunityId];
        //Product2 prod = [SELECT Id FROM product2 WHERE Name = 'Simple Item' LIMIT 1];
        System.debug('3');

        Map<String, Product2> itemNumberToProductIdMap = ProductHandler.findOrCreateProducts(itemsArg);

        if(oppList.size() > 0){
            try {
                Opportunity opp = oppList[0];
                Map<Id, Id> productIdToStandardPBEIdMap = ProductHandler.findOrCreateStandardPBEsForProducts(itemNumberToProductIdMap.values(), opp.CurrencyIsoCode);
                List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
                //PricebookEntry entry = [SELECT Id FROM PricebookEntry WHERE Product2Id = :prod.id AND CurrencyIsoCode =: opp.CurrencyIsoCode];
                for(ItemTemplateLwc itemLooper : itemsArg){
                    Product2 productDetails = itemNumberToProductIdMap.get(itemLooper.itemNumber);
                    OpportunityLineItem oli = new OpportunityLineItem();
                    oli.Product2Id = productDetails.Id;
                    oli.Description = productDetails.Description;
                    oli.Unit_of_Measure__c = productDetails.Unit_Of_Measure__c;
                    oli.Item_number__c = productDetails.Item_Number__c;
                    oli.Name__c = productDetails.Name;
                    oli.GAC__c = productDetails.GAC__c;
                    oli.Division__c = productDetails.Division__c;
                    oli.Family__c = productDetails.Family; // old oli field "Business_Line__c"
                    oli.Epiroc_Business_Line__c = productDetails.Epiroc_Business_Line__c;
                    oli.Weight__c = productDetails.Weight__c;
                    oli.PGC__c = productDetails.PGC__c;
                    oli.PricebookEntryId = productIdToStandardPBEIdMap.get(oli.Product2Id);

                    /* EP - old version commented out
                    if(opp.RecordType.DeveloperName == 'Simple_Opportunity'){
                        //We need itemnumber in the frontend as a unique ID. For complex we do not have itemNumber. To solve this we set itemNumber = Product_Model_Internal.
                        //This will reach apex, and we will in that case for Complex not map it.
                        //Simple specific mapping
                        oli.Description = itemLooper.itemDescription != null ? itemLooper.itemDescription : null;
                        oli.Unit_of_Measure__c = itemLooper.unitOfMessure != null ? itemLooper.unitOfMessure : null;
                    }
                    else {
                        //Complex specific mapping
                        oli.Description = itemLooper.productLineCode != null ? itemLooper.productLineCode : null;
                        oli.Item_number__c = itemLooper.itemNumber;
                    }
                    oli.Item_number__c = itemLooper.itemNumber;
                    oli.name__c = itemLooper.itemDescription;
                    oli.GAC__c = itemLooper.gac != null ? itemLooper.gac : null;
                    oli.Division__c = itemLooper.productDivision != null ? itemLooper.productDivision : null;
                    oli.Business_line__c = itemLooper.productLineCode;
                    oli.Product2Id = prod.id;
                    oli.PricebookEntryId = entry.id;
                    */

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

                    oli.quantity = itemLooper.quantity;
                    oli.Available__c = itemLooper.freeStock != null ? itemLooper.freeStock : null;
                    System.debug('adding new OLI: '+oli);
                    oliList.add(oli);
                }
                System.debug('opp');
                //System.debug('entry');
                //System.debug(entry);
                insert oliList;
                return 'success';
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }

        }
        else if(quoteList.size() > 0){
            try {
                Quote quote = quoteList[0];
                Map<Id, Id> productIdToStandardPBEIdMap = ProductHandler.findOrCreateStandardPBEsForProducts(itemNumberToProductIdMap.values(), quote.CurrencyIsoCode);
                Opportunity quoteOpp = [SELECT Id, Pricebook2Id, CurrencyIsoCode, RecordType.DeveloperName FROM Opportunity WHERE Id =: quote.OpportunityId];
                //PricebookEntry entry = [SELECT Id FROM PricebookEntry WHERE Product2Id = :prod.id AND CurrencyIsoCode =: quote.CurrencyIsoCode];
                List<QuoteLineItem> qlList = new List<QuoteLineItem>();
                for(ItemTemplateLwc itemLooper : itemsArg){
                    Product2 productDetails = itemNumberToProductIdMap.get(itemLooper.itemNumber);
                    QuoteLineItem qli = new QuoteLineItem();
                    qli.Product2Id = productDetails.Id;
                    qli.Description = productDetails.Description;
                    qli.Unit_of_Measure__c = productDetails.Unit_Of_Measure__c;
                    qli.Item_number__c = productDetails.Item_Number__c;
                    qli.Name__c = productDetails.Name;
                    qli.GAC__c = productDetails.GAC__c;
                    qli.Division__c = productDetails.Division__c;
                    qli.Family__c = productDetails.Family; // old qli field "Business_Line__c"
                    qli.Epiroc_Business_Line__c = productDetails.Epiroc_Business_Line__c;
                    qli.Weight__c = productDetails.Weight__c;
                    qli.PGC__c = productDetails.PGC__c;
                    qli.PricebookEntryId = productIdToStandardPBEIdMap.get(qli.Product2Id);

                    /* EP - old version commented out
                    if(quoteOpp.RecordType.DeveloperName == 'Simple_Opportunity'){
                        //We need itemnumber in the frontend as a unique ID. For complex we do not have itemNumber. To solve this we set itemNumber = Product_Model_Internal.
                        //This will reach apex, and we will in that case for Complex not map it.
                        //Simple specific mapping
                        qli.Description = itemLooper.itemDescription != null ? itemLooper.itemDescription : null;
                        qli.GAC__c = itemLooper.gac != null ? itemLooper.gac : null;
                        qli.Unit_of_Measure__c = itemLooper.unitOfMessure != null ? itemLooper.unitOfMessure : null;
                    }
                    else {
                        //Complex specific mapping
                        qli.Description = itemLooper.productLineCode != null ? itemLooper.productLineCode : null;
                    }
                    qli.Item_number__c = itemLooper.itemNumber;
                    qli.name__c = itemLooper.itemDescription;
                    qli.Division__c = itemLooper.productDivision;
                    qli.Business_line__c = itemLooper.productLineCode;
                    qli.Product2Id = prod.id;
                    qli.PricebookEntryId = entry.id;
                    */

                    qli.quoteid = quote.id;
                    System.debug('1');
                    qli.List_price__c = itemLooper.listPrice != null ? Decimal.valueOf(itemLooper.listPrice) : 0;
                    qli.unitprice = itemLooper.cPlistPrice != null ? Decimal.valueOf(itemLooper.cPlistPrice) : 0;
                    qli.Discount = itemLooper.cPdiscountPercent != null ? Decimal.valueOf(itemLooper.cPdiscountPercent) : 0;
                    //qli.Totalprice = itemLooper.cPnetPrice != null ? Decimal.valueOf(itemLooper.cPnetPrice) * itemLooper.quantity: 0;
                    System.debug('2');
                    qli.quantity = itemLooper.quantity;
                    System.debug('3');
                    qli.Available__c = itemLooper.freeStock;
                    qlList.add(qli);
                }
                System.debug('opp');
                //System.debug('entry');
                //System.debug(entry);
                insert qlList;
                return 'success';
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    return 'error';
    }
}