({
    doInit: function(component, event, helper) {
         
    },
    getValueFromLwc : function(component, event, helper) {
        component.set("v.closeModel",event.getParam('closeModel'));
        var Model = component.get("v.closeModel");
        console.log('Hello' + Model);
        if(Model == true){
            $A.get("e.force:closeQuickAction").fire();
        }
    }
})