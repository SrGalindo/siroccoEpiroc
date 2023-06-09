@isTest

public class AccountTriggerHandlerTest {
    
    @testSetup
    public static void setup(){
        
        Account acc = TestDataFactory.createSingelAccount();
        
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        
        System.RunAs(usr)
        {
            Test.startTest();
               insertTestTerritory(acc.Id);
            Test.stopTest();
        }
    }
    
    @isTest static void beforeInsertTest(){
        
        List<Account> accList = [Select Id from Account Limit 1];
        
        
        
        Test.startTest();
        //List<Account> accList = [Select Id from Account Limit 1];
        //System.assertEquals(acc_St.Stakeholder__c, stk.Id);
        Test.stopTest();
    }
    
     private static void insertTestTerritory(Id AccId)
    {
        
        List<Territory2Type> terriType   = [SELECT id, DeveloperName from Territory2Type where  DeveloperName = 'Country'];
        system.debug('terriType' + terriType.size());
        List<Profile> adminProfile = [select id, name from Profile where  name = 'System Administrator'];

        Territory2Model terrModel = new Territory2Model();
        terrModel .DeveloperName='ModelName'; // required field
        terrModel.Name = 'Name'; // required field
        insert terrModel ;

        Territory2 objTerr = new Territory2(DeveloperName = 'TestTerritory', Territory2ModelId=terrModel.Id, Name='TestTerritory', Territory2TypeId=terriType[0].Id);
        insert objTerr;
        
        ObjectTerritory2Association objObjectTerritory2Association = new ObjectTerritory2Association(ObjectId = AccId, Territory2Id =objTerr.Id, AssociationCause='Territory2Manual' );
        insert objObjectTerritory2Association;

        Profile p = [SELECT id, Name FROM Profile where name = 'System Administrator' ].get(0);  
        User u = new User(firstname= 'Test',
                  lastname='XXXX',
                  Alias='Test',
                  email = 'test1234@test.com',
                  username= 'test1234xxx@test.com', 
                  profileId= p.id, 
                  emailencodingkey='UTF-8',
                  languagelocalekey='en_US',
                  localesidkey='en_US',
                  timezonesidkey='America/Los_Angeles');
        insert u;
        
        User u2 = new User(firstname= 'Test',
                  lastname='XXXX',
                  Alias='Test',
                  email = 'test1234122@test.com',
                  username= 'test1234xxx123@test.com', 
                  profileId= p.id, 
                  emailencodingkey='UTF-8',
                  languagelocalekey='en_US',
                  localesidkey='en_US',
                  timezonesidkey='America/Los_Angeles');
        insert u2;
        
        UserTerritory2Association objUserTerritory2Association = new UserTerritory2Association(Territory2Id= objTerr.Id, UserId= u.Id, RoleInTerritory2='Sales / Marketing Manager');
        insert objUserTerritory2Association;

        UserTerritory2Association objUserTerritory2Association2 = new UserTerritory2Association(Territory2Id= objTerr.Id, UserId= u2.Id, RoleInTerritory2='Sales / Marketing Administrator');
        insert objUserTerritory2Association2 ;

        
    }

}