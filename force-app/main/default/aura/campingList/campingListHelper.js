({
    createItem : function(component,campaign)
    {
        console.log("\nEntry into CampingListHelper.js -> createItem()");        
        console.log("\nCampingListHelper.js -> createItem()\n the Item: "+ JSON.stringify(campaign));

        this.saveItem(component, campaign, function(response)
        {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS")
            {
                var campaigns = component.get("v.items");
                console.log("Campaigns before create: "+JSON.stringify(campaigns));
                var retcamp = response.getReturnValue();
                campaigns.push(retcamp);
                console.log("Campaigns after  create: "+JSON.stringify(campaigns));
                component.set("v.items",campaigns);   
            }
        });        
    },

    saveItem : function(component,campaign,callback)
    {
        console.log("\nEntry into CampingListHelper.js -> saveItem()");        
        console.log("\nCampingListHelper.js -> saveItem() the campaign is: "+ JSON.stringify(campaign));

         var action = component.get("c.saveItem");
         console.log("Helper->saveItems"+campaign);
         action.setParams
         ({
            "campaign": campaign
         });

        if (callback)
        {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);        

    }

})