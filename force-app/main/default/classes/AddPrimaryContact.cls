public class AddPrimaryContact implements Queueable {

    private Contact contacts;
    private String state;
    
    public AddPrimaryContact(Contact cons, String state) {
        this.contacts = cons;
        this.state = state;
    }
    
    public void execute(QueueableContext context) {
        List<Contact> newContacts = new List<Contact>();
        for (Account account : [select id, BillingState from Account where BillingState =:state limit 200]) {
            Contact con=contacts.clone(false,true,false,false);
            con.accountid=account.id;
           newContacts.add(con);
        }
        if(newContacts.size()>0)
       insert newContacts; 
    }
    
}