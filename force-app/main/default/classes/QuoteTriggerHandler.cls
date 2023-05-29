public with sharing class QuoteTriggerHandler {
    public static void beforeInsert(List<Quote> quotesInc){
        System.debug('Quote before insert');
        Map<Id, List<Id>> opportunityQuotesMap = new Map<Id, List<Id>>();
        Map<Id, List<Id>> accountQuoteMap = new Map<Id, List<Id>>();
        Map<Id, Quote> quotesMap = new Map<Id, Quote>();

        for(Quote quote : quotesInc){
            if(quote.OpportunityId != null){
                List<Id> quotes = opportunityQuotesMap.get(quote.OpportunityId) == null ? new List<Id>() : opportunityQuotesMap.get(quote.OpportunityId);
                quotes.add(quote.Id);
                opportunityQuotesMap.put(quote.OpportunityId, quotes);
            } 
            quotesMap.put(quote.Id, quote);
        }

        List<Opportunity> opList = [SELECT Id, AccountId FROM Opportunity WHERE id IN : opportunityQuotesMap.keySet()]; 
        for(Opportunity op : opList){
            List<Id> quotes = opportunityQuotesMap.get(op.Id);
            accountQuoteMap.put(op.AccountId, quotes);
        }
        
        System.debug('oplist size: ' + opList.size());
        System.debug(opList);
        mapAddressesWithOpp(opportunityQuotesMap, quotesMap);
        mapAccountFields(quotesMap, accountQuoteMap);
    }

    public static void beforeUpdate(List<Quote> quotesInc, Map<Id, Quote> quotesIncMapOld){
        //Prequeries
        Quote quote = quotesInc[0];
        Quote quoteOld = quotesIncMapOld.get(quote.Id);
        List<Address__c> billToAddresses = [SELECT Id,Address_Line_1__c, Address_Line_2__c, Address_Line_3__c, Address__City__s, Address__PostalCode__s, Postal_code__c, Address__CountryCode__s, Address__StateCode__s, Address__Street__s, Country__c FROM Address__c WHERE Id = :quote.Bill_to__c WITH SECURITY_ENFORCED];
        if(billToAddresses.size() >0){
            List<Country__c> billToCountries = [SELECT Id, Tax_level__c, Alpha_2_Code__c FROM Country__c WHERE Id =: billToAddresses[0].Country__c WITH SECURITY_ENFORCED];
            Country__c billToCountry  = billToCountries[0];
            if(quote.Bill_to__c != quoteOld.Bill_To__c){
            Address__c newBillToAddress = billToAddresses[0];
            QuoteClass.connectBilltoAddresses(quote, newBillToAddress);
            }
        }
        if(quoteOld.VAT_Country__c != quote.VAT_Country__c){
            List<Country__c> vatCountrys = [SELECT Id, Tax_level__c FROM Country__c WHERE id = :quote.VAT_Country__c];
            if(vatCountrys.size() >0){
                Country__c vatCountry = vatCountrys[0];
                quote.TaxPerc__c = vatCountry.Tax_level__c;
            }
        }
        if(quote.TaxPerc__c != null){
            //quote.TaxPerc__c = vatCountry.Tax_level__c;
            quote.tax = getQuoteTax(quote.TaxPerc__c, quote.TotalPrice);
            quote.tax = quote.tax + getQuoteTax(quote.ShippingHandling, quote.TaxPerc__c);
        }
            
        // if(quote.Quote_Stage__c != quoteOld.Quote_Stage__c){
            
        // }
        //Update Currency on Opportunity for Simple Quote
        /*if(quote.IsSyncing == true && quote.CurrencyIsoCode != quoteOld.CurrencyIsoCode){
            Opportunity Opp = [select Id,CurrencyIsoCode from Opportunity where Id =: quote.OpportunityId];
            Opp.CurrencyIsoCode = quote.CurrencyIsoCode;
            
            update Opp; 
        }*/
    }

    public static Decimal getQuoteTax(Decimal taxLevel, Decimal totalValue){
        System.debug(taxLevel+'  '+ totalValue);
        if(totalValue == null || totalValue == 0) return 0;
        if(taxLevel == null)
        {
            taxLevel = 0;  
        } else {
            taxLevel = taxLevel / 100;
        }
        return taxlevel * totalValue;
    }

    private static void mapAddressesWithOpp(Map<Id, List<Id>> opportunityQuotesMap, Map<Id, Quote> quotesMap){
        Map<Id, Opportunity> oppWithAddress = new Map<Id, Opportunity>([
            SELECT Id, Account.Country__r.Tax_level__c, Account.Country__c, Bill_to__c, Bill_to__r.Country__r.Tax_level__c, Bill_to__r.Country__c, Bill_To_Address__City__s, Bill_To_Address__CountryCode__s, Bill_To_Address__PostalCode__s,
            Bill_To_Address__StateCode__s, Bill_To_Address__Street__s,Bill_to_Address_1__c, Bill_to_Address_2__c, Bill_to_Address_3__c, Bill_to_Postal_code__c,
            Ship_to__c, Ship_To_Address__City__s, Ship_To_Address__CountryCode__s, Ship_To_Address__PostalCode__s,
            Ship_To_Address__StateCode__s, Ship_To_Address__Street__s, Ship_to__r.Address_Line_1__c, Ship_to__r.Address_Line_2__c,
            Ship_to__r.Address_Line_3__c, Ship_to__r.Postal_code__c, AccountId, Amount
            FROM Opportunity 
            WHERE Id IN :opportunityQuotesMap.keySet() WITH SECURITY_ENFORCED]);

            for(Id oppId : opportunityQuotesMap.keySet()){
                Opportunity opp = oppWithAddress.get(oppId);
                List<Id> quotesIds = opportunityQuotesMap.get(oppId);
                for(Id quoteId : quotesIds){
                    Quote quote = quotesMap.get(quoteId);
                    //Look for opportunity bill to
                    if(opp.Bill_to__C != null){
                        QuoteClass.connectBilltoAddresses(quote, opp);
                        quote.TaxPerc__c = opp.Bill_to__r.Country__r.Tax_level__c;
                        quote.VAT_Country__c = opp.Bill_to__r.Country__c;
                        System.debug('Quote total price: '+opp.Amount);
                        quote.tax = getQuoteTax(opp.Bill_to__r.Country__r.Tax_level__c, opp.Amount);
                        //Default to account bill to
                    } else {
                        System.debug('getadr');
                        System.debug(opp.AccountId);
                        Address__c  billAddressFromAccount = getAddressByAccountId(opp.AccountId, 'Bill-to');
                        if(billAddressFromAccount != null){
                        System.debug('getadr2');
                            QuoteClass.connectBilltoAddresses(quote, billAddressFromAccount);
                        }
                        //Set tax levels
                        quote.TaxPerc__c = opp.Account.Country__r.Tax_level__c;
                        quote.VAT_Country__c = opp.Account.Country__c;
                        System.debug('find me');
                        System.debug(quote.TotalPrice);
                        quote.tax = getQuoteTax(quote.TaxPerc__c, quote.TotalPrice);
                        if(quote.ShippingHandling != null && quote.ShippingHandling > 0) {
                            quote.tax = quote.tax+getQuoteTax(quote.TaxPerc__c, quote.ShippingHandling);
                        }
                    }

                    if(opp.Ship_to__c != null){
                        System.debug('set ship to, opp have ship to');
                        System.debug(opp.Ship_to__c);
                        QuoteClass.connectShiptoAddresses(quote, opp);
                    } else {
                        System.debug('set ship to, opp Do not have ship to');
                        Address__c  shipAddressFromAccount = getAddressByAccountId(opp.AccountId, 'Ship-to');
                        System.debug(shipAddressFromAccount);
                        if(shipAddressFromAccount != null){
                            QuoteClass.connectShiptoAddresses(quote, shipAddressFromAccount);
                        }
                    }
                }
            }
    }
    private static void mapAccountFields(Map<Id, Quote> quotesMap, Map<Id, List<Id>> accountQuoteMap){
        Map<Id, Account> acctMap = new Map<Id, Account>([SELECT Id, Payment_Terms__c ,Incoterms__c, Country__r.Tax_level__c FROM Account where Id IN :accountQuoteMap.keySet() WITH SECURITY_ENFORCED]);
        for(Id accountId : accountQuoteMap.keySet()){
            for(Id quoteId : accountQuoteMap.get(accountId)){
                Quote quote = quotesMap.get(quoteId);
                Account acct = acctMap.get(accountId);
                
                if(quote.Incoterms__c == null){
                    quote.Incoterms__c  = acct.Incoterms__c;
                    
                }
    
                if(quote.Payment_Terms__c == null){
                    quote.Payment_Terms__c = acct?.Payment_Terms__c;
                }
            }
        }
    }
    private static Address__c getAddressByAccountId(Id accid, String addressType){
       List<Address__c> address = [SELECT Id, Country__r.Tax_level__c, Country__c, Address__c, Address__City__s, Address__CountryCode__s, Address__PostalCode__s, 
                                                 Address__StateCode__s, Address__Street__s,Address_Line_1__c, Address_Line_2__c,
                                                 Address_Line_3__c, Postal_code__c, Account__c 
                                                 FROM Address__c 
                                                 WHERE Account__c = :accId AND Address_type__r.Name = :addressType AND Primary__c = true WITH SECURITY_ENFORCED];
        System.debug('address in quote');
        //System.debug(address);
        if(address.size() > 0){
            System.debug('have primary address on accout');
            System.debug(address);
            return address[0];
        } else {
            return null;
        }
    }
}