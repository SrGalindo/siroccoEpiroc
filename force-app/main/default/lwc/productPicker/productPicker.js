import { LightningElement, api, track } from 'lwc';
//import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import { NavigationMixin } from 'lightning/navigation';
import LightningConfirm from 'lightning/confirm';
import addProductToOpportunity from "@salesforce/apex/OpportunityProductPicker.addProductToOpportunity";
import getItem from "@salesforce/apex/QuoteProductPicker.getItem";
import getItems from "@salesforce/apex/QuoteProductPicker.getItems";
import getItemPricing from "@salesforce/apex/QuoteProductPicker.getItemPricing";
import getObjectData from "@salesforce/apex/QuoteProductPicker.getObjectData";
import PRODUCTJSON from '@salesforce/resourceUrl/Complex_Products_Nov_2022_V2';

//export default class ProductPicker extends NavigationMixin(LightningElement) {
export default class ProductPicker extends LightningElement {
    quantityChosen = 1;
    productPickerName = '';
    accountData  = {};
    @api recordId;
    itemList = [];
    itemListsubset = [];
    // @track itemMap = new Map();
    basketItemList = []; // list of basketItems; basketItem = { index, quantity, itemNumber}
    @track basket = new Map();
    @track basketList = [];
    activeSearch = false;
    simpleProductPickerActivated;
    anyProductsAdded;
    pageNumber = 0;
    pageNumberDisplayed = 1;
    displayedDataHasFurtherEntries;
    displayedDataHasPreviousEntries;
    searchOptionValue = 'itemno';
    @track setSelectedRows  = [];
    quickAddValue;
    quickAddTextEnabled = false;
    quickProductsList = [];
    availabilityList = [];
    @track quickProductsNotRealList = [];
    addedItemsCounter;
    retrievedItemsCounter = 0;
    retrievedItemsCounterTarget = 0;

    @api objectType;
    @api navigate;
    @api toast;
    @track unsavedChanges = false;
    @track paginationNeeded = false;

    get basketLabel() {
        return 'Basket ('+this.basketList.length+')';
    }

    get hasDataToDisplay() {
        return (this.displayedData && (this.displayedData.length > 0));
    }

    //Search
    get searchProductOptions() {
        if(this.simpleProductPickerActivated){
            return [
                { label: 'Item', value: 'itemdesc' },
                { label: 'Item number', value: 'itemno' },
            ];
        }
        else{
            return [
                { label: 'Item', value: 'itemdesc' },
            ];
        }
    }

    get searchProductTypePlaceholder() {
        if(this.simpleProductPickerActivated){
            return [
                'Item no'
            ];
        }
        else{
            return [
                'Item'
            ];
        }
    }

    searchClicked() {
        console.log('handle searchClicked');
        this.doSearch();
    }
  
    searchEnterPressed(evt) {
        const isEnterKey = evt.keyCode === 13;
        if (isEnterKey) {
            this.doSearch();
        }
    }

