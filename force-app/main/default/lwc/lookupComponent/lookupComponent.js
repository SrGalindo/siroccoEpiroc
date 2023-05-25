import { LightningElement, api } from 'lwc';
import addToRecentItems from '@salesforce/apex/LookupHandler.setObjectToRecentItems';

export default class LookupComponent extends LightningElement {
    @api name;
    @api variant = "label-hidden";
    @api fieldLabel;
    @api childObjectApiName;
    @api targetFieldApiName;
    @api value;
    @api required = false;
    @api addToRecent = false;
    @api recordId;

    handleChange(event) {
        console.log('in the look up component');
        let selectedEvent = new CustomEvent('valueselected', {detail: event.detail});
        this.dispatchEvent(selectedEvent);

        if (this.addToRecent) {
            if (event.detail.value.length > 0 && event.detail.value[0].length > 0) {
                addToRecentItems({
                    recordId: event.detail.value[0]
                }).catch(error => {
                    console.log('error in catch');
                    console.log(error);
                });
            }
        }
    }

    @api reportValidity() {
        if(this.required) {
            this.template.querySelector('lightning-input-field').reportValidity();
        }
    }
}