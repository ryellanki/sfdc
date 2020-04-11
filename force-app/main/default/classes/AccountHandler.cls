public class AccountHandler
{


/*

List<AggregateResult> acc= [SELECT PAIS_External_ID__c, COUNT(Id) FROM Account GROUP BY PAIS_External_ID__c HAVING COUNT(Id) > 1];
Set<String> dupIDSet = new Set<String>();
for(AggregateResult aggres : acc)
{
     dupIDSet.add(string.valueOf(aggres.get('PAIS_External_ID__c')));
    
//System.debug('Finding duplicate names'+aggres.get('PAIS_External_ID__c'));
    
} 

List<Account> fAccList = [select id, Recordtype.Name,PAIS_External_ID__c,Name,createddate from Account where PAIS_External_ID__c=:dupIDSet and PAIS_External_ID__c!=null and recordtype.name='Producer'];
List<String> csvRowValues = new List<String>();
for(Account acc:fAccList)
{
            String ID = acc.id;
            String RecordtypeName = acc.Recordtype.Name;
            String PAISKey = acc.PAIS_External_ID__c;
            DateTime createddate = acc.createddate;
            String AccountName = acc.Name.replaceAll(',','');
    
     String rowStr = ID + ',' + RecordtypeName + ',' + PAISKey + ',' + createddate + ','+ AccountName;
    csvRowValues.add(rowStr);
    
    
    
    
    system.debug('Record Type ->'+acc.Recordtype.Name +'-- External ID ->'+acc.PAIS_External_ID__c +'-- Name -- '+acc.Name+'--Createddate--'+acc.createddate);
}

 
  List<Folder> folders = [SELECT Id, Name FROM Folder where id='00lA0000000YaKlIAK'];
  
    String documentName ='RecordsTobeDeletedProducer';
    String csvColumnHeader = 'ID, RecordtypeName, PAISKey, createddate, AccountName\n';
    String csvFile = csvColumnHeader + String.join(csvRowValues,'\n');
           
           
            Document doc = new Document(Name = documentName, Body = Blob.valueOf(csvFile), FolderId = folders[0].Id, Type = 'csv', ContentType='application/vnd.ms-excel');
            insert doc;




1. What is Lightning 
Ans: Lightning is combination of tools and technologies to build applications on Salesforce Platform.
     Lightning includes
     
     1. Lightning components : Lightning components use Lightning Component framework for developing single page applications for Mobile and Desktop.
     2. Lightning App Builder : It has drag and drop capabilities to build lightning record pages and app pages.
     3. Community Builder : To build communities on Salesforce platform using Lightning templates and components.
     
2. What Is the Lightning Component Framework?

Ans: The Lightning Component framework is a UI framework for developing single page applications for mobile and desktop devices.
     It uses JavaScript on the client side and Apex on the server side

3. Why Use the Aura Components Programming Model?

Ans : The benefits include an out-of-the-box set of components, event-driven architecture, and a framework optimized for performance.

    Out-of-the-box Components : Comes with an out-of-the-box set of components to kick start building apps.
    Rich Component Ecosystem : Drag and drop capabilities to build lightning pages.
    Fast Development : Empowers teams to work faster with out-of-the-box components that function seamlessly with desktop and mobile devices. 
    Building an app with components facilitates parallel design, improving overall development efficiency.
    Device-aware and Cross Browser Compatibility: Apps use responsive design and support the latest in browser technology such as HTML5, CSS3, and touch events.
    
4. Aura Components ?
Ans: Aura components are the self-contained and reusable units of an app. They represent a reusable section of the UI, 
     and can range in granularity from a single line of text to an entire app.
     
     Aura component markup is XML
     
5. Tools used to develop Lighting components ?

    Developer Console.
    Force.com IDE
    
6. Events in Salesforce Lightning

    The communication between components are handled by events. There are two types for events.
    1. Component Event : Component Events can only be handled by components and the communication will be simple between components:
    https://www.mstsolutions.com/technical/salesforce-lightning-events/
    By using component event, the values can be passed from a child component to a parent component via event.
    
    2. Application Events : application events follow a traditional publish-subscribe model. An application event is fired from an instance of a component.
    All components that provide a handler for the event are notified.
    
    
    
7. Locker service in lightning Salesforce

Ans: Locker Service is a powerful security architecture for Lightning components.
      
      Locker Service enhances security by isolating Lightning components that belong to one namespace from components in a different namespace. 
      Locker Service also promotes best practices that improve the supportability of your code by only allowing access to supported APIs and eliminating 
      access to non-published framework internals.
      Prevent:
        1. Components from causing XSS and similar security issues
        2. Components from reading other componentâ€™s rendered data without any restrictions
        3. Components from calling undocumented/private APIs
        4. Enforces CSP(Content Security Policy), which is a security standard to protect against XSS, clickjacking and other code injection attacks
            
    
8. Lightning Attribute types:

    Collection Types :
   
    <aura:attribute name="colorPalette" type="String[]" default="['red', 'green', 'blue']" />
    <aura:attribute name="colorPalette" type="List" default="['red', 'green', 'blue']" />
    <aura:attribute name="sectionLabels" type="Map" default="{ a: 'label1', b: 'label2' }" />
    <aura:attribute name="collection" type="Set" default="['red', 'green', 'blue']" />
    
    Basic Types:
    <aura:attribute name="showDetail" type="Boolean" />, Date, DateTime, Decimal, Double, Integer, Long, String
    
    Standard and Custom Object Types:
    
    <aura:attribute name="acct" type="Account" />
    <aura:attribute name="expense" type="Expense__c" />

    
    
    
IMP Links:

http://simpluslabs.com/working-and-usage-of-forcerefreshview-in-lightning/
https://www.mstsolutions.com/technical/salesforce-lightning-events/


     

trigger AccountTriggerNew on Account (before insert, before update, after insert, after update)
{
    ByPass_Trigger_Config__c byPass = ByPass_Trigger_Config__c.getAll().get('AccountTeamCreation');
    boolean runTrigger = (byPass != null ? (byPass.User_List__c != null ? ((byPass.Block_Trigger__c && byPass.User_List__c.contains(userInfo.getUserName())) ? false : true) :true) :true);
    
    if (runTrigger)
    {
        system.debug('#### Bypass = False');
        //Calling Trigger Factory
        TriggerFactory.createHandler(Account.sObjectType);
    }
    else
    {
        system.debug('#### Bypass = True');
    }
}




public with sharing class TriggerFactory {
 
 private static boolean isActiveHandler;
 
 //Method for Handler Instance Creation for particular object
 public static void createHandler(Schema.sObjectType soType) {  
  isActiveHandler = false;
  ITrigger handler = getHandler(soType);
  
  if(handler == null) {
   throw new TriggerFactoryException('Exception: No Trigger Handler registered for Object Type: ' + soType);
  }else if(handler != null && (!isActiveHandler)) {
    system.debug('Exception: No Active Trigger Handler registered for Object Type: ' + soType);
  }else{
  // Execute the handler to fulfil the trigger
  execute(handler);
  }
 
  
 }
 
 //Method to start Trigger Execution
 private static void execute(ITrigger handler) {
  // Before Trigger
  if(Trigger.isBefore) {
   handler.bulkBefore();
  }
  else {
   handler.bulkAfter();
  }
 }
 
 //Method for Handler assignment to handler instance for particular object
 private static ITrigger getHandler(Schema.sObjectType soType) {
  
 //Fetching Custom MetaData Record Setting based on sObjectType to get TriggerHandler defined
 String sobjtype = string.valueof(soType);
 List<TriggerHandlerMapping__mdt> TrgHndlrCustMetadata = [select IsActive__c,sObjectType__c,TriggerHandlerName__c, DeveloperName, MasterLabel from TriggerHandlerMapping__mdt where sObjectType__c = :sobjtype];
 system.debug('TrgHndlrCustMetadata###'+TrgHndlrCustMetadata);
  
 for(TriggerHandlerMapping__mdt eachTrgHandler : TrgHndlrCustMetadata) {
    system.debug('Handler###'+eachTrgHandler.TriggerHandlerName__c);
    system.debug('IsActive###'+eachTrgHandler.IsActive__c);
    
        //If TriggerHandler Found
        String trgHandlerName = eachTrgHandler.TriggerHandlerName__c;
        Type t = Type.forName(trgHandlerName);
        ITrigger obj = (ITrigger)t.newInstance();
        isActiveHandler = eachTrgHandler.IsActive__c;
        return obj;
    
 } 
  return null;
 }
 //Dummy Exception class to throw exception when Handler is not assigned
 public with sharing class TriggerFactoryException extends Exception {
     
 }
 
}


public interface ITrigger {
 void bulkBefore();
 void bulkAfter();
}

Account false IsActive__c true TriggerHandlerName__c AccountTriggerHandlerNew sObjectType__c Account

public class AccountTriggerHandlerNew implements ITrigger
{
    public void bulkBefore()
    {
        try
        {
            //Copy account address from Account to Contact in case of an address match
            AccountHandler.accountToContactAddress();
            
            //Enterprise Distributor and Sponsor Checks
            AccountHandler.beforeEventMethod(); } catch (Exception ex) {
            system.debug('#### Ex: ' + ex);
        }
    }
    
    public void bulkAfter()
    {
        try
        {
            //Account Team Creation
            AccountHandler.teamCreation();
            
            //Enterprise Distributor and Sponsor Checks
            AccountHandler.afterEventMethod (); } catch (Exception ex) {
            system.debug('#### Ex: ' + ex);
        }
    }
}



public class AccountHandler
{
    //This method is responsible for copying account address from Account to Contact in case of an address match.
    public static void accountToContactAddress ()
    {
        List<Account> listAccount = new List<Account>();
        Map<Id, Account> mapAccount = new Map<Id, Account>();
        if (Trigger.IsUpdate)
        {
            listAccount = trigger.New;
            mapAccount = (Map<Id, Account>) trigger.newMap;
        }
        
        if (listAccount == null || listAccount.size() == 0)
        {return;}
        
        Id ABARercordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('ABA Firm').getRecordTypeId();
        List<Contact> listTempCon;
        Map<Id, List<Contact>> mapAccIDCon = new Map<Id, List<Contact>>();
        Account oldAcc;
        Boolean temp;
        List<Contact> listConUpdate = new List<Contact>();
        
        Set<Id> setAccId = new set<Id>();
        for (Account accObj : mapAccount.values())
        {
            if(accObj.recordtypeid != ABARercordtypeId)
            {
                setAccId.add(accObj.Id);
            }
        }
        
        //Querying related contact data.
        List<Contact> listCon = [select id, name, OtherStreet, OtherCity, OtherState,Combined_Other_Address__c,MailingStreet, 
                                    MailingCity, MailingState, Combined_Mailing_Address__c, accountId from Contact 
                             where accountId IN :setAccId and IsPersonAccount = false];
                             
        if (listCon != null & listCon.size() > 0)
        {
            for (Contact con : listCon)
            {
                listTempCon = new List<Contact>();
                if (mapAccIDCon.containsKey(con.accountId))
                {
                    listTempCon = mapAccIDCon.get(con.accountId);
                    listTempCon.add(con);
                    mapAccIDCon.put(con.accountId, listTempCon);             
                }
                else
                {
                    listTempCon.add(con);
                    mapAccIDCon.put(con.accountId, listTempCon);
                }
            }
            
            for (Account acc : listAccount)
            {
                if (acc.recordTypeId != ABARercordtypeId)
                {
                    if (mapAccIDCon.containsKey(acc.Id))
                    {
                        listTempCon = mapAccIDCon.get(acc.Id);
                        oldAcc = (Account) Trigger.oldMap.get(acc.ID);
                        
                        system.debug('#### Combined_Billing_Address__c  --> ' + acc.Combined_Billing_Address__c );
                        system.debug('#### Combined_Shipping_Address__c  --> ' + acc.Combined_Shipping_Address__c );
                        system.debug('#### oldAcc Combined_Billing_Address__c  --> ' + oldAcc.Combined_Billing_Address__c + '\'' );
                        system.debug('#### oldAcc Combined_Shipping_Address__c  --> ' + oldAcc.Combined_Shipping_Address__c );
                        
                        for (Contact con : listTempCon)
                        {
                            temp = false;
                
                            system.debug('#### con.Combined_Mailing_Address__c  --> ' + con.Combined_Mailing_Address__c + '\''  );
                            system.debug('#### con.Combined_Other_Address__c  --> ' + con.Combined_Other_Address__c + '\''  );
                                    
                            //Copying business to mailing.
                            //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                            if ((oldAcc.Combined_Billing_Address__c != acc.Combined_Billing_Address__c) && (oldAcc.Combined_Billing_Address__c == con.Combined_Mailing_Address__c))
                            {
                                system.debug('#### Copying business to mailing');
                                con.MailingStreet = acc.BillingStreet;
                                con.MailingCity = acc.BillingCity;
                                con.MailingState = acc.BillingState; 
                                con.MailingCountry  = acc.BillingCountry; 
                                con.MailingPostalCode = acc.BillingPostalCode;
                                con.MailingStateCode = acc.BillingStateCode;
                                con.MailingCountryCode = acc.BillingCountryCode;
                            
                                temp = true;
                            
                            }
                            
                            //Copying Shipping Address to other.
                            //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                            if ((oldAcc.Combined_Shipping_Address__c != acc.Combined_Shipping_Address__c) && (oldAcc.Combined_Shipping_Address__c == con.Combined_Other_Address__c))
                            {
                                system.debug('Copying shipping to other' );
                                con.OtherStreet  = acc.ShippingStreet;
                                con.OtherCity  = acc.ShippingCity;
                                con.OtherState = acc.ShippingState; 
                                con.OtherCountry  = acc.ShippingCountry; 
                                con.OtherPostalCode = acc.ShippingPostalCode;
                                con.OtherStateCode = acc.ShippingStateCode;
                                con.OtherCountryCode = acc.ShippingCountryCode;
                            
                                temp = true;
                            }
                        
                            if (temp)
                            {
                                listConUpdate.add(con);         
                            }
                        }
                    }
                }
            }
            
            //Updating Contact Records.
            if (!Test.isRunningTest())
            {
                Database.SaveResult[] srList = Database.update(listConUpdate, false);   
                ErrorLogging.logError(srList, 'Trigger - AccountTrigger: AccountAddressToContactCopyHandler');
            }
        }
    }
    
    //Enterprise Distributor and Sponsor Checks: Before Event
    public static void beforeEventMethod ()
    {
        Id ABARercordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('ABA Firm').getRecordTypeId();
        List<Account> listAccount = new List<Account>();
        List<Account> listOldAccount = new List<Account>();
        Map<Id, Account> mapOldAccount = new Map<Id, Account>();
        Map<Id, Account> mapNewAccount = new Map<Id, Account>();
        List<Account> listESRAcc = new List<Account>();
        
        if (Trigger.IsInsert || Trigger.isUpdate)
        {
            String exclusionSponsorRecords = System.Label.ECRM_ExclusionSponsors;
            
            for (Account acc : (List<Account>) Trigger.New)
            {
                if (acc.recordTypeId != ABARercordtypeId)
                {
                    listAccount.add(acc);
                    
                    if (acc.Name != 'Dummy Plan Sponsor' && !(acc.Id != null && exclusionSponsorRecords != null && exclusionSponsorRecords.contains((String.valueOf((acc.Id)).substring(0,15)))))
                    {
                        System.debug('#### Match  ---> ' + true);
                        listESRAcc.add(acc);
                    }
                    else
                    {
                        System.debug('#### Match  ---> ' + false);
                    }
                }
            }
            
            EnterpriseHandler eHandler = new EnterpriseHandler();
            if (listAccount != null && listAccount.size() > 0)
            {
                eHandler.enterpriseDistributorCheck(listAccount);
            }
            if (listESRAcc != null && listESRAcc.size() > 0)
            {
                eHandler.enterpriseSponsorCheck(listESRAcc);
            }
            
            AccountTriggerHandler handler = new AccountTriggerHandler(Trigger.isExecuting, Trigger.size);
            handler.isBefore = Trigger.isBefore;
            handler.isInsert = Trigger.isInsert;
            handler.isUpdate = Trigger.isUpdate;
            if (Trigger.isInsert)
            {
                handler.OnBeforeInsert(listAccount);   
            }
            if (Trigger.isUpdate)
            {
                for (Account acc : (List<Account>) Trigger.oldMap.values())
                {
                    if (acc.recordTypeId != ABARercordtypeId)
                    {
                        listOldAccount.add(acc);
                        mapOldAccount.put(acc.Id, acc);
                    }
                }
                handler.OnBeforeUpdate(listAccount, listOldAccount, mapNewAccount, mapOldAccount);
            }
        }        
    }
    
    //Enterprise Distributor and Sponsor Checks: After Event
    public static void afterEventMethod ()
    {
        Id ABARercordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('ABA Firm').getRecordTypeId();
        AccountTriggerHandler handler = new AccountTriggerHandler(Trigger.isExecuting, Trigger.size);
        handler.isAfter = Trigger.isAfter;
        handler.isInsert = Trigger.isInsert;
        handler.isUpdate = Trigger.isUpdate;
        Map<Id, Account> mapNewAccount = new Map<Id, Account>();
        Map<Id, Account> mapOldAccount = new Map<Id, Account>();
        List<Account> listOldAccount = new List<Account>();
        List<Account> listAccount = new List<Account>();
        
        if (Trigger.isInsert)
        {
            for (Account acc : (List<Account>) Trigger.newMap.values())
            {
                if (acc.recordTypeId != ABARercordtypeId)
                {
                    mapNewAccount.put(acc.Id, acc);
                }
            }
            handler.OnAfterInsert(mapNewAccount.values()); 
        }
        
        if (Trigger.isUpdate)
        {
            for (Account acc : (List<Account>) Trigger.oldMap.values())
            {
                if (acc.RecordTypeId != ABARercordtypeId)
                {
                    listOldAccount.add(acc);
                    mapOldAccount.put(acc.Id, acc);
                }
            }
            handler.OnAfterUpdate(listAccount, listOldAccount, mapNewAccount, mapOldAccount); 
        }        
    }
    
    
    static AccountTeamMember atm;
    static List<AccountTeamMember> atmList = new List<AccountTeamMember>();
    
    //This method is responsible for creating Account team records
    public static void teamCreation()
    {
        //Declaring variables.
        Id ABARercordtypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('ABA Firm').getRecordTypeId();
        List<Account> listAccount = new List<Account>();
        listAccount = Trigger.New;
        List<Id> lstAccId = new List<Id>();
        Account oldAccount = new Account();
        Map<Id,Id> crmMap = new Map<Id,Id>();
        Map<Id,Id> coprInternalWholeSalerMap = new Map<Id,Id>();
        Map<Id,Id> corpRVPMap = new Map<Id,Id>();
        Map<Id,Id> dayToDayVPMap = new Map<Id,Id>();
        Map<Id,Id> osjMgrMap = new Map<Id,Id>();
        Map<Id,Id> spMap = new Map<Id,Id>();
        Map<Id,Id> temRVPMap = new Map<Id,Id>();
        Map<Id,Id> temSalesSupportMgrMap = new Map<Id,Id>();
        List<Id> lstUser;
        Map<Id,List<Id>> accUserListMap = new Map<Id,List<Id>>();
        
        for (Account acc: listAccount)
        {
            if (acc.recordtypeid != ABARercordtypeId)
            {
                lstAccId.add(acc.Id);
                if (trigger.isUpdate)
                {
                    oldAccount = (Account)Trigger.oldMap.get(acc.id);
                }
                
                //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                //if(acc.Client_Relationship_Mgr__c != null){
                if (acc.Client_Relationship_Mgr__c != null && ((trigger.isInsert) || (trigger.isUpdate && acc.Client_Relationship_Mgr__c != oldAccount.Client_Relationship_Mgr__c)))
                {
                    crmMap.put(acc.Id,acc.Client_Relationship_Mgr__c);
                }
                
                //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                //if(acc.Corporate_Internal_Wholesaler__c != null){
                if (acc.Corporate_Internal_Wholesaler__c != null && ((trigger.isInsert) || (trigger.isUpdate && acc.Corporate_Internal_Wholesaler__c != oldAccount.Corporate_Internal_Wholesaler__c)))
                {   
                    coprInternalWholeSalerMap.put(acc.Id,acc.Corporate_Internal_Wholesaler__c);
                }
                
                //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                //if(acc.Corporate_RVP__c != null){
                if (acc.Corporate_RVP__c != null && ((trigger.isInsert) || (trigger.isUpdate && acc.Corporate_RVP__c != oldAccount.Corporate_RVP__c)))
                {
                    corpRVPMap.put(acc.Id,acc.Corporate_RVP__c);
                }
                
                //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                //if(acc.DaytoDay_VP__c != null){
                if (acc.DaytoDay_VP__c != null && ((trigger.isInsert) || (trigger.isUpdate && acc.DaytoDay_VP__c != oldAccount.DaytoDay_VP__c)))
                {
                    dayToDayVPMap.put(acc.Id,acc.DaytoDay_VP__c);
                }
                
                //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                //if(acc.Manager_OSJ_Name__c != null){
                if (acc.Manager_OSJ_Name__c != null && ((trigger.isInsert) || (trigger.isUpdate && acc.Manager_OSJ_Name__c != oldAccount.Manager_OSJ_Name__c)))
                {   
                    osjMgrMap.put(acc.Id,acc.Manager_OSJ_Name__c);
                }
                
                //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                //if(acc.Strategic_Partner__c != null){
                if (acc.Strategic_Partner__c != null && ((trigger.isInsert) || (trigger.isUpdate && acc.Strategic_Partner__c != oldAccount.Strategic_Partner__c)))
                {
                    spMap.put(acc.Id,acc.Strategic_Partner__c);
                }
                
                //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                //if(acc.TEM_Sales_Manager__c != null){
                if (acc.TEM_Sales_Manager__c != null && ((trigger.isInsert) || (trigger.isUpdate && acc.TEM_Sales_Manager__c != oldAccount.TEM_Sales_Manager__c)))
                {
                    temRVPMap.put(acc.Id,acc.TEM_Sales_Manager__c);
                }
                
                //Commenting below if as it was identified as open ended flow (old value checks were missing) Defect 12458
                //if(acc.TEM_Sales_Support_Manager__c != null){
                if (acc.TEM_Sales_Support_Manager__c != null && ((trigger.isInsert) || (trigger.isUpdate && acc.TEM_Sales_Support_Manager__c != oldAccount.TEM_Sales_Support_Manager__c)))
                {
                    temSalesSupportMgrMap.put(acc.Id,acc.TEM_Sales_Support_Manager__c);
                }
            }
        }
        
        // This section is for deleting the account members.
        List<AccountTeamMember> atmAllList = [Select id, AccountId, UserId from AccountTeamMember Where AccountId IN :lstAccId];
        
        for(Account acc : listAccount)
        {
            if(acc.recordtypeid != ABARercordtypeId && Trigger.isUpdate)
            {
                Account oldAcc = (Account)Trigger.oldMap.get(acc.ID);
                lstUser = new List<Id>();
                if (acc.Client_Relationship_Mgr__c != oldAcc.Client_Relationship_Mgr__c)
                {
                    lstUser.add(oldAcc.Client_Relationship_Mgr__c);
                }
                if (acc.Corporate_Internal_Wholesaler__c != oldAcc.Corporate_Internal_Wholesaler__c)
                {
                    lstUser.add(oldAcc.Corporate_Internal_Wholesaler__c);
                }
                if (acc.Corporate_RVP__c != oldAcc.Corporate_RVP__c)
                {
                    lstUser.add(oldAcc.Corporate_RVP__c);
                }
                if (acc.DaytoDay_VP__c != oldAcc.DaytoDay_VP__c)
                {
                    lstUser.add(oldAcc.DaytoDay_VP__c);
                }
                if (acc.Manager_OSJ_Name__c != oldAcc.Manager_OSJ_Name__c)
                {
                    lstUser.add(oldAcc.DaytoDay_VP__c);
                }
                if (acc.Strategic_Partner__c != oldAcc.Strategic_Partner__c)
                {
                    lstUser.add(oldAcc.DaytoDay_VP__c);
                }
                if (acc.TEM_Sales_Support_Manager__c != oldAcc.TEM_Sales_Support_Manager__c)
                {
                    lstUser.add(oldAcc.DaytoDay_VP__c);
                }
                if (acc.TEM_Sales_Manager__c != oldAcc.TEM_Sales_Manager__c)
                {
                    lstUser.add(oldAcc.TEM_Sales_Manager__c);
                }
                                                
                // put other users in the list
                accUserListMap.put(acc.id, lstUser);
            }
        }
        
        List<AccountTeamMember> atmDelList = new List<AccountTeamMember>();
        
        for (AccountTeamMember atmObj : atmAllList)
        {        
            if (accUserListMap.get(atmObj.AccountId) != null)
            {
                for (Id usrId : accUserListMap.get(atmObj.AccountId))
                {
                    if (atmObj.UserId == usrId)
                    {
                        atmDelList.add(atmObj);
                    }
                }
            }
        }
        
        //Creating Account Team.
        createAccTeam(crmMap, 'Client Relationship Mgr');
        createAccTeam(coprInternalWholeSalerMap, 'Corporate Internal Wholesaler');  
        createAccTeam(corpRVPMap, 'Corporate RVP'); 
        createAccTeam(osjMgrMap, 'Manager/OSJ Name');
        createAccTeam(spMap, 'Strategic Partner');
        createAccTeam(temRVPMap, 'TEM RVP');
        createAccTeam(temSalesSupportMgrMap, 'TEM Sales Support Manager');
        
        
        //Inserting Account Team Records.
        Database.SaveResult[] srList = Database.insert(atmList, false);   
        ErrorLogging.logError(srList, 'Trigger - AccountTeamCreation');
        
        system.debug('**************atmDelList*****************'+atmDelList);
        Database.Deleteresult[] drList = Database.delete(atmDelList, true);    
        ErrorLogging.logErrorDelete(drList, 'Trigger - AccountTeamCreation');
    }    
    
  
    public static void createAccTeam (Map<Id, Id> accUserMap, String role)
    {
        if (accUserMap != null && accUserMap.keySet() != null && accUserMap.keySet().size() > 0)
        {   
            for (Id accId : accUserMap.keySet())
            {   
                atm = new AccountTeamMember();
                atm.AccountId = accId;
                atm.UserId = accUserMap.get(accId); 
                atm.TeamMemberRole = role;      
                //atm.AccountAccessLevel = 'Edit';      
                atmList.add(atm);
            }
        }
    }
}


*/



}