    doSearch() {
        this.hideProductDetails();
        console.log(this.simpleProductPickerActivated);
        console.log(!this.accountData.famCode);
        console.log(!this.accountData.custno);
        if(this.simpleProductPickerActivated && (!this.accountData.famCode)){
            console.log('throwing');
            this.showErrorNotification('Salesforce misconfiguration', 'No Unit Code on Account found.');
            // Error err = new Errorr
            // throw new Error('Fam code or custNo not set');
        }
        console.log('not throwing');
        this.displayedData = [];
        this.pageNumber = 0;
        this.pageNumberDisplayed = 1;
        console.log('S 2');
        //let queryTerm = evt.target.value; EP
        let queryTerm = this.template.querySelector('lightning-input[data-id="searchInput"]').value;
        this.activeSearch = true;
        if(this.simpleProductPickerActivated){
            switch(this.searchOptionValue){
                case 'itemdesc':
                    console.log('itemdesc case');
                    getItems({famCode: this.accountData.famCode, description: queryTerm, itemNumber: null})
                    .then((result) => {
                        this.activeSearch = false;
                        console.log('status? '+result.status);
                        if(result.status === 'error'){
                            this.showErrorNotification(result.message, result.message2);
                        }
                        else if(result.status ==='success'){
                            console.log('result? ');
                            console.log(result);
                            if(result.statusCode === '500'){
                                console.log('Error 500');
                                this.showErrorNotification('Error 500: Internal server error', 'Item API down for maintenance');
                            }
                            console.log('result?2 ');

                            console.log(result.message.length);
                            console.log('result?3 ');
                            let itemsParsed = JSON.parse(result.message);
                            console.log('result?4');
                            //this.displayedData = itemsParsed.items;
                            console.log('before parsed  setter');
                            let itemsParsed2 = {};
                            itemsParsed2.items = itemsParsed.items.map((elem) => ({
                                ...elem,
                                ...{
                                    'currency': this.accountData.currency,
                                }
                            }));
                            console.log('past parsed  setter');
                            console.log('itemsParsed2.items: ',itemsParsed2.items);
                            this.itemListsubset = itemsParsed2.items;
                            this.updatePage();
                        }
                    })
                    .catch((error) => {
                        this.activeSearch = false;
                        this.showNotification('Error', error.body.message, 'error');
                    })
                    break;

                case 'itemno':
                    console.log('itemno case');
                    console.log('this.accountData.famCode: '+this.accountData.famCode);
                    console.log('queryTerm: '+queryTerm);
                    //getItem({famCode: this.accountData.famCode, itemNumber: queryTerm, currencyArg: this.accountData.currency, custNo: this.accountData.custno})
                    getItems({famCode: this.accountData.famCode, description: null, itemNumber: queryTerm})
                        .then((result) => {
                        this.activeSearch = false;
                        console.log('status? '+result.status);
                        if(result.status === 'error'){
                            this.showErrorNotification(result.message, result.message2);
                        }
                        else if(result.status ==='success'){
                            console.log(result.message);
                            let itemsParsed = JSON.parse(result.message);
                           // itemsParsed = itemsParsed.map((elem) => ({
                           //     ...elem,
                           //     ...{
                           //         'itemNumber': elem.Product_Model_Internal,
                           //         'itemDescription': elem.Product_Model_Internal,
                           //         'productLineCode': elem.Product_Line,
                           //         'productDivision': elem.Division
                           //     }
                           //  }));
                           //this.displayedData = itemsParsed.items;
                            let itemsParsed2 = {};
                            itemsParsed2.items = itemsParsed.items.map((elem) => ({
                                ...elem,
                                ...{
                                    'currency': this.accountData.currency,
                                }
                            }));
                            console.log('past parsed  setter');
                            this.itemListsubset = itemsParsed2.items;

                            console.log('itemlistsubset:  ');
                            console.log(this.itemListsubset);
                            this.updatePage();
                        }
                    })
                    .catch((error) => {
                        this.activeSearch = false;
                        this.showNotification('Error', error.body.message, 'error');
                    })
                    break;
            }
        }
        else {
            if(queryTerm) queryTerm = queryTerm.toLowerCase();
            console.log(queryTerm);
            this.itemListsubset = this.itemList.filter(item => {
                //let num = item.IPROD.toString();
                if(item.Product_Model_Internal) return item.Product_Model_Internal.toLowerCase().includes(queryTerm);
            })
            for(let i = 0; i < this.itemListsubset.length; i++){
            }
            console.log('december list');
            console.log(this.itemListsubset.length);
            console.log(this.itemListsubset);
            this.updatePage();
            this.activeSearch = false;
        }
    }

    handleChangeSearchProductType(event){
        console.log(event.detail.value);
        this.searchOptionValue = event.detail.value;
    }

