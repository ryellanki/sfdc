Public class alertBoxController
{


/*

<!-- AlertBox Component -->
<aura:component implements="force:appHostable,flexipage:availableForAllPageTypes,flexipage:availableForRecordHome,force:hasRecordId,forceCommunity:availableForAllPageTypes,force:lightningQuickAction" access="global" >
<ltng:require styles="{!join(',',$Resource.SLDS221 + 'assets/styles/salesforce-lightning-design-system.css')}" />

<aura:attribute name="alertTypes" type="String[]" default="['info','warning','success','error','chat']"/>
<aura:attribute name="selectedType" type="String" default="success"/>
<aura:attribute name="alertTypeId" type="Integer" default="2"/>
<aura:attribute name="title" type="String" default="Alert"/>    
<aura:attribute name="message" type="String" default="This is an information alert."/>
<aura:attribute name="buttonTxt" type="String" default="Close"/>
<aura:attribute name="buttonLeft" type="String" default="Yes"/>
<aura:attribute name="buttonRight" type="String" default="No"/>
<aura:attribute name="initiatedFrom" type="String"/> <!-- Added for Confirm Box Event Handling -->

<aura:handler name="init" value="{!this}" action="{!c.doInit}"/>

    <!-- PRIMARY CONTENT WRAPPER -->
    
    <div role="dialog" tabindex="-1" aria-labelledby="header43" class="slds-modal slds-fade-in-open">
      <div class="slds-modal__container">
        <div class="slds-modal__header">
          <a onclick="{!c.closeCMP}" class="slds-button slds-modal__close slds-button--icon-inverse" title="Close">
            <span class="slds-button__icon slds-button__icon--large" aria-hidden="true">
                <lightning:icon iconName="utility:close" size="medium" alternativeText="formIco" aura:id="formIco" class="slds-icon-fill-white"/>
            </span>
            <span class="slds-assistive-text">Close</span>
          </a>
        
        
        <header class="slds-media slds-media--center">
          <div class="slds-media__body">
            <h2 id="headerError" class="errorCenter">
                <lightning:icon iconName="{!'utility:'+v.selectedType}" size="medium" alternativeText="formIco" aura:id="formIco" class="{!'slds-icon-fill-'+v.selectedType}"/><span class="slds-text-heading--medium"><b>&nbsp;{!v.title}</b></span>
            </h2>
          </div>
        </header>
          
        </div>
        <div class="slds-modal__content slds-Align-Text-Center">
            <fieldset class="slds-box--x-small slds-form--compound allmargin">
                <ui:outputTextArea value="{!v.message}"/>
            </fieldset>
        </div>
        <!-- if the component is called as alert then button 1 will be rendered, else set of button 2 will be rendered -->
        <div class="slds-modal__footer">
            <aura:if isTrue="{!v.alertTypeId == '4'}">
                <lightning:button label="{!v.buttonLeft}" variant="brand" onclick="{!c.btnClicked}"/> <!-- button 2 -->
                <lightning:button label="{!v.buttonRight}" variant="brand" onclick="{!c.btnClicked}"/> <!-- button 2 -->
            <aura:set attribute="else">
                <lightning:button label="{!v.buttonTxt}" variant="brand" onclick="{!c.closeCMP}"/> <!-- button 1 -->
            </aura:set>
            </aura:if>
        </div>
      </div>
    </div>
    <div class="slds-backdrop slds-backdrop--open"></div>
    
    <!-- PRIMARY CONTENT WRAPPER -->
    <br/>
    <!-- FOOTER -->
        
    <!-- / FOOTER -->
</aura:component>



.THIS {
}
.THIS .allmargin {
    margin: 5px 5px 5px 5px;
}
.THIS .slds-icon-fill-white svg{
    fill: white;
}
.THIS .slds-icon-fill-info svg{
    fill: #1589ee;
}
.THIS .slds-icon-fill-warning svg{
    fill: #ffb75d;
}
.THIS .slds-icon-fill-success svg{
    fill: #04844b;
}
.THIS .slds-icon-fill-error svg{
    fill: #c23934;
}
.THIS .slds-icon-fill-chat svg{
    fill: #1589ee;
}
.THIS .slds-modal__container{
    width:0%;
    min-width:35%;
    max-width:50%;
}
.THIS .slds-modal__content{
    width:100%;
    
}
.THIS .errorCenter{
    display:inline-flex;
    align-items:center;
}
.THIS .slds-Align-Text-Center{
    text-align: center;
    align-items:center;
}


({
    doInit : function(cmp, event, helper) 
    {
        var alertTypes = cmp.get("v.alertTypes");
        var alertTypeId = cmp.get("v.alertTypeId");
        console.log('alertTypes[alertTypeId]-->'+alertTypes[alertTypeId]);
        cmp.set("v.selectedType",alertTypes[alertTypeId]);
        console.log('"v.selectedType-->'+cmp.get("v.selectedType"));
    },
    closeCMP : function(cmp, event, helper) 
    {
        cmp.destroy();
    },
    btnClicked : function(cmp, event, helper)
    {
        var confirmEvent = $A.get("e.c:confirmBoxEvent");
        var reqFromTxt = cmp.get("v.initiatedFrom");
        var respTxt=event.getSource().get("v.label");
        console.log('respTxt-->'+respTxt);
        confirmEvent.setParams({
                requestFrom : reqFromTxt,
                respType : respTxt
            });
        confirmEvent.fire();
        cmp.destroy();
    }
})

*/

}