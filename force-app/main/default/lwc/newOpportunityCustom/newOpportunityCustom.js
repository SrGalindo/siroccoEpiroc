import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
//import generateOpportunityName from "@salesforce/apex/OpportunityClass.generateOpportunityName";

export default class NewOpportunityCustom extends NavigationMixin(LightningElement) {
    @api recordId;

    oppName;
    accNameAndCountryCode;
    amount;
    currency;
    closeDate;
    description;
    theRecord = {};
    
    
    handleSubmit(event){
        console.log('Submit click');
        event.preventDefault();       // stop the form from submitting
        const fields = event.detail.fields;
        console.log('recordid: '+this.recordId);
        if(this.recordId) fields.AccountId = this.recordId;
        else fields.AccountId = '0011x00001eNBYiAAO';
        fields.Name = this.oppName;
        fields.StageName = 'Understand_Request';
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }
    handleSuccess(event){
        const oppId = event.detail.id;
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
              objectApiName: "Opportunity",
              actionName: "view",
              recordId: oppId
            }
          });
    }
    setOppName(){
        console.log('setOppName');
        console.log(this.theRecord.CloseDate);
        console.log(this.theRecord.Description);
        if(this.theRecord.CloseDate && this.theRecord.Description){
            console.log('setting opp name');
            this.oppName = this.accNameAndCountryCode + '-' + this.theRecord.CloseDate +'-' + this.theRecord.Description;
            console.log('real opp name: ');
            console.log(this.oppName);
        }
    }
    handleFieldUpdate(event){
        console.log('fieldupdate');
        console.log(event.target.fieldName);
        console.log(event.target.value);
        this.theRecord[event.target.fieldName] = event.target.value;
        console.log('ending field update');
        this.setOppName();
    }
    connectedCallback(){
        // generateOpportunityName({accIdInc: '0011x00001eNBYiAAO'})
        // .then((result) => {
        //     console.log('res');
        //     console.log(result);
        //     this.accNameAndCountryCode = result;
        // })
        // .catch((error) => {
        // //this.showNotification('Error', error.body.message, 'error');
        // })
    }
}