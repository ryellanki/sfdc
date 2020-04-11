@isTest
public class DailyLeadProcessorTest {

     public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob() {

        // Create some out of date Opportunity records
        List<Lead> opptys = new List<Lead>();
        for (Integer i=0; i<50; i++) {
            Lead o = new Lead(LastName='Lead '+i, 
                Company ='New York', Status ='Open - Not Contacted'
            );
            opptys.add(o);
        }
        insert opptys;
        
         Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,new DailyLeadProcessor());
    Test.stopTest();
    }
    
   
   
}