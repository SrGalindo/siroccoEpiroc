import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
//import MYJSON from '@salesforce/resourceUrl/FleetData';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import CCUST_FIELD from '@salesforce/schema/Account.CCUST__c';
const fields = [CCUST_FIELD];
MYJSON = 'abc';


export default class FleetData extends NavigationMixin(LightningElement) {
    @wire(getRecord, { recordId: '$recordId', fields })
    account;

    get ccust() {
        return getFieldValue(this.account.data, CCUST_FIELD);
    }
    quantityChosen = 1;
    @api recordId;
    mainWindowOpen = true;
    disabled;
    itemList = [];
  testData = [
    {
        name: 'Part 1',
        articleId: '123',
        division: 'Parts',
        IPROD: '3177313200',
        IDESC: 'NIPPLE',
        IUMS: 'EA',
        ILDTE: '20220323',
        ILIST: '12,22',
        IDSCE: '',
        IWGHT: '0,03',
        CXPDIV: 'MR',
        CXPPLC: 'MRS',
        WWHS: '01',
        WISS: '0',
        WCUSA: '1',
        LWHS: '01',
        LDESC: 'EPIROC SPAIN',
    },
    {
        name: 'Part 1',
        articleId: '123',
        division: 'Parts',
        IPROD: '3177314700',
        IDESC: 'Manometer 0-400bar, AC',
        IUMS: 'EA',
        ILDTE: '20220325',
        ILIST: '70,12',
        IDSCE: '0-400 BAR',
        IWGHT: '0,24',
        CXPDIV: 'MR',
        CXPPLC: 'MRS',
        WWHS: '01',
        WISS: '0',
        WCUSA: '0',
        LWHS: '01',
        LDESC: 'EPIROC SPAIN',
    },
    {
        name: 'Part 1',
        articleId: '123',
        division: 'Parts',
        IPROD: '3177317301',
        IDESC: 'VALVULA',
        IUMS: 'EA',
        ILDTE: '20191212',
        ILIST: '423,95',
        IDSCE: '',
        IWGHT: '0,215',
        CXPDIV: 'MR',
        CXPPLC: 'MRS',
        WWHS: '01',
        WISS: '0',
        WCUSA: '0',
        LWHS: '01',
        LDESC: 'EPIROC SPAIN',
    },
    {
        name: 'Part 1',
        articleId: '123',
        division: 'Parts',
        IPROD: '3177502100',
        IDESC: 'PRESSURE GAUGE',
        IUMS: 'EA',
        ILDTE: '20220325',
        ILIST: '70,12',
        IDSCE: '57126',
        IWGHT: '0,215',
        CXPDIV: 'MR',
        CXPPLC: 'MRS',
        WWHS: '01',
        WISS: '0',
        WCUSA: '0',
        LWHS: '01',
        LDESC: 'EPIROC SPAIN',
    },
    {
        name: 'Part 1',
        articleId: '123',
        division: 'Parts',
        IPROD: '3177503100',
        IDESC: 'PRESSURE GAUGE',
        IUMS: 'EA',
        ILDTE: '20220426',
        ILIST: '69,63',
        IDSCE: '',
        IWGHT: '0,295',
        CXPDIV: 'MR',
        CXPPLC: 'MRS',
        WWHS: '01',
        WISS: '0',
        WCUSA: '0',
        LWHS: '01',
        LDESC: 'EPIROC SPAIN',
    },
    {
        name: 'Part 1',
        articleId: '123',
        division: 'Parts',
        IPROD: '3222989583',
        IDESC: 'WINDOW',
        IUMS: 'EA',
        ILDTE: '20190916',
        ILIST: '1153,39',
        IDSCE: '',
        IWGHT: '10',
        CXPDIV: 'MR',
        CXPPLC: 'MRS',
        WWHS: '01',
        WISS: '0',
        WCUSA: '0',
        LWHS: '01',
        LDESC: 'EPIROC SPAIN',
    },
    {
        name: 'Part 1',
        articleId: '123',
        division: 'Parts',
        IPROD: '3222989590',
        IDESC: 'CRISTAL ESTANDAR TECHO',
        IUMS: 'EA',
        ILDTE: '20220407',
        ILIST: '1549,94',
        IDSCE: '',
        IWGHT: '17,6',
        CXPDIV: 'MR',
        CXPPLC: 'MRS',
        WWHS: '01',
        WISS: '0',
        WCUSA: '0',
        LWHS: '01',
        LDESC: 'EPIROC SPAIN',
    },
    {
        name: 'Part 1',
        articleId: '123',
        division: 'Parts',
        IPROD: '3222989591',
        IDESC: 'CRISTAL',
        IUMS: 'EA',
        ILDTE: '20210105',
        ILIST: '1688,77',
        IDSCE: '57126',
        IWGHT: '17',
        CXPDIV: 'MR',
        CXPPLC: 'MRS',
        WWHS: '01',
        WISS: '0',
        WCUSA: '0',
        LWHS: '01',
        LDESC: 'EPIROC SPAIN',
    },
    
   
]
  //Search
  searchProductType = 'Equipment';
  searchProductTypePlaceholder = 'Equipment';
      get searchProductOptions() {
        return [
            { label: 'Item', value: 'item' },
            { label: 'Equipment', value: 'equipment' },
            { label: 'Service', value: 'service' },
        ];
   }
   fetchfleetdata(evt) {
    this.disabled = true;
    console.log('Click');
    let ccustVal = getFieldValue(this.account.data, CCUST_FIELD);
    console.log(ccustVal);
    console.log(this.itemList);
        this.displayedData = this.itemList.filter(item => {
            let num = item.Customer_2.toString();
            //let endUserNr = item.End_user_number;
            //return num === ccustVal || endUserNr === ccustVal;
            return num === ccustVal;
        })

        console.log('Not crashed');
        console.log(this.displayedData);

}
handleChangeSearchProductType(){

}

