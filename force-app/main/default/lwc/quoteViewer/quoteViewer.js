import { LightningElement, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import getQuotes from "@salesforce/apex/QuoteIntegration.getQuotes";


export default class QuoteViewer extends NavigationMixin(LightningElement) {
    @api recordId;
    mainWindowOpen = false;
    loadingWindowOpen = true;
    errorWindowOpen = false;
    errorData;
    columns = [
        { fieldName: 'oRHorderNo', label: 'QuoteNo' },
        { fieldName: 'oRHdivision', label: 'Division' },
        { fieldName: 'oRHorderNetAmount', label: 'Amount Ex. Tax' },
        { fieldName: 'oRHorderTaxAmount', label: 'Tax' },
        { fieldName: 'oRHcurrencyCode', label: 'Currency' },
        { fieldName: 'oRHorderEntryDate', label: 'Entry Date' },
        { fieldName: 'oRHrequestedDate', label: 'Requested Date' }   
        ];
    displayedData;

   connectedCallback(){
    //Custno is integer in database. We need to treat it as a string due to some beginning with 0. Octal literals are not allowed.
    this.fetchReceivablesData();
   }
    
   fetchReceivablesData(){
    getQuotes({recordId: this.recordId})
    .then((result) => {
        this.activeSearch = false;
        console.log('status? '+result.status);
        if(result.status === 'error'){
            this.errorData = result.message;
            this.loadingWindowOpen = false;
            this.errorWindowOpen = true;
            //this.showErrorNotification(result.message, result.message);
        }
        else if(result.status ==='success'){
            let itemsParsed = JSON.parse(result.message);
            this.displayedData = itemsParsed.oRorders.map((elem) => ({
                ...elem,
                }));

                if(this.displayedData.length === 0){
                this.errorData = 'No data to dispaly';
                this.loadingWindowOpen = false;
                this.errorWindowOpen = true;
                } else {
                    this.loadingWindowOpen = false;
                    this.mainWindowOpen = true;
                }
        }
    })
    .catch((error) => {
    this.activeSearch = false;
    this.sidebarProcessing = false;
    this.errorData = error.body.message;
    this.loadingWindowOpen = false;
    this.errorWindowOpen = true;
    //this.showNotification('Error', error.body.message, 'error');
    })
   }

   showNotification(title, text, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: text,
            variant: variant,
        });
        this.dispatchEvent(evt);
      }
}