    assignColumns() {
        if (this.simpleProductPickerActivated) {
            this.columns = [
                {
                    type: 'text',
                    fieldName: 'itemNumber',
                    label: 'ItemNumber'
                    //initialWidth: 180,
                },
                {
                    type: 'text',
                    fieldName: 'itemDescription',
                    label: 'itemDescription'
                    //initialWidth: 180,
                }
            ];
            if (screen.width > 600) {
                var additionalColumnsForWideScreen = [
                    {
                        type: 'text',
                        fieldName: 'extraItemDescription',
                        label: 'extraItemDescription'
                        //initialWidth: 180,
                    },
                    {
                        type: 'text',
                        fieldName: 'productLineCode',
                        label: 'Business Line'
                        //initialWidth: 150,
                    },
                    {
                        type: 'text',
                        fieldName: 'productDivision',
                        label: 'Division'
                        //initialWidth: 150,
                    }
                ];
                this.columns = this.columns.concat(additionalColumnsForWideScreen);
            }
        } else {
            this.columns = [
               {
                   type: 'text',
                   fieldName: 'Division',
                   label: 'Division'
                   //initialWidth: 120,
               },
               {
                   type: 'text',
                   fieldName: 'Business_Line',
                   label: 'Business_Line'
                   //initialWidth: 120,
               },
               {
                   type: 'text',
                   fieldName: 'Product_Model_Internal',
                   label: 'Product_Model_Internal'
                   //initialWidth: 120,
               },
               {
                   type: 'text',
                   fieldName: 'Product_Line',
                   label: 'Product_Line'
                   //initialWidth: 120,
               },
               {
                   type: 'text',
                   fieldName: 'Product_Family',
                   label: 'Product_Family'
                   //initialWidth: 120,
               },
               {
                   type: 'text',
                   fieldName: 'GAC',
                   label: 'GAC'
                   //initialWidth: 75,
               }
            ];
        }
    }

    availabilityColumns = [
        {
            type: 'text',
            fieldName: 'warehouseName',
            label: 'Warehouse'
            //initialWidth: 250,
        },
        {
            type: 'text',
            fieldName: 'freeStock',
            label: 'Stock'
            //initialWidth: 180,
        }
        ];
    displayedData;
    
