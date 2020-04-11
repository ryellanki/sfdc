global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful 
{
    private String query;
    
    public LeadProcessor(String Query)
    {
        this.query=Query;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        List<Lead> updateLeadList = new List<Lead>();
        for(Lead ld:scope)
        {
            ld.LeadSource='Dreamforce';
            updateLeadList.add(ld);
        }
        if(updateLeadList.size()>0)
            update updateLeadList;
            
        
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
}