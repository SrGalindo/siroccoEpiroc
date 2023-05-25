public with sharing class UserTriggerHandler {
    public static void beforeInsert(List<User> usersInc){
        Set<String> federationIds = new Set<String>();
        for(User looper : usersInc){
            federationIds.add(looper.Email);
            looper.FederationIdentifier = looper.Email;
        }
        Map<Id, User> usersWithExistingFedId = new Map<Id, User>([SELECT Id,FederationIdentifier FROM User WHERE FederationIdentifier IN :federationIds]);
        if(usersWithExistingFedId.size() > 0){
            for(User looper : usersWithExistingFedId.values()){
                for(User userInc : usersInc){
                    if(userInc.FederationIdentifier == looper.FederationIdentifier){
                        userInc.FederationIdentifier = null;
                    }
                }
            }
        }
    }
    public static void afterInsert(List<User> usersInc){
        List<PermissionSetAssignment> newPSAssignments = new List<PermissionSetAssignment>();
        for(User looper : usersInc){
            PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Azure_API_Access'];
            PermissionSetAssignment psa = new PermissionSetAssignment();
            psa.PermissionSetId = ps.Id;
            psa.AssigneeId = looper.id;
            newPSAssignments.add(psa);
        }
        insert newPSAssignments;
    }
}