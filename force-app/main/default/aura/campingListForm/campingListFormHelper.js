({
    createItem : function(component,item)
    {   
        console.log("\nEntry into CampingListFormHelper.js -> createItem()");
        console.log("In CampingListFormHelper.js -> createItem() the item is: "+JSON.stringify(item));
        var createEvent = component.getEvent("addItem");        
        createEvent.setParams({ "item": item });
        createEvent.fire();        
        component.set("v.newItem",{'sobjectType':'Camping_Item__c','Name': '','Quantity__c': 0,'Price__c': 0,'Packed__c': false});
    }
})