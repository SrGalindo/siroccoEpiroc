import { LightningElement, api, wire, track } from 'lwc';
import setAddress from '@salesforce/apex/LookupHandler.setAddress';
import getRecordType from '@salesforce/apex/LookupHandler.getRecordType';


export default class AddressLookupComponent extends LightningElement {
    @api recordId;
    @track type;
    @wire(getRecordType, {recordId:'$recordId'})
    getRecordType({error, data}){
        if(data){
            this.type = data;
            console.log('type is ' + this.type);
        } else if(error){
            console.log(error);
        }
    };
    id;
    required = false;

    handleSelectedLookup(event) {
        //console.log(event.detail);
        this.id = event.detail.value[0];
        if(this.id !== null){
            setAddress({recordId: this.recordId, addressId: this.id});
        }
    }

    handleToggleSection(event) {
        const openSections = event.detail.openSections;
        if(openSections.length === 0){
            this.activeSectionMessage = 'All sections are closed';
        } else {
            this.activeSectionMessage = 'Open sections: ' + openSections.join(', ');
        }
    }

}