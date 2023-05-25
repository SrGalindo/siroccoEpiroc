trigger CheckOpportunityTeamExists on Opportunity (before update) {
    List<OpportunityTeamMember> opTeamWithOp = new List<OpportunityTeamMember>(
        [Select Id, OpportunityId From OpportunityTeamMember Where OpportunityId in :Trigger.new]);
    
    Set<Id> opWithTeam = new Set<Id>();
    for(OpportunityTeamMember otm : opTeamWithOp){
        opWithTeam.add(otm.OpportunityId);
    }
   
    For(Opportunity op : Trigger.new){
        if(op.Managed__c && op.StageName != 'Understand Needs' && op.StageName != 'Create Proposal'){
            if(!opWithTeam.contains(op.id)){
                op.addError('Least one opportunity team member need to add on, if Managed is checked under complex opportunity');
            }
        }
    }

}