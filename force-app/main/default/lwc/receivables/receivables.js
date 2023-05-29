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
        { fieldName: 'invoiceNumber', label: 'InvoiceNumber' },
        { fieldName: 'division', label: 'Business Line' },
        { fieldName: 'dueAmount', label: 'Due Amount' },
        { fieldName: 'amount', label: 'Amount' },
        { fieldName: 'currencyIsoCode', label: 'Currency' },
        { fieldName: 'terms', label: 'Terms' },
        { fieldName: 'invoiceDate', label: 'Date' },
        { fieldName: 'dueDate', label: 'Due Date' },
        { fieldName: 'daysPastDue', label: 'Days past due' },
        { fieldName: 'salesOrderNo', label: 'orderNumber' },
        { fieldName: 'type', label: 'Type' },
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
        console.log('receivables error');
        console.log(result);
        this.errorData = result.message;
        this.loadingWindowOpen = false;
        this.errorWindowOpen = true;
        //this.showErrorNotification(result.message, result.message);
    }
    else if(result.status ==='success'){
        console.log('receivables success');
        let itemsParsed = JSON.parse(result.message);
        console.log(itemsParsed);
        if(itemsParsed === ''){
            this.errorData = 'No data to display';
            this.loadingWindowOpen = false;
            this.errorWindowOpen = true;

        } else {
            this.displayedData = itemsParsed.receivables.map((elem) => (
                {
                ...elem,
                ...{
                    'cRHdaysPastDue': elem.daysPastDue <= 30 ? '1-30' :
                    (elem.daysPastDue >30 && elem.daysPastDue <= 60 )  ? '31-60' : 
                    (elem.daysPastDue >= 61 && elem.daysPastDue <= 90 ) ? '61-90' :
                    '90+',
                    'terms': this.mapTerms(elem.termsCode)
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
    mapTerms(terms){
        var salesforceTerms = '';
        switch (terms) {
            
        //SAP Values
        case 'Z001' :salesforceTerms = 'Down Payment';
        case 'ZFDP' :salesforceTerms = 'Down Payment';
        case 'ZD20' :salesforceTerms = '20 DAYS';
        case 'Z020' :salesforceTerms = '20 DAYS';
        case 'ZD60' :salesforceTerms = '60 DAYS';
        case 'Z000' :salesforceTerms = '0 DAYS';
        case 'Z004' :salesforceTerms = 'Down Payment';
        case 'Z010' :salesforceTerms = '10 DAYS';
        case 'Z030' :salesforceTerms = '30 DAYS';
        case 'Z045' :salesforceTerms = '45 DAYS';
        case 'Z060' :salesforceTerms = '60 DAYS';
        case 'Z090' :salesforceTerms = '90 DAYS';
        case 'ZADV' :salesforceTerms = 'Down Payment';
        case 'ZD45' :salesforceTerms = '45 DAYS';
        case 'Z005' :salesforceTerms = '5 DAYS';
        case 'Z007' :salesforceTerms = '7 DAYS';
        case 'Z014' :salesforceTerms = '14 DAYS';
        case 'Z021' :salesforceTerms = '21 DAYS';
        case 'ZNE1' :salesforceTerms = 'Netting (FDM + 1)';
        case 'ZNET' :salesforceTerms = 'Netting (FDM)';
        case 'Z025' :salesforceTerms = '25 DAYS';
        case 'Z040' :salesforceTerms = '40 DAYS';
        case 'Z019' :salesforceTerms = '19 DAYS';
        case 'Z015' :salesforceTerms = '15 DAYS';
        case 'Z018' :salesforceTerms = '18 DAYS';
        
        default: salesforceTerms = null;}
        return salesforceTerms;
    }

}