    //detail page
    @track chosenProduct;
    lookupProduct(id){
        console.log('Looking up id: '+id);
        if(this.simpleProductPickerActivated){
            return this.displayedData.find(item => {
                return item.itemNumber === id;
            })
        }
        else {
            return this.displayedData.find(item => {
                return item.Product_Model_Code_Internal === id;
            })
        }
    }
    searchResultsClick(event){
        console.log('searchclick');
        this.quantityChosen = 1;
        //this.setSelectedRows = event.detail.selectedRows; EP
        const selectedRows = event.detail.selectedRows;
        const selectedRow = selectedRows[0];
        if(selectedRow == this.chosenProduct) console.log('IT THE SAME PRODUCT');
        if(!selectedRow) return;
        console.log('retrievedProduct');
        this.chosenProduct = selectedRow;
        this.showProductDetails(); // EP - adjust grid column sizing

        if(this.simpleProductPickerActivated){
            if(!selectedRow.cPdiscountPercentRetrieved){
                console.log('Fetching');
                let calloutRefreshControl = 0;
                getItemPricing({famCode: this.accountData.famCode, itemNumber: selectedRow.itemNumber, currencyArg: this.accountData.currency, custNo: this.accountData.custno, quantityArg: 1})
                .then((result) => {
                if(result.status === 'error'){
                    console.log('Item price error');
                    calloutRefreshControl++;
                    console.log(result.status);
                    console.log(result.message);
                    this.showErrorNotification(result.status, result.message);
                    // this.sidebarProcessing = false; EP
                }
                else if(result.status ==='success'){
                    console.log('Item price success');
                    calloutRefreshControl++;
                    console.log(result.status);
                    console.log(result.message);
                    let productParsed = JSON.parse(result.message);
                    //selectedRow.cPnetPrice = productParsed.cPnetPrice.split('.')[0];
                    //selectedRow.cPdiscountPercent = productParsed.cPdiscountPercent;
                    //selectedRow.cPlistPrice = productParsed.cPlistPrice.split('.')[0];
                    //selectedRow.listPrice = productParsed.cPlistPrice.split('.')[0];
                    selectedRow.cPnetPrice = productParsed.cPnetPrice;
                    selectedRow.cPdiscountPercent = productParsed.cPdiscountPercent;
                    selectedRow.cPlistPrice = productParsed.cPlistPrice;
                    //selectedRow.listPrice = productParsed.cPlistPrice; EP
                    selectedRow.cPcurrency = productParsed.cPcurrency;
                    console.log('2');
                    selectedRow.cPdiscountPercentRetrieved = true;
                    console.log('Retrieved');
                    console.log(selectedRow.itemNumber);
                    this.chosenProduct = selectedRow;
                    console.log(this.chosenProduct.itemNumber);
                    if(calloutRefreshControl === 2) {
                        this.simpleProductPickerActivated = false;
                        this.simpleProductPickerActivated = true;
                    }
                }
                })
                .catch((error) => {
                this.activeSearch = false;
                this.showNotification('Error', error.body.message, 'error');
                })
                getItem({famCode: this.accountData.famCode, itemNumber: selectedRow.itemNumber})
                .then((result) => {
                if(result.status === 'error'){
                    calloutRefreshControl++;
                    this.showErrorNotification(result.status, result.message);
                }
                else if(result.status ==='success'){
                    calloutRefreshControl++;
                    let productParsed = JSON.parse(result.message);
                    console.log('productParsed22freeStockDetail');
                    console.log(productParsed.freeStockDetail);
                    console.log('productParsed33productParsed');
                    console.log(productParsed);
                    let incrementor = 1;
                    productParsed.freeStockDetail.map((looper) => {
                        console.log('looping');
                        console.log(looper);
                        looper.id = incrementor;
                        incrementor++;
                        }
                    )
                    if(productParsed.freeStockDetail.length < 1){
                        let emptyWarehouseRow = {warehouse: '0', warehouseName: 'No availability'};
                        productParsed.freeStockDetail.push(emptyWarehouseRow);
                    }
                    console.log('almost end');
                    this.chosenProduct.freeStockDetail = productParsed.freeStockDetail;
                    selectedRow.freeStockDetail = productParsed.freeStockDetail;
                    if(calloutRefreshControl === 2) {
                        this.simpleProductPickerActivated = false;
                        this.simpleProductPickerActivated = true;
                    }
                    console.log('end');
                }
                })
                .catch((error) => {
                calloutRefreshControl++;
                this.activeSearch = false;
                this.showNotification('Error', error.body.message, 'error');
                })
            }
            if(selectedRow.cPdiscountPercentRetrieved){
                console.log('Avoiding fetch')
                this.chosenProduct = selectedRow;
            }
        }
        else{

        }
        console.log('Toggling visibility');
        console.log('Last code to run');
    }
    saveToQuoteClick(){
        console.log('addProductToOpportunity');
        console.log(this.basketList[0].cPlistPrice);
        this.activeSearch = true;
        addProductToOpportunity({opportunityId: this.recordId, itemsArg: this.basketList})
        .then((result) => {
        if(result === 'error'){
            this.activeSearch = false;
            this.showErrorNotification(result.message, result.message2);
        }
        else if(result ==='success'){
            this.activeSearch = false;
            this.unsavedChanges = false;
            this.showNotification('Success', 'Product added', 'success');
            this.navigateToQuote();
        }
        })
        .catch((error) => {
            this.activeSearch = false;
            this.showNotification('Error', error.body.message, 'error');
        })
    }
    removePillItem(event) {
        const pillIndex = event.target.dataset.index;
        console.log('pillindex: '+pillIndex);
        const pillItemNr = event.target.dataset.itemnr;
        console.log('itemnr: '+pillItemNr);

        const itempill = this.basketList;
        itempill.splice(pillIndex, 1);
        console.log('REMOVE');
        this.removeItemIdBasketMap(pillItemNr);
        this.basketList = [...itempill];
    }
    removeItemIdBasketMap(itemNrArg){
        if(this.basket.has(itemNrArg)){
            this.basket.delete(itemNrArg);
            if(this.basket.size > 0){
                this.anyProductsAdded = true;
            } else {
                this.anyProductsAdded = false;
                this.unsavedChanges = false;
            }
        }
    }
    removeItemIdFromBasketList(itemNrArg){
        this.basketList.splice(this.basketList.findIndex(e => e.itemNumber === itemNrArg),1);
    }
    setBasketList(){
        this.basketList = Array.from(this.basket.values());
        console.log('basketlist:');
        console.log(this.basket.values());
    }
    getDisplayName(quantity){
        let displayName = quantity+':';
        return displayName

    }
    getBasketExtraText(product){
        let extraTextOnBasket = product.productLineCode+', '+product.productDivision;
        return extraTextOnBasket

    }
    addToBasket(event){
        console.log('AddToBasket');
        this.showNotification('Basket updated', 'Added product to basket', 'success');
        let quantity = this.quantityChosen;
        let currentItemNumber = this.chosenProduct.itemNumber;
        this.chosenProduct.quantity = quantity;
        this.chosenProduct.displayName  = this.getDisplayName(quantity);
        this.chosenProduct.extraTextOnBasket  = this.getBasketExtraText(this.chosenProduct);
        this.chosenProduct.totalPrice = Math.round(quantity * this.chosenProduct.cPlistPrice * 100) / 100;
        this.basket.set(currentItemNumber,this.chosenProduct);
        console.log(this.chosenProduct.itemNumber);
        console.log(this.basket.size);
        this.setBasketList();
        this.basket.size > 0 ? this.anyProductsAdded = true : this.anyProductsAdded = false;
        this.unsavedChanges = true;
        // EP
        /*
        var basketItemIndex = this.basketItemList.length;
        var basketItem = {
            "index": basketItemIndex,
            "quantity": this.quantityChosen,
            "displayName"
        };*/
    }
    handleQuantityChange(e) {
        this.quantityChosen = e.detail.value;
    }
    increaseQuantityClick(e){
        let chosenItemNr = e.target.dataset.itemnr;
        let currentItem = this.basket.get(chosenItemNr);
        let newQuantity = currentItem.quantity;
        newQuantity++;
        currentItem.displayName = this.getDisplayName(newQuantity);
        currentItem.quantity = newQuantity;
        currentItem.totalPrice = Math.round(newQuantity * currentItem.cPlistPrice * 100) / 100;
        this.basket.set(chosenItemNr,currentItem);
        this.setBasketList();
    }
    decreaseQuantityClick(e){
        let chosenItemNr = e.target.dataset.itemnr;
        let currentItem = this.basket.get(chosenItemNr);
        let newQuantity = currentItem.quantity;
        newQuantity--;
        if(newQuantity > 0){
            currentItem.displayName = this.getDisplayName(newQuantity);
            currentItem.quantity = newQuantity;
            currentItem.totalPrice = Math.round(newQuantity * currentItem.cPlistPrice * 100) / 100;
            this.basket.set(chosenItemNr,currentItem);
            this.setBasketList();
        }
    }
    get noProductsAdded(){
        return !this.anyProductsAdded;
    }
    connectedCallback(){
        window.addEventListener('keyup', event => {
            if (event.key === "Escape") {
                this.close();
            }
        }, true);
        getObjectData({recordId: this.recordId})
        .then((cbw) => {
            console.log('INFO');
            let mixedObjectData = JSON.parse(cbw.message);

            console.log(cbw.message);
            console.log('DATA');
            console.log(mixedObjectData);
            this.accountData = mixedObjectData;
            if(mixedObjectData.recordType == 'Simple_Opportunity'){
                this.simpleProductPickerActivated = true;
                this.productPickerName = 'Product Picker, Simple';
            }
            else if (mixedObjectData.recordType == 'Complex_bid') {
                this.simpleProductPickerActivated = false;
                this.productPickerName = 'Product Picker, Complex';
                fetch(PRODUCTJSON)
                .then((response) => response.json())
                .then((data) => {
                    console.log(typeof data);
                    console.log(data);
                    
                    this.itemList = data;
                    this.itemList = data.map((elem) => ({
                        ...elem,
                        ...{
                            'itemNumber': elem.Product_Model_Internal,
                            'itemDescription': elem.Product_Model_Internal,
                            'productLineCode': elem.Product_Line,
                            'productDivision': elem.Division
                        }
                     }));
                    console.log(this.itemList);
                    console.log('end connected callback complex');
                })
            }
            this.assignColumns();
        })
      }
       
