import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import getReceivables from "@salesforce/apex/Receivables.getReceivables";


export default class Receivables extends NavigationMixin(LightningElement) {
    @api recordId;
    mainWindowOpen = false;
    loadingWindowOpen = true;
    errorWindowOpen = false;
    errorData;
    columns = [ 
        { fieldName: 'cRHinvoiceNo', label: 'InvoiceNo' },
        { fieldName: 'cRHdivision', label: 'Division' },
        { fieldName: 'cRHdueAmount', label: 'Due Amount' },
        { fieldName: 'cRHinvoiceAmount', label: 'Amount' },
        { fieldName: 'cRHcurrencyCode', label: 'Currency' },
        { fieldName: 'cRHorderTermsDescription', label: 'Terms' },
        { fieldName: 'cRHinvoiceDate', label: 'Date' },
        { fieldName: 'cRHdueDate', label: 'Due Date' },
        { fieldName: 'cRHdaysPastDue', label: 'Days past due' },
        { fieldName: 'cRHsalesOrderNo', label: 'OrderNo' },
        { fieldName: 'cRHinvoiceType', label: 'Type' },
        ];

   displayedData;

   connectedCallback(){
    //Custno is integer in database. We need to treat it as a string due to some beginning with 0. Octal literals are not allowed.
    this.fetchReceivablesData();
   }
    
   fetchReceivablesData(){
    getReceivables({recordId: this.recordId})
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
        if(itemsParsed === ''){
            this.errorData = 'No data to display';
            this.loadingWindowOpen = false;
            this.errorWindowOpen = true;
        } else {
            this.displayedData = itemsParsed.cRreceivables.map((elem) => (
                {
                ...elem,
                ...{
                    'cRHdaysPastDue': elem.cRHdaysPastDue <= 30 ? '1-30' :
                    (elem.cRHdaysPastDue >30 && elem.cRHdaysPastDue <= 60 )  ? '31-60' : 
                    (elem.cRHdaysPastDue >= 61 && elem.cRHdaysPastDue <= 90 ) ? '61-90' :
                    '90+'
                }
             }));
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