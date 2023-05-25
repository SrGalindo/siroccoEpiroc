/**
 * @description       : 
 * @author            : Ahmad Nawaz
 * @group             : 
 * @last modified on  : 09-06-2022
 * @last modified by  : Ahmad Nawaz
**/
import { LightningElement, api } from 'lwc';
import {getRecord, getFieldValue, updateRecord} from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ID_FIELD from '@salesforce/schema/Account.Id';
import CREDIT_STATUS from '@salesforce/schema/Account.Credit_Status__c';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class CreditApprovalHeadless extends LightningElement {
    @api recordId;
    @api invoke() {
        this.updateContact();
      }
      updateContact() {
       
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        
        fields[CREDIT_STATUS.fieldApiName] = "Awaiting for Approval";
        console.log('Value' + fields[CREDIT_STATUS.fieldApiName]);

        const recordInput = { fields };

        updateRecord(recordInput)
            .then((x) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Request has been submitted to Credit Controller',
                        variant: 'success'
                    })
                );
                console.log('Value' + x);
                // Display fresh data in the form
                //return refreshApex(this.contact);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
        
        
}
}