    showNotification(title, text, variant) {
        this.toast(title, text, variant);
    }
    navigateToQuote() {
        this.navigate(this.recordId);
    }
    updatePage() {
        this.pageNumberDisplayed = this.pageNumber +1;
        console.log('Update page');
        //this.chosenProduct = null;
        this.setSelectedRows = [];
        //this.itemListsubset = this.itemList.slice(this.pageNumber*10, this.pageNumber*10+10);
        this.displayedData = this.itemListsubset.slice(this.pageNumber*10, ((this.pageNumber*10)+10));
        console.log('Update page2');
        let itemListLeftovers = this.itemListsubset.slice((this.pageNumber +1)*10, (this.pageNumber +1)*10+1);
        console.log('Update page3');

        if(this.pageNumber === 0){
            this.displayedDataHasPreviousEntries = false;
        }
        else {
            this.displayedDataHasPreviousEntries = true;
        }
        if(itemListLeftovers.length < 1){
            this.displayedDataHasFurtherEntries = false;
        }
        else {
            this.displayedDataHasFurtherEntries = true;
        }
        this.paginationNeeded = (this.itemListsubset.length > 10);
        console.log('123');
    }
    quickAddClick(){
        this.quickAddTextEnabled = !this.quickAddTextEnabled;
    }
    checkPasteLength(e){
          //var clipboardData = e.clipboardData || window.clipboardData;
          var clipboardData = e.clipboardData;
          console.log('clip');
          //clipboardData.forEach(x => console.log(x));
          console.log('clip2');
          let newstr = clipboardData.getData("text");
          this.quickAddSearch(newstr);
    }
    quickAddSearch(clipboardData){
            let numberFinderReg = new RegExp('^[0-9]*$');
            this.quickProductsNotRealList = [];
            console.log('start');
            console.log(clipboardData);
            console.log('quicksearch1');
            //const regex = /^[0-9]+[A-Z]+/g;
            const regex = /[0-9]+/g;
            //let numbersArray = clipboardData.match('[0-9]+/g');
            let numbersArray = clipboardData.match(regex);
            console.log('quicksearch2 first');
            console.log(numbersArray[0]);
            console.log(numbersArray[1]);
            console.log('quicksearch2 length');
            console.log(numbersArray.length);
            let itemNumberArray  = [];
            console.log('innan loop');
            for(let i = 0; i < numbersArray.length; i+=2){
                console.log('Looping' +i);
                //Paste format is always: itemNumber first, then follows quantity.
                let newPossibleItem = {itemNumber: numbersArray[i], quantity: numbersArray[i+1]};
                console.log('newPossibleItem');
                console.log(newPossibleItem);
                itemNumberArray.push(newPossibleItem);
            }
            console.log('Pre-process for unique numbers');
            let basketItemsTempArray = [];
            let processedArray= [];
            // numbersArray.forEach(function(x){
            //     if(!processedArray.find(y => y === x)){
            //         console.log('pushing: '+x);
            //         processedArray.push(x); 
            //     }
            // });
            this.addedItemsCounter = 0;
            this.retrievedItemsCounter = 0;
            this.retrievedItemsCounterTarget = (itemNumberArray.length);
            itemNumberArray.forEach(n => {
                console.log('n: '+n);
                let newBasketItem = n;
                newBasketItem.itemDescription = n.itemNumber;
                newBasketItem.displayName = this.getDisplayName(n.quantity);
                console.log('itemNumber:  '+n);
                getItem({famCode: this.accountData.famCode, itemNumber: newBasketItem.itemNumber})
                    .then((result) => {
                    console.log('Big-status? '+result.status);
                    console.log('Used:  '+n);
                    if(result.status === 'error'){
                        console.log('Big retrieve error');
                        console.log(result.message);
                        this.showErrorNotification(result.message, result.message2);
                        //this.sidebarProcessing = false; EP
                        this.quickProductsNotRealList.push(newBasketItem);
                        this.retrievedItemsCounter++;
                    }
                    else if(result.status ==='success'){
                        console.log('Big retrieve1');
                        //console.log(result.message.length);
                        console.log(result);
                        if(result.message  === ''){
                            this.quickProductsNotRealList.push(newBasketItem);
                            this.removeItemIdFromBasketList(newBasketItem.itemNumber);
                            this.retrievedItemsCounter++;
                            this.setBasketListFromAsyncContext(basketItemsTempArray);
                        }
                        else{

                        let itemsParsed = JSON.parse(result.message);
                        if(itemsParsed.statusCode === '500'){
                            console.log('Error 500');
                            this.showErrorNotification('Error 500: Internal server error', 'Item API down for maintenance');
                        }
                        
                        //this.displayedData = itemsParsed.items;
                        //this.itemListsubset[0] = Object.assign(this.itemListsubset[0], itemsParsed.items[0]);
                        //this.updatePage();
                        if(itemsParsed){
                            console.log('item specific parsed');
                            console.log(itemsParsed);
                            let oldQuantity = newBasketItem.quantity;
                            newBasketItem = itemsParsed;
                            newBasketItem.quantity = oldQuantity;
                            newBasketItem.displayName = this.getDisplayName(oldQuantity);
                            console.log('1111');
                            getItemPricing({famCode: this.accountData.famCode, itemNumber: newBasketItem.itemNumber, currencyArg: this.accountData.currency, custNo: this.accountData.custno, quantityArg: newBasketItem.quantity})
                            .then((result) => {
                                console.log('running individual callout');
                                if(result.status === 'error'){
                                    console.log('Error');
                                    this.retrievedItemsCounter++;
                                    this.showErrorNotification(result.message, result.message2);
                                    //this.sidebarProcessing = false; EP
                                }
                                else if(result.status ==='success'){
                                    console.log(result.message);
                                    if(result.message  === ''){
                                        this.retrievedItemsCounter++;
                                    }
                                    else {
                                        let itemsParsed = JSON.parse(result.message);
                                        console.log('Parsed');
                                        console.log(itemsParsed);
                                        //newBasketItem = itemsParsed;
                                        newBasketItem = Object.assign(newBasketItem, itemsParsed);
                                        newBasketItem.extraTextOnBasket = this.getBasketExtraText(newBasketItem);
                                        basketItemsTempArray.push(newBasketItem);
                                        console.log('new obj');
                                        this.retrievedItemsCounter++;
                                        console.log(newBasketItem);
                                        console.log('success end');
                                        console.log('tar: '+this.retrievedItemsCounterTarget);
                                        console.log('counter: '+this.retrievedItemsCounter);
                                        //Async,  when the last item is retrieved from integration, set the lists and refresh page.
                                        this.setBasketListFromAsyncContext(basketItemsTempArray);
                                    }
                                }
                                })
                                .catch((error) => {
                                this.quickProductsNotRealList.push(newBasketItem);
                                this.retrievedItemsCounter++;
                                console.log('Error catch');
                                console.log(error);
                                this.showNotification('Error', error.body.message, 'error');
                                })
                        } else {
                            console.log(newBasketItem.itemNumber +' is now null');
                            this.quickProductsNotRealList.push(newBasketItem);
                            this.removeItemIdFromBasketList(newBasketItem.itemNumber);
                            //newBasketItem = null;
                            this.retrievedItemsCounter++;
                            this.setBasketListFromAsyncContext(basketItemsTempArray);
                            //this.basketGUIRefresh();
                        }
                    }

                        
                    }
                    })
                    .catch((error) => {
                    console.log('Error catch 2');
                    console.log(newBasketItem);
                    console.log(error);
                    this.activeSearch = false;
                    this.showNotification('Error', error.body.message, 'error');
                    })
                console.log('Weird spot rn');
                //this.quickProductsList.push(newBasketItem);
            });
            let tempArray = this.quickProductsList.concat(this.basketList);
            let tempArrayWithoutDuplicates  = [...new Set(tempArray.flat())];
            this.basketList = tempArrayWithoutDuplicates;
            this.anyProductsAdded = this.setProductsAdded(tempArrayWithoutDuplicates);
            console.log('any?');
            console.log(tempArrayWithoutDuplicates.length);
            console.log(this.anyProductsAdded);
            this.basketGUIRefresh();

    }
    setProductsAdded(listInc){
        if(listInc.length >0) return true;
    }
    basketGUIRefresh(){
        this.anyProductsAdded = false;
        this.anyProductsAdded = true;
    }
    // Back a page
    previous() {
        this.pageNumber = Math.max(0, this.pageNumber - 1);
        this.updatePage();
    }
    // Back to the beginning
    first() {
        this.pageNumber = 0;
        this.updatePage()
    }
    // Forward a page
    next() {
        this.pageNumber++;
        this.updatePage()
    }
    // Forward to the end
    last() {
        this.pageNumber = Math.ceil(((this.itemListsubset.length)/10)-1);
        this.updatePage()
    }
    showErrorNotification(title, text){
        this.showNotification(title, text, 'error');
    }
    setBasketListFromAsyncContext(basketItemsTempArray){
        if(this.retrievedItemsCounterTarget === this.retrievedItemsCounter){
            console.log('Target reach: '+this.retrievedItemsCounterTarget);
            console.log(this.quickProductsNotRealList);
            if(this.quickProductsNotRealList.length > 0){
                this.hasNonRealProducts = true;
            }
            let tempArray2 = basketItemsTempArray;
            this.basketList = [];
            this.basketGUIRefresh();
            this.basketList = [...tempArray2];
            this.basketGUIRefresh();
            this.basketList.forEach(looper =>{
                this.basket.set(looper.itemNumber, {...looper});
                console.log('looper');
                console.log(looper);
            })
        }
    }
    nonAddedProductsOkClick(){
        this.quickProductsNotRealList = [];
        this.hasNonRealProducts = false;
        this.basketGUIRefresh();
    }

