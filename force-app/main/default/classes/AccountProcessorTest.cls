@isTest
public class AccountProcessorTest {

    @isTest static void testContactCount()
    {
        List<Account> accslist= new List<Account>();
        Account acc = new Account(Name='Sample');
        insert acc;
        
        List<ID> accids= new List<ID>();
        accids.add(acc.id);
        
        List<Contact> consList = new List<Contact>();
        consList.add(new Contact(FirstName='Test',LastName='Test2',accountid=acc.id));
        insert consList;
        
        Test.startTest();
        AccountProcessor.countContacts(accids);
        Test.stopTest();
        
    }
    
}