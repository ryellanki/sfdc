@isTest
public class TestRestrictContactByName {
    
    @isTest static void testDml()
    {
        Contact newCont= new Contact(FirstName='Sample',LastName='INVALIDNAME');
        Test.startTest();
        Database.SaveResult result = Database.insert(newCont, false);
        Test.stopTest();
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML', result.getErrors()[0].getMessage());
    }

}