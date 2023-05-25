import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { decodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import getAccount from '@salesforce/apex/AccountClass.getAccount';

export default class NavToNewAddressWithDefaults extends LightningElement {
    dfv_AccountName = '';
    dfv_NumberOfEmployees = '';

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        if (currentPageReference.state.defaultFieldValues) {
            const dfvObject = decodeDefaultFieldValues(currentPageReference.state.defaultFieldValues);
            console.log(currentPageReference.state.defaultFieldValues);
            this.dfv_AccountName = dfvObject.AccountId;
            console.log(this.dfv_AccountName);
        }
    }

    // Run code when account is created
    handleAccountCreated() {
    }

    getAccount(){
        this.account = getAccount(this.recordId);
    }
}