public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numContacts,String lastname)
    {
        List<Contact> finalContacts=new List<Contact>();
        for(Integer i=1;i<=numContacts;i++)
        {
            finalContacts.add(new Contact(firstName='test '+i,LastName=lastname));
        }
        return finalContacts;
    }
    
}