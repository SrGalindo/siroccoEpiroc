// Tested by EventTriggerHandlerTest

public class EventTriggerHandler {
    
    public static void createRecordInParentForEvent(List<Event> events) {
        
        for(Event data:events){
            try{
                List<Account> parent =[select id,ParentId,Name from Account where Id =: data.WhatId];
                if(parent.size()>0){
                    if(parent[0] != Null && parent[0].ParentId != Null){
                        createChatter(parent[0].Name, parent[0].ParentId, 'event');
                    }
                }
            }catch(DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
            
        }
    }
    
    public static void createRecordInParentForTask(List<Task> tasks) {
        for(Task data:tasks){
            try{
                List<Account> parent =[select id,ParentId,Name from Account where Id =: data.WhatId];
                if(parent.size()>0){
                    if(parent[0] != Null && parent[0].ParentId != Null){
                        createChatter(parent[0].Name, parent[0].ParentId, data.TaskSubtype);
                    }
                }
            }catch(DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
        }
    }
    
    public static void createChatter(string childAccName,Id ParentAccId, string typeOf) {
        
        FeedItem item = new FeedItem();
        item.Body = 'A new ' + typeOf + ' is created on '+ childAccName;
        item.ParentId = ParentAccId;
        insert item;
        
    }

}