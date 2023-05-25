public with sharing class OpportunityLineItemTriggerHandler {
   public static void beforeUpdate(Map<Id, OpportunityLineItem> oliMap){
    System.debug('OLI Before update');

   }
   public static void beforeInsert(List<OpportunityLineItem> oliList){
    System.debug('OLI Before insert');

    generalLoop(oliList);
   }
   public static void generalLoop(List<OpportunityLineItem> oliList){
    //General all-purpose loop, mainly for field setting
    //Get corresponding Quotelines.
    // Set<Id> idSet = new Set<Id>();
    // for(OpportunityLineItem looper : oliList){
    //     idSet.add(looper.OpportunityLineItemId);
    // }
    //Map<Id, OpportunityLineItem> oliMap = new Map<Id, OpportunityLineItem>([SELECT Id, Name__c, UnitPrice, List_Price__c,Item_number__c, Discount, Quantity, GAC__c, Division__c FROM OpportunityLineItem WHERE Id IN :idSet]);
    // for(QuoteLineItem looper : qliInc){
    //     if(oliMap.get(looper.OpportunityLineItemId) == null){
    //     }
    //}
    for(OpportunityLineItem looper : oliList){
        looper.Sales_price_net__c = looper.Unitprice * ((100-(looper.discount != null ? looper.discount : 0))/100);
    }
   }
//    public static void afterInsert(List<OpportunityLineItem> oliList){
//     System.debug('OLI after insert');
//     if(!TriggerGuard.oliguard) {
//            System.debug('Trigger guard (OLI)'+TriggerGuard.oliguard);
//         OpportunityLineItem oli = oliList[0];
//         //TriggerGuard.oliguard = true;
//         List<Quotelineitem> qliList = [SELECT Id FROM Quotelineitem WHERE Quote.OpportunityId = :oli.OpportunityId];
//         //update qliList;
//         // update the contacts.
//       }
//    }
}