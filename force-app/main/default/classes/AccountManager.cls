/*
•   Design and develop Conceptual, Logical, and Physical data Model for the Customer Relationship Management Projects using Salesforce Applications.
•   Working closely with sales team and business analysts and performed detailed analysis of business and technical requirements and design the solution by customizing various standard objects and Custom objects of Salesforce (SFDC).
•   Develop applications by integrating third party vendors with Salesforce using various technologies like Salesforce Lightening Components, JQuery, JavaScript, HTML, CSS, SOAP/REST Web services, Eclipse IDE.
•   Interact with users, project manager, Architects to ensure that implemented solutions satisfy business requirements and are delivered in a time. 
•   Create Solution Architecture & Technical documents for Salesforce Applications.
•   Implement solution using extensive customization as required on Salesforce platform.
•   Use Agile Methodologies to deliver projects, review code for best practices and quality standards, resolve design conflicts/changes.
•   Perform production support activities like root cause analysis and come up with permanent fixes with in an SLA time frame.
•   Create complex reports and dashboards for Management team using SOQL/SOSL Queries to retrieve the data from Salesforce Database. 




*/



@RestResource(urlMapping='/Accounts/*/contacts')
global class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest req = RestContext.request;
        String accId = req.requestURI.substringBetween('Accounts/', '/contacts');
        Account acc = [SELECT Id, (SELECT Id, Name FROM Contacts) 
                       FROM Account WHERE Id = :accId];
        return acc;
    }
}