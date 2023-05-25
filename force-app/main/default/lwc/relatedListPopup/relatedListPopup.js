/**
 * Created by Sirocco on 2022-11-30.
 */

import { LightningElement , api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';

export default class relatedListPopup extends LightningElement {
    showModal = false;
    @api sobjectLabel;
    @api recordId;
    @api recordName;
    @api isDelete = false;
    @api sobjectApiName;

    @api show() {
        this.showModal = true;
    }

    @api hide() {
        this.showModal = false;
    }

    handleClose() {
        this.showModal = false;
    }

    handleDialogClose(){
        this.handleClose();
    }

    get body(){
        return `Are you sure you want to delete this ${this.sobjectLabel.toLowerCase()}`;
    }

    get header(){
        if(this.isDelete) {
            return `Delete ${this.sobjectLabel}`;
        } else {
            return this.recordId == null ? `New ${this.sobjectLabel}` : `Edit ${this.recordName}`;
        }
    }

    handleDelete(){
        console.log('Delete recordId: ', this.recordId);
        deleteRecord(this.recordId)
            .then(() => {
                this.hide();
                const evt = new ShowToastEvent({
                    title: `${this.sobjectLabel}  "${this.recordName}" was deleted.`,
                    variant: "success"
                });
                this.dispatchEvent(evt);
                this.dispatchEvent(new CustomEvent("refreshdata"));
            }).catch(error => {
                const evt = new ShowToastEvent({
                    title: 'Error deleting record',
                    message: error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(evt);
            });
    }

    handleSave(){
        this.template.querySelector('lightning-record-form').submit();
    }

    handleSuccess(event){
        this.hide();
        let name = this.recordName;
        if(this.isNew()){
            if(event.detail.fields.Name){
                name = event.detail.fields.Name.value;
            }else if(event.detail.fields.LastName){
                name = [event.detail.fields.FirstName.value, event.detail.fields.LastName.value].filter(Boolean).join(" ");
            }
        }
        name = name ? `"${name}"` : '';

        const message = `${this.sobjectLabel} ${name} was ${(this.isNew() ? "created" : "saved")}.`;
        const evt = new ShowToastEvent({
                    title: message,
                    variant: "success"
                    });
        this.dispatchEvent(evt);
        this.dispatchEvent(new CustomEvent("refreshdata"));
    }
}