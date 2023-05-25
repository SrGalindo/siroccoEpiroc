import { api, LightningElement} from 'lwc';
import {getDetailsFromError, fireToast} from 'c/lwcutils';
import getAccountPlanTableSettings from '@salesforce/apex/AccountPlanTableController.getAccountPlanTableSettings';
import createRecord from '@salesforce/apex/AccountPlanTableController.createRecord';
import linkContact from '@salesforce/apex/AccountPlanTableController.linkContact';
import linkAccount from '@salesforce/apex/AccountPlanTableController.linkAccount';
import deleteRecord from '@salesforce/apex/AccountPlanTableController.deleteRecord';
import { updateRecord } from 'lightning/uiRecordApi';

const actions = [
    { label: 'Delete', name: 'delete' },
];

export default class AccountPlanTable extends LightningElement {

    @api recordId;
    @api tabName;
    @api objectName;
    columns;
    apiFields;
    existingRecords;
    data;
    rowOffset = 0;
    isContact;
    isAccount;
    tempContactToLink;
    tempAccountToLink;

    dataColumns = [];
    
    connectedCallback(){
        this.startTable();
    }

    startTable(){
        getAccountPlanTableSettings({
            tabName: this.tabName,
            recordId: this.recordId
        }).then((result) => {
            if (result['error']) {
                fireToast(this, 'error', 'Error', result['message']);
            }else{
                this.columns = result['columnsList'];
                this.apiFields = result['apiFieldsList'];
                this.existingRecords = result['existingRecords'];
                let isEditable = result['isEditable'];

                this.dataColumns = this.columns.map((column, index) => {
                    return {
                        label: column,
                        fieldName: this.apiFields[index],
                        type: 'text',
                        editable: isEditable

                    };
                  });
                  this.dataColumns = [...this.dataColumns, {
                    type: 'action',
                    typeAttributes: { rowActions: actions },
                }];

                let updatedResult = [];
                this.existingRecords.forEach((obj, index) => {
                    let tempObj = {};
                    this.dataColumns.forEach((col) => {
                        if(col.fieldName){
                            let fieldName = col.fieldName.split('.')[1] || col.fieldName;
                            if(col.fieldName.split(".").length > 1){
                                let properties = col.fieldName.split('.');
                                let value = obj[properties[0]][properties[1]];
                                tempObj[fieldName] = value;
                                if (index === this.existingRecords.length - 1) {
                                    col.fieldName = fieldName;
                                }
                            }else{
                                tempObj[fieldName] = obj[col.fieldName];
                            }
                        }
                    });
                    tempObj.Id = obj.Id;

                    updatedResult.push(tempObj);
                });
                this.data = updatedResult;
            }
        });
    }

    saveHandleAction(event) {
        this.fldsItemValues = event.detail.draftValues;
        const inputsItems = this.fldsItemValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });
       
        const promises = inputsItems.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            fireToast(this, 'success', 'Success', 'Records Updated Successfully!!');
            return this.startTable();
        }).catch(error => {
            fireToast(this, 'error', 'Error', error.body.message);
        }).finally(() => {
            this.fldsItemValues = [];
        });
    }


    handleNewRow(){
        if(this.objectName == 'Account_Plan_Contacts__c'){
            this.isContact = true;
        }else if(this.objectName == 'Account_Plan_Accounts__c'){
            this.isAccount = true;
        }else{
            createRecord({
                objectTypeName: this.objectName,
                accountPlan: this.recordId
            }).then((result) => {
                if (result['error']) {
                    fireToast(this, 'error', 'Error', result['message']);
                }else{
                    this.startTable();
                }
            });
        }
    }

    handleLinkRecord(event){
        if(this.objectName == 'Account_Plan_Contacts__c'){
            linkContact({
                accountPlanId: this.recordId,
                contactId: this.tempContactToLink
            }).then((result) => {
                if (result['error']) {
                    fireToast(this, 'error', 'Error', result['message']);
                }else{
                    fireToast(this, 'success', 'Success', result['message']);
                    this.startTable();
                }
            })
        }else if(this.objectName == 'Account_Plan_Accounts__c'){
            linkAccount({
                accountPlanId: this.recordId,
                accountId: this.tempAccountToLink
            }).then((result) => {
                if (result['error']) {
                    fireToast(this, 'error', 'Error', result['message']);
                }else{
                    fireToast(this, 'success', 'Success', result['message']);
                    this.startTable();
                }
            })
        }
    }

    handleAction(event){
        let actionName = event.detail.action.name;
        let row = event.detail.row;

        if(actionName == 'delete'){
            deleteRecord({
                rowId: row.Id,
                objectTypeName: this.objectName
            }).then((result) => {
                if (result['error']) {
                    fireToast(this, 'error', 'Error', result['message']);
                }else{
                    fireToast(this, 'success', 'Success', result['message']);
                    this.startTable();
                }
            });
        }
    }

    handleContactChanged(event){
        this.tempContactToLink = event.target.value;
    }

    handleAccountChanged(event){
        this.tempAccountToLink = event.target.value;
    }

    refresh() {
        window.location.reload();
    }

}