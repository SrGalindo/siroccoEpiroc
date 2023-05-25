/**
 * @description       : 
 * @author            : Ahmad Nawaz
 * @group             : 
 * @last modified on  : 09-07-2022
 * @last modified by  : Ahmad Nawaz
**/
public with sharing class QuoteProductPicker { 
    // @AuraEnabled
    // public static string addProductToQuote(String quoteId, String nameInc, Decimal quantityInc, String unitPriceInc){
        
    //     List<Opportunity> maxOneOppList = [SELECT Id FROM Opportunity WHERE Id = :quoteId];
    //     List<Quote> maxOneQuoteList = [SELECT Id FROM Quote WHERE Id = :quoteId];
    //             try {
    //         if(maxOneOppList.size() > 0 ){
                
    //             Product2 prod = [Select id FROM product2 where name = 'Simple Item' LIMIT 1];
    //             Opportunity opp = [SELECT Id, Name, Pricebook2Id, CurrencyIsoCode FROM Opportunity WHERE Id =:maxOneOppList[0].Id];
    //             System.debug('opp'+opp);
    //             System.debug(opp.Pricebook2Id);
    //             System.debug(opp.Name);
    //             System.debug(opp.CurrencyIsoCode);
    //             System.debug(prod.id);
    //             PricebookEntry entry = [SELECT Id FROM PricebookEntry WHERE Product2Id = :prod.id AND CurrencyIsoCode =: opp.CurrencyIsoCode];
    //             System.debug('entry');
    //             System.debug(entry);
    //             OpportunityLineItem oli = new OpportunityLineItem();
    //             oli.name__c = nameInc;
    //             oli.opportunityid = quoteId;
    //             oli.UnitPrice = Decimal.valueOf(unitPriceInc);
    //             oli.quantity = quantityInc;
    //             oli.Product2Id = prod.id;
    //             oli.PricebookEntryId = entry.id;
    //             insert oli;
    //         }
    //         else {
    //             Quote reQueriedQuote = [SELECT Id, OpportunityId FROM Quote WHERE ID = :maxOneQuoteList[0].Id];
    //             System.debug('reQueriedQuote'+reQueriedQuote);
    //             Product2 prod = [Select id FROM product2 where name = 'Simple Item' LIMIT 1];
    //             System.debug('prod'+prod);
    //             Opportunity opp = [SELECT Id,Pricebook2Id, CurrencyIsoCode FROM Opportunity WHERE Id =:reQueriedQuote.OpportunityId];
    //             PricebookEntry entry = [SELECT Id FROM PricebookEntry WHERE Product2Id = :prod.id AND CurrencyIsoCode =: opp.CurrencyIsoCode];
    //             QuoteLineItem x = new QuoteLineItem();
    //             x.name__c = nameInc;
    //             System.debug(nameInc);
    //             System.debug(x.name__c);
    //             x.quoteId = quoteId;
    //             x.UnitPrice = Decimal.valueOf(unitPriceInc);
    //             x.quantity = quantityInc;
    //             x.Product2Id = prod.id;
    //             x.PricebookEntryId = entry.id;
    //             insert x;
    //         }
    //         return 'success';
    //     } catch (Exception e) {
    //         throw new AuraHandledException(e.getMessage());
    //     } 
    // }
    
    /*@AuraEnabled
    public static List<QuoteLineItem> saveFile(String base64Data, string quoteId) {
        String data    = JSON.deserializeUntyped(base64Data).toString();

        Quote reQueriedQuote = [SELECT Id, OpportunityId FROM Quote WHERE ID = :quoteId];
        Product2 prod = [Select id FROM product2 where name = 'Simple Item' LIMIT 1];
        Opportunity opp = [SELECT Id,Pricebook2Id, CurrencyIsoCode FROM Opportunity WHERE Id =:reQueriedQuote.OpportunityId];
        PricebookEntry entry = [SELECT Id FROM PricebookEntry WHERE Product2Id = :prod.id AND CurrencyIsoCode =: opp.CurrencyIsoCode];

        list<QuoteLineItem> lstQLsToInsert = new list<QuoteLineItem>();
        list<String> lstCSVLines = data.split('\n');

        for(Integer i = 1; i < lstCSVLines.size(); i++){
            QuoteLineItem items = new QuoteLineItem();
            String csvLine = lstCSVLines[i];
            String prevLine = csvLine;
            Integer startIndex;
            Integer endIndex;
            
            while(csvLine.indexOf('"') > -1){
            
                if(startIndex == null){
                    startIndex = csvLine.indexOf('"');
                    csvLine = csvLine.substring(0, startIndex) + ':quotes:' + csvLine.substring(startIndex+1, csvLine.length());
                }else{
                    if(endIndex == null){
                        endIndex = csvLine.indexOf('"');
                        csvLine = csvLine.substring(0, endIndex) + ':quotes:' + csvLine.substring(endIndex+1, csvLine.length());
                    }
                }
                
                if(startIndex != null && endIndex != null){
                    String sub = csvLine.substring(startIndex, endIndex);
                    sub = sub.replaceAll(',', ':comma:');
                    csvLine = csvLine.substring(0, startIndex) + sub + csvLine.substring(endIndex, csvLine.length());
                    startIndex = null;
                    endIndex = null;
                }
            }
            List<String> csvRowData = new List<String>();
            for(String column : csvLine.split(';')){
                column = column.replaceAll(':quotes:', '').replaceAll(':comma:', ',');
                csvRowData.add(column);
            }

            String temp = csvRowData[2];
            Decimal myDecimal = Decimal.valueOf(temp.normalizeSpace());

            items.name__c = csvRowData[0];
            items.quantity = Decimal.valueOf(csvRowData[1]);
            items.UnitPrice = myDecimal;
            items.quoteId = quoteId;
            items.Product2Id = prod.id;
            items.PricebookEntryId = entry.id;

            lstQLsToInsert.add(items);
        }
        insert lstQLsToInsert;
        return lstQLsToInsert;
    }*/

    @AuraEnabled
    public static CallbackWrapper getItemPricing(String famCode, String itemNumber, String currencyArg, Integer custNo, Decimal quantityArg){
        //famCode = Util.switchFamCode(famCode);
        CallbackWrapper callback = new CallbackWrapper();
        callback.status = 'error';
        callback.message = 'Invalid description or item number';
        try {
            String argumentsString = '';
            if(itemNumber != null){
                System.debug('1');
                
                //itemNumber = itemNumber.replaceAll(' ', '%20');
                //itemNumber = itemNumber.replaceAll('[^0-9]', '');
                itemNumber = itemNumber.replaceAll('[^A-Za-z0-9()-_\\[\\]]', '');

                //itemNumber = itemNumber.replaceAll('[^A-Za-z0-9()\\[\\]]', '');
                System.debug('2');
                //String regex='/[0-9]+/g';
                //Matcher matcher = Pattern.compile(regex).matcher(itemNumber);
                System.debug('3');
                //Boolean result = matcher.find();
                System.debug('4');
                //System.debug('Matching String: '+matcher.group(0));
                //String xer = itemNumber = itemNumber.replaceAll('(\\s+)', '');
                //System.debug('123: '+xer +'END');
                argumentsString += '?cPfamCode=' +famCode + '&cPcurrency=' +currencyArg + '&cPcustNo=' + String.valueOf(custNo) + '&cPitemNumber=' + itemNumber + '&cPquantity=' +quantityArg;
            }
            
            else return callback;
            System.debug('Argumentstring: '+argumentsString);
            HttpRequest req = new HttpRequest();
            String uriWithParam = 'callout:azure_integration/erp-source/v1/item-net-price' +argumentsString;
            System.debug(uriWithParam);
            req.setEndpoint('callout:azure_integration/erp-source/v1/item-net-price'+argumentsString);
            req.setMethod('GET');
            req.setTimeout(120000); 
            req.setHeader('UnitCode', famCode);
            System.debug(req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());
            callback.status = 'success';
            callback.message = res.getBody();
            return callback;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static CallbackWrapper getItem(String famCode, String itemNumber){
        //famCode = Util.switchFamCode(famCode);
        CallbackWrapper callback = new CallbackWrapper();
        callback.status = 'error';
        callback.message = 'Invalid description or item number';
        try {
            String argumentsString = '';
            if(itemNumber != null){
                //itemNumber = itemNumber.replaceAll(' ', '%20');
                //itemNumber = itemNumber.replaceAll( '\\s+', '');
                //itemNumber = itemNumber.replaceAll('[^0-9]', '');
                itemNumber = itemNumber.replaceAll('[^A-Za-z0-9()-_\\[\\]]', '');

                argumentsString += '?itemNumber=' + itemNumber;
            }
            
            else return callback;
            System.debug('Argumentstring: '+argumentsString);
            HttpRequest req = new HttpRequest();
            String uriWithParam = 'callout:azure_integration/erp-source/v1/item' +argumentsString;
            System.debug(uriWithParam);
            req.setEndpoint('callout:azure_integration/erp-source/v1/item'+argumentsString);
            req.setMethod('GET');
            req.setTimeout(120000);
            req.setHeader('UnitCode', famCode);
            System.debug(req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());
            callback.status = 'success';
            callback.message = res.getBody();
            return callback;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static CallbackWrapper getItems(String famCode, String description, String itemNumber){
        CallbackWrapper callback = new CallbackWrapper();
        if(description != null) description = description.replaceAll(' ', '%20');
        if(itemNumber != null) itemNumber = itemNumber.replaceAll('[^A-Za-z0-9()-_\\[\\]]', '');
        callback.status = 'error';
        callback.message = 'Invalid description or item number';
        try {
            String argumentsString = '';
            if(description != null){
                argumentsString += '?itemDescription=' +description;
            }
            else if(itemNumber != null){
                argumentsString += '?itemNumber=' +itemNumber;
            }
            else return callback;
            System.debug('Argumentstring: '+argumentsString);
            HttpRequest req = new HttpRequest();
            String uriWithParam = 'callout:azure_integration/erp-source/v1/items' +argumentsString;
            System.debug(uriWithParam);
            req.setEndpoint('callout:azure_integration/erp-source/v1/items'+argumentsString);
            req.setMethod('GET');
            req.setTimeout(120000);
            req.setHeader('UnitCode', famCode);
            System.debug(req);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug(res.getBody());
            callback.status = 'success';
            callback.message = res.getBody();
            return callback;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }
    @AuraEnabled
    public static CallbackWrapper getObjectData(String recordId){
        List<Opportunity> oppList = [SELECT Id, RecordType.DeveloperName, CurrencyIsoCode, Account.CCUST__c, Account.FAM_Code__c FROM Opportunity WHERE Id = :recordId];
        List<Quote> quoteList = [SELECT Id, Opportunity.RecordType.DeveloperName, Opportunity.CurrencyIsoCode, Account.CCUST__c, Account.FAM_Code__c FROM Quote WHERE Id = :recordId];
        Map<String, String> hybridObject = new Map<String, String>();
        CallbackWrapper cbw = new CallbackWrapper();
        cbw.status = 'success';
        try {
            if(oppList.size() > 0){
                Opportunity opp = oppList[0];
                hybridObject.put('recordType', opp.RecordType.DeveloperName);
                hybridObject.put('currency', opp.CurrencyIsoCode);
                hybridObject.put('custno', opp.Account.CCUST__c);
                //String sandboxCompensatedFamcode = Util.switchFamCode(opp.Account.FAM_Code__c);
                hybridObject.put('famCode', opp.Account.FAM_Code__c);
            }
            else if (quoteList.size() > 0){
                Quote quote = quoteList[0];
                hybridObject.put('recordType', quote.Opportunity.RecordType.DeveloperName);
                hybridObject.put('currency', quote.Opportunity.CurrencyIsoCode);
                hybridObject.put('custno', quote.Account.CCUST__c);
                //String sandboxCompensatedFamcode = Util.switchFamCode(quote.Account.FAM_Code__c);
                hybridObject.put('famCode', quote.Account.FAM_Code__c);
            }
            cbw.message = JSON.serialize(hybridObject);
            System.debug(cbw.message);
            return cbw;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}