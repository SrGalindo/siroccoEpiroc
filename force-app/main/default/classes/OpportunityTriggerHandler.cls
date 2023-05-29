/**
 * @description       : 
 * @author            : Ahmad Nawaz
 * @group             : 
 * @last modified on  : 19-09-2022
 * @last modified by  : Ahmad Nawaz
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   19-09-2022   Ahmad Nawaz   Initial Version
 * Tested By : OpportunityTriggerHandlerTest
**/

public with sharing class OpportunityTriggerHandler {
    public static void afterUpdate(List<Opportunity> opportunitiesInc){
        System.debug('afterUpdate Opportunity');
        oliUpdates(opportunitiesInc);
        addressUpdates(opportunitiesInc);
    }

    public static void addressUpdates(List<Opportunity> opportunitiesInc){
        Set<Id> addressIds = new Set<Id>();
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
        for(Opportunity oppLooper : opportunitiesInc){
            addressIds.add(oppLooper.Ship_To__c);
            oppMap.put(oppLooper.Id, oppLooper);
        }
        List<Address__c> addrList = new List<Address__c>();
        Map<Id, Address__c> addressess = new Map<Id, Address__c>([SELECT Id, Account__c FROM Address__c WHERE Id IN: addressIds WITH SECURITY_ENFORCED]);
        if(addressess.size() > 0){
            for(Opportunity oppLooper : opportunitiesInc){
                if(addressess.get(oppLooper.Ship_To__c)  != null){
                    Address__c addr = addressess.get(oppLooper.Ship_To__c);
                    if(addr.Account__c == null){
                        addr.Account__c = oppLooper.AccountId;
                        addrList.add(addr);
                    }
                }
            }
            if(addrList.size() > 0){
                update addrList;
            }
        }
    }

    public static void oliUpdates(List<Opportunity> opportunitiesInc){
        Set<Id> syncedQuoteIds = new Set<Id>();
        Set<Id> opIds = new Set<Id>();
        for(Opportunity opp : opportunitiesInc){
            if(opp.SyncedQuoteId != null){
                syncedQuoteIds.add(opp.SyncedQuoteId);
            }
            opIds.add(opp.Id);
        }

        List<QuoteLineItem> quoteLines = [SELECT Id, Name__c,Item_number__c, Description,Unit_of_Measure__c,Business_Line__c, Division__c, List_price__c, GAC__c, OpportunityLineItemId FROM QuoteLineItem WHERE QuoteId IN :syncedQuoteIds WITH SECURITY_ENFORCED];
        Map<Id, OpportunityLineItem> opLineItems = new Map<Id, OpportunityLineItem>([SELECT Id, Name__c FROM OpportunityLineItem WHERE OpportunityId IN :opIds WITH SECURITY_ENFORCED]);
        
        List<OpportunityLineItem> oppLinItemsToUpdate = new List<OpportunityLineItem>();
        if(quoteLines.size()>0){
        for(QuoteLineItem ql : quoteLines){
            OpportunityLineItem referencedOi = opLineItems.get(ql?.OpportunityLineItemId);
            if(referencedOi != null){
                referencedOi.Name__c = ql.Name__c;
                referencedOi.Description = ql.Description;
                referencedOi.Item_number__c = ql.Item_number__c;
                referencedOi.Division__c = ql.Division__c;
                referencedOi.List_price__c = ql.List_price__c;
                referencedOi.GAC__c = ql.GAC__c;
                referencedOi.Business_Line__c = ql.Business_Line__c;
                referencedOi.Unit_of_Measure__c = ql.Unit_of_Measure__c;
                oppLinItemsToUpdate.add(referencedOi);
            }
        }
        }
        
        update oppLinItemsToUpdate;
    }

    public static void beforeInsert(List<Opportunity> opportunitiesInc){
        System.debug('Before insert');
        mapBillToFields(opportunitiesInc);
        mapShipToFields(opportunitiesInc);
    }

    private static void mapBillToFields(List<Opportunity> opportunitiesInc){
        Set<Id> accIds = new Set<Id>();
        system.debug('trig handler opp');
        for(Opportunity op : opportunitiesInc){
            system.debug(op.Pricebook2);
            accIds.add(op.AccountId);
        }

        Map<id, Address__c> oppAddressMap = new Map<id, Address__c>();
        List<Address__c> billToAddresses= getAddressByAccountIds(accIds, 'Bill-to');

        if(!billToAddresses.IsEmpty()){
            oppAddressMap = mapOppotunityWithAddress(opportunitiesInc, billToAddresses, oppAddressMap);
        }
        
        if(!oppAddressMap.IsEmpty()){
            for(Opportunity op : opportunitiesInc){
                Address__c addressToMap = oppAddressMap.get(op.id);
                if(addressToMap != null){
                    OpportunityClass.connectBilltoAddresses(op, addressToMap);
                }
                System.debug('after mapping bill-to');
                System.debug(addressToMap);
            }
        }
    }

    private static void mapShipToFields(List<Opportunity> opportunitiesInc){
        Set<Id> endcustomerAddIds = new Set<Id>();
        Set<Id> accIds = new Set<Id>();
        for(Opportunity op : opportunitiesInc){
            if(op.End_Customer__c != null){
                endcustomerAddIds.add(op.End_Customer__c);
            }
            accIds.add(op.AccountId);
        }

        Map<id, Address__c> oppAddressMap = new Map<id, Address__c>();
        List<Address__c> endCustomerShipToAddresses = getAddressByAccountIds(endcustomerAddIds, 'Ship-to');
        List<Address__c> existsShiptoAdress = getAddressByAccountIds(accIds, 'Ship-to');

        if(endCustomerShipToAddresses.size() > 0){
            oppAddressMap = mapOppotunityWithAddress(opportunitiesInc, endCustomerShipToAddresses, oppAddressMap);
        }
        if(existsShiptoAdress.size() > 0){
            oppAddressMap = mapOppotunityWithAddress(opportunitiesInc, existsShiptoAdress, oppAddressMap);
        }
            
        if(oppAddressMap.size() > 0){
            for(Opportunity op : opportunitiesInc){
                Address__c addressToMap = oppAddressMap.get(op.id);
                if(addressToMap != null){
                    OpportunityClass.connectShiptoAddresses(op, addressToMap);
                }
                System.debug('after mapping ship-to');
                System.debug(addressToMap);
            }
        }
    }

    public static void beforeUpdate(List<Opportunity> opportunitiesInc, List<Opportunity> opportunitiesOldInc){
        Id shipToAccIdOnlyUseOne = opportunitiesInc[0].AccountId;
        Opportunity triggeringOpp = opportunitiesInc[0];
        Opportunity triggeringOppOld = opportunitiesOldInc[0];
        if(triggeringOpp.Bill_to__c != triggeringOppOld.Bill_To__c){
            setBillTo(triggeringOpp);
        }
        if(triggeringOpp.Ship_To__c != triggeringOppOld.Ship_To__c){
            setShipTo(triggeringOpp);
        }
    }

    public static void setBillTo(Opportunity opp){
        List<Address__c> billToAddresses = [SELECT Id, Address__c, Address__Street__s, Address__postalCode__s, Address__StateCode__s, 
                                            Address__countryCode__s, Address__City__s, Address_Line_1__c, Address_Line_2__c, Address_Line_3__c, Postal_code__c 
                                            FROM Address__c 
                                            WHERE id = :opp.Bill_To__c WITH SECURITY_ENFORCED];
        if(billToAddresses.size() > 0){
            Address__c billToAddress = billToAddresses[0];
            OpportunityClass.connectBilltoAddresses(opp, billToAddress);
        }
    }

    public static void setShipTo(Opportunity opp){
        List<Address__c> shipToAddresses = [SELECT Id, Address__c, Address__Street__s, Address__postalCode__s, Address__StateCode__s, 
                                            Address__countryCode__s, Address__City__s, Address_Line_1__c, Address_Line_2__c, Address_Line_3__c, Postal_code__c 
                                            FROM Address__c 
                                            WHERE id = :opp.Ship_To__c WITH SECURITY_ENFORCED];
        if(shipToAddresses.size() > 0){
            Address__c shipToAddress = shipToAddresses[0];
            OpportunityClass.connectShiptoAddresses(opp, shipToAddress);
        }
    }

    private static Map<Id, Address__c> mapOppotunityWithAddress(List<Opportunity> opportunties, List<Address__c> adresses, Map<id, Address__c> oppAddressMap){
        for(Address__c address : adresses){
            for(Opportunity op : opportunties){
                if((oppAddressMap.IsEmpty() || oppAddressMap.get(op.Id) == null) && (op.AccountId == address.Account__c || op.End_Customer__c == address.Account__c)){
                    oppAddressMap.put(op.Id, address);
                }
            }
        } 
        return oppAddressMap;
    }

    private static List<Address__c> getAddressByAccountIds(Set<Id> accids, String addressType){

        List<Address__c> addresses = [SELECT Id, Address__c, Address__City__s, Address__CountryCode__s, Address__PostalCode__s, 
                                                 Address__StateCode__s, Address__Street__s,Address_Line_1__c, Address_Line_2__c,
                                                 Address_Line_3__c, Postal_code__c, Account__c 
                                                 FROM Address__c 
                                                 WHERE Account__c IN :accIds AND Address_type__r.Name = :addressType AND Primary__c = true WITH SECURITY_ENFORCED];

        return addresses;
    }
}