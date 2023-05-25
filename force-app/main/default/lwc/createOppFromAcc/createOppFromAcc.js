import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import { NavigationMixin } from 'lightning/navigation';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import Opportunity from '@salesforce/schema/Opportunity';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ACCOUNT_RECORD_TYPE from '@salesforce/schema/Account.RecordType.DeveloperName';

export default class CreateOppFromAcc extends NavigationMixin(LightningElement){

    @track selectedValue;
    @track type_options = [];
    @api recordId;
    @api showLoading;

    accountRecordType;

    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_RECORD_TYPE]})
    wiredAccount({data, error}) {
        if (data) {
            this.accountRecordType = getFieldValue(data, ACCOUNT_RECORD_TYPE);
        } else if (error) {
            // do something
        }
    }

    @wire(getObjectInfo, { objectApiName: Opportunity })
    oppObjectInfo({data, error}) {
        if(data) {
            let optionsValues = [];
            // map of record type Info
            const rtInfos = data.recordTypeInfos;

            // getting map values
            let rtValues = Object.values(rtInfos);

            for(let i = 0; i < rtValues.length; i++) {
                if(rtValues[i].name !== 'Master') {
                    optionsValues.push({
                        label: rtValues[i].name,
                        value: rtValues[i].recordTypeId
                    })
                }
            }

            this.type_options = optionsValues;
        }
        else if(error) {
            window.console.log('Error ===> '+JSON.stringify(error));
        }
    }

    recordTypeSelected = '';
    recordType = '';
    recordTypeName = '';

    get options() {
        return [
            { label: 'Simple Opportunity'+ '\n' +'(Itemized quotes: Mainly parts/items that need no configuration)', value: 'Simple Opportunity' },
            { label: 'Complex Opportunity'+ '\n' +'(Configured deals: Mainly for capital equipment, service agreements etc.)', value: 'Simple Opportunity', value: 'Complex Opportunity' },
        ];
    }
    closeAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
    handelAction() {

        const defaultValues = encodeDefaultFieldValues({
            AccountId: this.recordId,
            Account_Record_Type__c: this.accountRecordType
            //Account_Record_Type__c: 'Cus'

        });

        for(let i = 0; i < this.type_options.length; i++) {
            console.log('H'+this.type_options[i].label);
            if(this.type_options[i].label == this.recordTypeSelected) {
                this.recordType = this.type_options[i].value;
                this.recordTypeName = this.type_options[i].label;
            }
        }

        console.log('Selected Record Type'+ this.recordType);

        this.dispatchEvent(new CloseActionScreenEvent());
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Opportunity',
                actionName: 'new'
            },
            state: {
                defaultFieldValues: defaultValues,
                recordTypeId:this.recordType
                
                
            }
        });
        
    }
    handleRecordType(event){
        this.recordTypeSelected = event.target.value;
    }
}