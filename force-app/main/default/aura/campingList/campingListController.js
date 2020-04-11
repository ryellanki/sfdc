({

    //-- Load Camping list Items.
    doInit: function(component,event,helper)    
    {
        //-- Create the Action.
        var action = component.get("c.getItems");

        //-- Add callback behavior for when response is received.
        action.setCallback(this,function(response)
        {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS")
            {
                component.set("v.items",response.getReturnValue());
                console.log("doInit: "+response.getReturnValue());
            }
        });

        //-- Send action off to be execute.
        $A.enqueueAction(action);
    },

     //-- Handle Create Expense Actions..
    handleAddItem: function(component, event, helper)
    {
        console.log("\nEntry into CampingListController.js -> handleAddItem()");        

        var item = event.getParam("item");
        console.log("\nCampingListController.js -> handleAddItem() item: "+ JSON.stringify(item));

        var action = component.get("c.saveItem");
        action.setParams
         ({
            "item": item
         });

        action.setCallback(this, function(response)
        {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS")
            {       
               var items = component.get("v.items");
               console.log("Campaigns(items..) before  create: "+JSON.stringify(items));
               items.push(response.getReturnValue());
               console.log("Campaigns(items..) after  create: "+JSON.stringify(items));
               component.set("v.items",items);
            }
        });
        $A.enqueueAction(action);
    }

    /*handleAddItem: function(component, event, helper)
    {
        console.log("\nEntry into CampingListController.js -> handleAddItem()");        

        var newItem = event.getParam("item");
        console.log("\nCampingListController.js -> handleAddItem()\n the Item: "+ JSON.stringify(newItem));
        helper.createItem(component, newItem);        

    }*/


})