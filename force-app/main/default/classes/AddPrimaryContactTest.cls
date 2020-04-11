@isTest
public class AddPrimaryContactTest {

    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
       
        // add 50 accounts
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i, BillingState ='NY'
            ));
        }
        insert accounts;
        Contact con = new Contact(lastName='test',firstName='test2');
        insert con;
    }
    
    static testmethod void testQueueable() {
        
        List<Contact> cons = [select id, name from Contact where lastName = 'test' limit 1];
        // Create our Queueable instance
        AddPrimaryContact updater = new AddPrimaryContact(cons[0], 'NY');
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(updater);
        Test.stopTest();        
       
    }
}