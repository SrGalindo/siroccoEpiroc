({
	myAction : function(component, event, helper) {
		
	},
    
    doInit : function(component, event, helper){
        let urlString = window.location.origin;
        console.log('urlString: ' + urlString);
        let baseURL = urlString.substring(0, urlString.indexOf("/s"));
        component.set("v.base", baseURL);
    }
})