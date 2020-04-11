public class AccountProcessor {
    
    @future
    public static void countContacts(List<ID> accountids)
    {
        List<Account> updatedAccounts= new List<Account>();
        for(Account acc:[select id,(select id ,accountid from contacts),Number_of_Contacts__c from Account where id in:accountids])
        {
            if(acc.contacts.size()>0){
            acc.Number_of_Contacts__c = acc.contacts.size();
            updatedAccounts.add(acc);
            }
        }
        if(updatedAccounts.size()>0)
            update updatedAccounts;
            
    }

}