import { LightningElement } from 'lwc';

export default class AccountLookupComponent extends LightningElement {
    accountId;

    handleSelectedLookup(event) {
        this.accountId = event.detail;
    }
}