    //List
    
    columns = [


    {
        type: 'text',
        fieldName: 'worksitename',
        label: 'Site',
        initialWidth: 90,
    },
    {
        type: 'text',
        fieldName: 'Modelname',
        label: 'Model',
        initialWidth: 95,
    },
    {
        type: 'text',
        fieldName: 'Segments',
        label: 'Segments',
        initialWidth: 110,
    },
    {
        type: 'text',
        fieldName: 'localserialnumber',
        label: 'Serial',
        initialWidth: 90,
    },
    

    ];
    displayedData;
    
    //detail page
    chosenProduct;
    lookupProduct(id){
        console.log('Looking up id: '+id);
        return this.itemList.find(item => {
            return item.IPROD === id;
        })
        console.log(obj);
      
    }
    searchResultsClick(event){



        console.log('1');
        const selectedRows = event.detail.selectedRows;
        const selectedRow = selectedRows[0];
        console.log(selectedRow.name);
        let retrievedProduct = this.lookupProduct(selectedRow.IPROD);
        console.log('retrievedProduct');
        console.log(retrievedProduct);
        this.chosenProduct = retrievedProduct;
        this.chosenProduct.unitPriceInc = '100000';
    }
    addToQuoteClick(){
        console.log('click');
        console.log(this.quantityChosen);
        addProductToQuote({quoteId: this.recordId, nameInc: this.chosenProduct.IDESC, quantityInc: this.quantityChosen, unitPriceInc: this.chosenProduct.unitPriceInc})
        .then((result) => {
        if(result === 'error'){
            this.showErrorNotification(result.message, result.message2);
            this.sidebarProcessing = false;
        }
        else if(result ==='success'){
            this.sidebarProcessing = false;
            this.showNotification('Success', 'Product added', 'success');
            this.navigateToQuote();
        }
        })
        .catch((error) => {
        this.sidebarProcessing = false;
        this.showNotification('Error', 'Product not added', 'error');
        })
    }
    handleQuantityChange(e) {
        this.quantityChosen = e.detail.value;
    }
    connectedCallback(){
        console.log('START: '+this.recordId);
        fetch(MYJSON)
      .then((response) => response.json())
      .then((data) => {
        var objCount = data.length;
        console.log('objcount: '+objCount);
        this.itemList = data;
      });
       
    }
    showNotification(title, text, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: text,
            variant: variant,
        });
        this.dispatchEvent(evt);
      }
      navigateToQuote() {
        // Navigate to the Accounts object's Recent list view.
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
              objectApiName: "Quote",
              actionName: "view",
              recordId: this.recordId
            }
          });
      }
}