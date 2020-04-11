public with sharing class CampingListController {
    
    @AuraEnabled
    public static ramyforce__Camping_Item__c saveItem(ramyforce__Camping_Item__c expense) {
        // Perform isUpdatable() checking first, then
         system.debug('expense&&&&&&'+expense);
        insert expense;
        return expense;
    }

    @AuraEnabled
    public static List<ramyforce__Camping_Item__c> getItems()
    {
        return [SELECT ID,Name,ramyforce__Quantity__c,ramyforce__Price__c, ramyforce__Packed__c FROM ramyforce__Camping_Item__c];
    }
    
}