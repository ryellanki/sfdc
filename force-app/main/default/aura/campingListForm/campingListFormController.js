({
    clickCreateItem : function(component, event, helper)
    {
        //-- Simplistic error checking.
        console.log("\nIn CampingListFormController.js -> submitForm()");
        var validCampign = true;

        //-- Name must not be blank.
        var nameField   = component.find("name");
        var campaignname = nameField.get("v.value");
        if($A.util.isEmpty(campaignname))
        {
            validCampign = false;
            nameField.set("v.errors",[{message: "Camping name can't be blank."}]);     
        }
        else
        {
            nameField.set("v.errors",null);
        }

        //-- Quantity must not be blank.
        var qtyField = component.find("quantity");
        var quantity = qtyField.get("v.value");
        if($A.util.isEmpty(quantity))
        {
            validCampign = false;
            qtyField.set("v.errors",[{message: "Quantity can't be blank."}]);
        }
        else
        {
            qtyField.set("v.errors",null);            
        }

        //-- Price must not be blank
        var priceField = component.find("price");
        var price      = priceField.get("v.value");
        if($A.util.isEmpty(price))
        {
            validCampign = false;
            priceField.set("v.errors",[{message: "Price can't be blank."}]);
        }
        else
        {
            priceField.set("v.errors",null);            
        }

        //-- If we pass error checking, do some real work.
        if(validCampign)
        {
            //-- Create the new expense.
            var newCampaign = component.get("v.newItem");
            console.log("In CampingListFormController.js -> submitForm()\n The Item: " + JSON.stringify(newCampaign));
            helper.createItem(component, newCampaign);
        }               



    }

})