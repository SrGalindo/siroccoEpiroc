public with sharing class AccountTriggerHandler {
    public static void afterInsert(List<Account> accountList){
        //calculateTerritory(accountList);
    }
    
    public static void beforeInsert(List<Account> accountList){
        Map<Id, Country__c> countryMap = new Map<Id, Country__c>([SELECT Id, Name, Alpha_2_Code__c FROM Country__c]);
        Account acc = accountList[0];
        if(acc.RecordTypeId == Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospect').getRecordTypeId()){
            for(Country__c cont : countryMap.values()){
                system.debug(cont);
                system.debug(cont.id);
            }
            system.debug(acc.name);
            system.debug(acc.country__c);
            setFamCode(acc, countryMap);
            setCurrency(acc, countryMap);
        }
    }

    public static void afterUpdate(List<Account> accountList){
        Account acc = accountList[0];
        //assignTerritory(acc);
        calculateTerritory(accountList);
    }

    public static void accConversionNotification(Map <Id,Account> oldRecord, Map <Id,Account> newRecord){
        
        Id RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
        
        for(Account looper:newRecord.values()){
            if((looper.RecordTypeId != oldRecord.get(looper.Id).RecordTypeId)){
                if(looper.RecordTypeId == RecordTypeId){
                    Messaging.CustomNotification notification = new Messaging.CustomNotification(); 
                    notification.setBody(looper.Name+' is changed from Prospect to Customer'); 
                    notification.setTitle('New Customer'); 
                    notification.setSenderId(Userinfo.getUserId()); 
                    CustomNotificationType type = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'Prospect_to_Customer'];  
                    notification.setNotificationTypeId(type.id); 
                    notification.setTargetId(looper.Id); // target record id 
                    notification.send(new Set<String> { looper.OwnerId });
                }
            }
        }
    }
    
    public static void assignTerritory(Account incAccount){
        List<UserTerritory2Association> userTerritoryAssociation = [SELECT Id,RoleInTerritory2, User.name, Territory2Id FROM UserTerritory2Association WHERE User.Id =: UserInfo.getUserId()];
        if(userTerritoryAssociation.size() > 0 && userTerritoryAssociation[0]?.Territory2Id != null){
        /*    ObjectTerritory2Association newAccAssociattion = new ObjectTerritory2Association();
            newAccAssociattion.Territory2Id = userTerritoryAssociation[0]?.Territory2Id;
            newAccAssociattion.ObjectId = incAccount.id;
            newAccAssociattion.AssociationCause = 'Territory2Manual';
            insert newAccAssociattion;*/ 
        }
    }

    public static void setFamCode(Account incAccount, Map<Id, Country__c> countriesInc){
        String countryCode = countriesInc.get(incAccount.Country__c).Alpha_2_Code__c;
        incAccount.Fam_code__c = FieldMappingTables.countryCodeToFamCode(countryCode);
    }

    public static void setCurrency(Account incAccount, Map<Id, Country__c> countriesInc){
        String countryCode = countriesInc.get(incAccount.Country__c).Alpha_2_Code__c;
        incAccount.CurrencyIsoCode = FieldMappingTables.countryCodeToCurrency(countryCode);
    }

    // public static void calculateTerritory(Account incAccount){
    //     if(incAccount != null){
    //         Account acc = [SELECT Id,Country__r.Name FROM Account WHERE Id  = :incAccount.Id];
    //         //Country__c currentCountry = countries.get(acc.Country__r.Alpha_2_Code__c);
    //         List<Territory2> territories = [SELECT id, name, Territory2Type.DeveloperName FROM Territory2 WHERE Name =: acc.Country__r.Name AND Territory2Type.DeveloperName = 'country'];
    //         if(territories.size() > 0){
    //             Territory2 territory = territories[0]; 
    //             ObjectTerritory2Association newAccAssociattion = new ObjectTerritory2Association();
    //             newAccAssociattion.Territory2Id = territory.Id;
    //             newAccAssociattion.ObjectId = incAccount.id;
    //             System.debug('territory.Id');
    //             System.debug(territory.Id);
    //             System.debug('a');
    //             System.debug('b');
    //             newAccAssociattion.AssociationCause = 'Territory2Manual';
    //             try {
    //                 insert newAccAssociattion;
    //             }
    //             catch(Exception e){
    //             }
    //         }
    //     }
    // }
    public static void calculateTerritory(List<Account> incAccounts){
        if(incAccounts != null){
            Set<Id> idSet = new Set<Id>();
            for(Account acc : incAccounts){
                idSet.add(acc.Id);
            }
            List<Account> accList = [SELECT Id,Country__r.Name FROM Account WHERE Id IN :idSet];
            //Country__c currentCountry = countries.get(acc.Country__r.Alpha_2_Code__c);
            Set<String> countries= new Set<String>();
            for(Account acc : accList){
                countries.add(acc.Country__r.Name);
            }
            List<ObjectTerritory2Association> newAssoc = new List<ObjectTerritory2Association>();
            List<Territory2> territories = [SELECT id, name, Territory2Type.DeveloperName FROM Territory2 WHERE Name =: countries AND Territory2Type.DeveloperName = 'country'];
            for(Account acc : accList){
                for(Territory2 terr : territories){
                    if(terr.Name == acc.Country__r.Name){
                        Territory2 territory = terr; 
                        ObjectTerritory2Association newAccAssociattion = new ObjectTerritory2Association();
                        newAccAssociattion.Territory2Id = territory.Id;
                        newAccAssociattion.ObjectId = acc.id;
                        System.debug('territory.Id');
                        System.debug(territory.Id);
                        System.debug('a');
                        System.debug('b');
                        newAccAssociattion.AssociationCause = 'Territory2Manual';
                        newAssoc.add(newAccAssociattion);
                    }
                }
            }
            if(newAssoc.size() > 0){
                try {
                    insert newAssoc;
                }
                catch(Exception e){
                }
            }
        }
    }

}