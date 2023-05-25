public with sharing class QuoteLineTriggerHandler {
  public static void beforeInsert(List<QuoteLineItem> qliInc){
    System.debug('QLI Before insert');
    Set<Id> idSet = new Set<Id>();
    for(QuoteLineItem looper : qliInc){
        idSet.add(looper.OpportunityLineItemId);
        System.debug('Before insert: ql oli id: '+looper.OpportunityLineItemId+'  '+looper.Name__c);
    }
    Map<Id, OpportunityLineItem> oliMap = new Map<Id, OpportunityLineItem>([SELECT Id, Name__c,Business_Line__c,Unit_of_Measure__c , UnitPrice, List_Price__c,Item_number__c, Discount, Quantity, GAC__c, Division__c FROM OpportunityLineItem WHERE Id IN :idSet]);
    beforeFieldMapping(qliInc, oliMap);
    }
  public static void beforeUpdate(List<QuoteLineItem> qliInc){
    System.debug('QLI Before update');
    Set<Id> idSet = new Set<Id>();
    for(QuoteLineItem looper : qliInc){
        idSet.add(looper.OpportunityLineItemId);
        System.debug('Before update: ql oli id: '+looper.OpportunityLineItemId+'  '+looper.Name__c);
    }
    Map<Id, OpportunityLineItem> oliMap = new Map<Id, OpportunityLineItem>([SELECT Id, Name__c, UnitPrice, List_Price__c,Item_number__c, Discount, Quantity, GAC__c, Division__c FROM OpportunityLineItem WHERE Id IN :idSet]);
    System.debug('field mapping test');
    //fieldMapping(qliInc, oliMap);
    List<OpportunityLineItem> updateList = new List<OpportunityLineItem>();
    for(OpportunityLineItem oliLooper : oliMap.values()){

    }
    }
    public static  void afterUpdate(List<QuoteLineItem> qliInc){
        /*System.debug('QLI after update');
        System.debug('Trigger guard (QLI)'+TriggerGuard.qliguard);
        if(!TriggerGuard.qliguard) {
            TriggerGuard.oliguard = true;
            Set<Id> idSet = new Set<Id>();
            for(QuoteLineItem looper : qliInc){
                idSet.add(looper.OpportunityLineItemId);
                System.debug('ql oli id: '+looper.OpportunityLineItemId+'  '+looper.Name__c);
            }
            List<OpportunityLineItem> oliList = [SELECT Id FROM OpportunityLineItem WHERE ID IN :idSet];
            System.debug('Starting oliList update frånn qli trig handler');
            System.debug('Starting oliList update frånn qli trig handler');
            update oliList;
        }*/
    }
    public static void beforeFieldMapping(List<QuoteLineItem> qliList, Map<Id, OpportunityLineItem> oliMap){
        for(QuoteLineItem looper : qliList){
            if(oliMap.get(looper.OpportunityLineItemId) != null){
                OpportunityLineItem connectedOli = oliMap.get(looper.OpportunityLineItemId);
                System.debug(connectedOli.Id);
                System.debug('before:: qli name: '+looper.Name__c+'  oli name: '+connectedOli.name__c);
                //if(connectedOli.Name__c == null) looper.Name__c = connectedOli.Name__c;
                looper.Name__c = connectedOli.Name__c;
                looper.UnitPrice = connectedOli.Unitprice;
                looper.Discount = connectedOli.Discount;
                looper.Quantity = connectedOli.Quantity;
                looper.List_Price__c = connectedOli.List_Price__c;
                looper.Item_number__c = connectedOli.Item_number__c;
                looper.Division__c = connectedOli.Division__c;
                looper.GAC__c = connectedOli.GAC__c;
                looper.Business_Line__c = connectedOli.Business_Line__c;
                looper.Unit_of_Measure__c = connectedOli.Unit_of_Measure__c;
                looper.Sales_price_net__c = looper.Unitprice * ((100-(looper.discount != null ? looper.discount : 0))/100);
            }
        } 
    }
    public static void fieldMapping(List<QuoteLineItem> qliList, Map<Id, OpportunityLineItem> oliMap){
    List<OpportunityLineItem> updateList = new List<OpportunityLineItem>();
        for(QuoteLineItem looper : qliList){
            if(oliMap.get(looper.OpportunityLineItemId) != null){
                OpportunityLineItem connectedOli = oliMap.get(looper.OpportunityLineItemId);
                System.debug(connectedOli.Id);
                System.debug('qli name: '+looper.Name__c+'  oli name: '+connectedOli.name__c);
                //if(connectedOli.Name__c == null) looper.Name__c = connectedOli.Name__c;
                connectedOli.Name__c = looper.Name__c;
                connectedOli.UnitPrice = looper.Unitprice;
                connectedOli.Discount = looper.Discount;
                connectedOli.Quantity = looper.Quantity;
                connectedOli.List_Price__c = looper.List_Price__c;
                connectedOli.Item_number__c = looper.Item_number__c;
                connectedOli.Division__c = looper.Division__c;
                connectedOli.GAC__c = looper.GAC__c;
                connectedOli.Sales_price_net__c = looper.Unitprice * ((100-(looper.discount != null ? looper.discount : 0))/100);
                updateList.add(connectedOli);
                looper.Sales_price_net__c = looper.Unitprice * ((100-(looper.discount != null ? looper.discount : 0))/100);
                //looper.Name__c = connectedOli.Name__c;
                // looper.UnitPrice = connectedOli.Unitprice;
                // looper.Discount = connectedOli.Discount;
                // looper.Quantity = connectedOli.Quantity;
                // looper.List_Price__c = connectedOli.List_Price__c;
                // looper.Item_number__c = connectedOli.Item_number__c;
                // looper.Division__c = connectedOli.Division__c;
                // looper.GAC__c = connectedOli.GAC__c;
            }
        }
        if(updateList.size() > 0){
            update updateList;
        }
    }
}