    async close() {
        console.log('Close');

        if (this.unsavedChanges) {
            console.log('there are unsaved changes');
            const result = await LightningConfirm.open({
                message: 'There are unsaved items in the basket. Do you want to close this window?',
                variant: 'header',
                label: 'Confirm close',
                theme: 'warning',
            });
            if (result) {
                console.log('close confirmed');
                this.navigate(this.recordId);
            } else {
                console.log('close cancelled');
            }
        } else {
            console.log('no unsaved changes, redirect');
            this.navigate(this.recordId);
        }
    }

    hideProductDetails() {
        this.chosenProduct = null;
        this.setSelectedRows = [];
        this.template.querySelector('[data-id="searchArea"]').classList.remove('slds-size_1-of-2');
        this.template.querySelector('[data-id="searchArea"]').classList.add('slds-size_1-of-1');
        this.template.querySelector('[data-id="searchInput"]').classList.remove('slds-size_1-of-1');
        this.template.querySelector('[data-id="searchInput"]').classList.add('slds-size_1-of-2');
    }

    showProductDetails() {
        this.template.querySelector('[data-id="searchArea"]').classList.remove('slds-size_1-of-1');
        this.template.querySelector('[data-id="searchArea"]').classList.add('slds-size_1-of-2');
        this.template.querySelector('[data-id="searchInput"]').classList.remove('slds-size_1-of-2');
        this.template.querySelector('[data-id="searchInput"]').classList.add('slds-size_1-of-1');
    }
}