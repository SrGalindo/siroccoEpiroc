({
	myAction : function(component, event, helper) {
        
        
		
	},
    /*doInit: function(cmp) {
        let urlString = window.location.href;
        let baseURL = urlString.substring(0, urlString.indexOf("/s"));
        console.log('hello');
        //component.set("v.buttonLabel", myLabel);
    }*/
    doInit : function(component, event, helper){
        document.title = "Quote Template";
        let urlString = window.location.origin;
        console.log('urlString: ' + urlString);
        let baseURL = urlString.substring(0, urlString.indexOf("/s"));
        component.set("v.base", baseURL);
    },
    saveToQuote : function(component, event, helper) {
        
        var action = component.get("c.savePdfToQuote");
        var quoteId = component.get("v.recordId");
        
        action.setParams({
            "quoteId":quoteId
        });
        $A.enqueueAction(action);
        
        component.find('notifyId').showToast({
            "variant": "Success",
            "title": "Success!",
            "message": "Document saved to Quote!"
        });
        
        $A.get("e.force:closeQuickAction").fire()
    },
    CancelQuote : function(component, event, helper) {
        
        $A.get("e.force:closeQuickAction").fire()
    }
})