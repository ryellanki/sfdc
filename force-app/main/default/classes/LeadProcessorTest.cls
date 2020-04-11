@isTest
private class LeadProcessorTest {
    
    @testSetup 
    static void setup() {
        
        List<Lead> leads = new List<Lead>();
        
        // insert 200 leads
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(LastName='Lead '+i, 
                Company ='New York', Status ='Open - Not Contacted'));
        }
        insert leads;
    }

    static testmethod void test() { 
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
    }
}