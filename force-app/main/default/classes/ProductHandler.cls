/**
 * Created by EP on 5/5/2023.
 * Class for handling Product and Price Book Entry creation from Product Picker
 */

public with sharing class ProductHandler {

    /*
    *   Input: method takes list of items from Product Picker as parameter
    *   Logic: method maps items to Products and upsert them using Item_Number__c external ID field (unique in Salesforce)
    *   Output: Map of ItemNumber => Product (products either existed in Salesforce already, or were created, or combination of both)
     */
    public static Map<String, Product2> findOrCreateProducts(List<ItemTemplateLwc> itemsArg) {
        Map<String, Product2> itemNumberToProductMap = new Map<String, Product2>();
        List<String> productItemNumbersList = new List<String>();
        List<Product2> productsForUpsert = new List<Product2>();
        for (ItemTemplateLwc item : itemsArg) {
            if (!String.isBlank(item.itemNumber)) {
                productItemNumbersList.add(item.itemNumber);
                Product2 newProduct;
                if (itemIsSimpleProduct(item)) {
                    newProduct = createAndMapSimpleProduct(item);
                } else {
                    newProduct = createAndMapComplexProduct(item);
                }
                productsForUpsert.add(newProduct);
            }
        }
        system.debug('productsForUpsert: '+productsForUpsert);
        if (productsForUpsert.size() > 0) {
            upsert productsForUpsert Item_Number__c;
            for (Product2 productInfo : [SELECT Id, Name, Item_Number__c, Family, Epiroc_Business_Line__c, Division__c, Description,
                    Unit_Of_Measure__c, Weight__c, GAC__c, PGC__c, Product_Source_Type__c FROM Product2 WHERE Item_Number__c IN :productItemNumbersList]) {
                itemNumberToProductMap.put(productInfo.Item_Number__c, productInfo);
            }
        }
        return itemNumberToProductMap;
    }

    /*
    *   Input: List of ProductIDs and Currency
    *   Logic: Method checks if Price Book Entries exist for all ProductIds in specified currency in Standard Price Book
    *       If yes, method returns a map of them
    *       If no, method creates Price Book Entries with UnitPrice = 0 and returns a map
    *   Output: Map of ProductId => PriceBookEntryId
     */
    public static Map<Id, Id> findOrCreateStandardPBEsForProducts(List<Product2> products, String currencyCode) {
        Map<Id, Id> productIdToStandardPBEIdMap = new Map<Id, Id>();
        Id standardPriceBookId;
        if (Test.isRunningTest()) {
            standardPriceBookId = Test.getStandardPricebookId();
        } else {
            standardPriceBookId = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1].Id;
        }
        Set<Id> productIds = new Set<Id>();
        for (Product2 product : products) {
            productIds.add(product.Id);
        }
        for (PricebookEntry pbe : [SELECT Id, Product2Id FROM PricebookEntry WHERE Pricebook2Id = :standardPriceBookId AND Product2Id IN :productIds]) {
            productIdToStandardPBEIdMap.put(pbe.Product2Id, pbe.Id);
        }
        if (productIdToStandardPBEIdMap.size() < products.size()) {
            List<PricebookEntry> pbesForInsert = new List<PricebookEntry>();
            for (Product2 product : products) {
                if (!productIdToStandardPBEIdMap.containsKey(product.Id)) {
                    PricebookEntry newPbe = new PricebookEntry(
                            Product2Id = product.Id,
                            Pricebook2Id = standardPriceBookId,
                            CurrencyIsoCode = currencyCode,
                            IsActive = true,
                            UnitPrice = 0
                    );
                    pbesForInsert.add(newPbe);
                }
            }
            system.debug('pbesForInsert: '+pbesForInsert);
            if (pbesForInsert.size() > 0) {
                insert pbesForInsert;
                for (PricebookEntry newPbe : pbesForInsert) {
                    productIdToStandardPBEIdMap.put(newPbe.Product2Id, newPbe.Id);
                }
            }
        }
        system.debug('productIdToStandardPBEIdMap: '+productIdToStandardPBEIdMap);
        return productIdToStandardPBEIdMap;
    }

    /*
    * Product Picker populates "Simple" items with value productSourceType == 'Item'
    * "Complex" items have value productSourceType == 'Product'
     */
    private static Boolean itemIsSimpleProduct(ItemTemplateLwc item) {
        return (item.productSourceType == 'Item');
    }

    private static Product2 createAndMapSimpleProduct(ItemTemplateLwc item) {
        system.debug('createAndMapSimpleProduct');
        return new Product2(
                Name = item.itemDescription,
                Item_Number__c = item.itemNumber,
                Family = item.productLineCode,
                Epiroc_Business_Line__c = FieldMappingTables.getEpirocBusinessLineBasedOnFamily(item.productLineCode),
                Division__c = item.productDivision,
                Description = item.extraItemDescription,
                Unit_Of_Measure__c = item.unitOfMessure,
                Weight__c = String.valueOf(item.weight),
                GAC__c = item.gac,
                PGC__c = item.pgc,
                IsActive = true,
                Product_Source_Type__c = 'Simple'
        );
    }

    private static Product2 createAndMapComplexProduct(ItemTemplateLwc item) {
        system.debug('createAndMapComplexProduct');
        return new Product2(
                Name = item.itemDescription, // populated in productPicker.js getObjectData() with value Product_Model_Internal
                Item_Number__c = item.itemNumber, // populated in productPicker.js getObjectData() with value Product_Model_Code_Internal
                Family = item.Business_Line,
                Epiroc_Business_Line__c = FieldMappingTables.getEpirocBusinessLineBasedOnFamily(item.Business_Line),
                Division__c = item.productDivision, // populated in productPicker.js getObjectData() with value Division
                GAC__c = item.gac,
                IsActive = true,
                Product_Source_Type__c = 'Complex'
        );
        /*
        itemNumber populated in productPicker.js getObjectData() with value Product_Model_Internal
         */
    }

}