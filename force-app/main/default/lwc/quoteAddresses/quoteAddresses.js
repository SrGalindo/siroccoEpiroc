import { LightningElement, api, track } from 'lwc';
import searchRecords from '@salesforce/apex/OpportunityAddressController.searchRecords';
import getPreselectedAddress from '@salesforce/apex/OpportunityAddressController.getPreselectedAddress';
import saveAddress from '@salesforce/apex/OpportunityAddressController.saveAddress';
import deleteAddress from '@salesforce/apex/OpportunityAddressController.deleteAddress';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


const DELAY = 350;


export default class QuoteAddresses extends LightningElement {
  @api
  recordId
  @api
  objectApiName = 'Address__c';
  showPill = false;
  showPill2 = false;
  @api
  multiSelect = false;
  @api
  label;
  @api
  label2;
  @track
  records = null
  records2 = null
  @api
  selectedIds = []
  iconName = 'custom:custom31';
  @track
  selectedRecords = [];
  @track
  selectedRecords2 = [];
  @track
  searchKey;
  searchKey2;
  loading = false;
  loading2 = false;
  noRecords = false;
  noRecords2 = false;
  @api disableInput;
  @api disableInput2;

  connectedCallback(e) {
    //this.iconName = 'standard:' + this.objectApiName.toLowerCase();
    this.loading = true;
    getPreselectedAddress({ objectApiName: 'Quote', recordId: this.recordId, type: 'Ship-To' })
    .then((result) => {
      if (result && result.length) {
        //this.noRecords = true;

        // this.selectedRecord = result;
        // this.showPill = true;
        // console.log('this.selectedRecord');
        // console.log(this.selectedRecord);
        this.records = result;
        this.records.map(record => {
            this.selectedRecord = record;
            this.showPill = true;
          })
        this.records = null;

        //this.selectedRecord = result;
        //this.selectedRecord = result;
        this.loading = false;
        this.error = undefined;
      } else {
        this.loading = false;
        this.records = null;
      }
      console.log('async ship');
    })
    .catch((ex) => {
      this.loading = false;
      const toastEvent = new ShowToastEvent({
        title: 'Error',
        message: ex.body.message,
      });
      this.dispatchEvent(toastEvent);
      this.error = ex;
      this.records = null;
    });
    console.log('preselect id ship');
    getPreselectedAddress({ objectApiName: 'Quote', recordId: this.recordId , type: 'Bill-To' })
    .then((result) => {
      if (result && result.length) {
        //this.noRecords = true;

        // this.selectedRecord = result;
        // this.showPill = true;
        // console.log('this.selectedRecord');
        // console.log(this.selectedRecord);
        this.records2 = result;
        this.records2.map(record => {
            this.selectedRecord2 = record;
            this.showPill2 = true;
          })
        this.records2 = null;

        //this.selectedRecord = result;
        //this.selectedRecord = result;
        this.loading2 = false;
        this.error2 = undefined;
      } else {
        this.loading2 = false;
        this.records2 = null;
      }
      console.log('After preselect bill');
    })
    .catch((ex) => {
      this.loading2 = false;
      const toastEvent = new ShowToastEvent({
        title: 'Error',
        message: ex.body.message,
      });
      this.dispatchEvent(toastEvent);
      this.error2 = ex;
      this.records2 = null;
    });
    console.log('bill end');
  }


  handleKeyChange(event) {
    window.clearTimeout(this.delayTimeout);
    if (event.target.value) {
      this.loading = true;
      this.noRecords = true;
      const searchKey = event.target.value;
      const objectApiName = this.objectApiName;
      const selectedIds = this.selectedIds;
      this.delayTimeout = setTimeout(() => {
        searchRecords({ searchKey: searchKey, objectApiName: objectApiName, recordId: this.recordId, selectedIds: selectedIds, type: 'Ship-To' })
          .then((result) => {
            if (result && result.length) {
              this.noRecords = false;
              this.loading = false;
              this.records = result;
              this.error = undefined;
            } else {
              this.loading = false;
              this.records = null;
            }
          })
          .catch((ex) => {
            this.loading = false;
            const toastEvent = new ShowToastEvent({
              title: 'Error',
              message: ex.body.message,
            });
            this.dispatchEvent(toastEvent);
            this.error = ex;
            this.records = null;
          });
      }, DELAY);
    } else {
      this.records = null;
      this.noRecords = false;
      this.loading = false;
    }
  }
  handleKeyChange2(event) {
    window.clearTimeout(this.delayTimeout);
    if (event.target.value) {
      this.loading2 = true;
      this.noRecords2 = true;
      const searchKey = event.target.value;
      const objectApiName = this.objectApiName;
      const selectedIds = this.selectedIds2;
      this.delayTimeout = setTimeout(() => {
        searchRecords({ searchKey: searchKey, objectApiName: objectApiName, recordId: this.recordId, selectedIds: selectedIds, type: 'Bill-To' })
          .then((result) => {
            if (result && result.length) {
              this.noRecords2 = false;
              this.loading2 = false;
              this.records2 = result;
              this.error2 = undefined;
            } else {
              this.loading2 = false;
              this.records2 = null;
            }
          })
          .catch((ex) => {
            this.loading2 = false;
            const toastEvent = new ShowToastEvent({
              title: 'Error',
              message: ex.body.message,
            });
            this.dispatchEvent(toastEvent);
            this.error2 = ex;
            this.records2 = null;
          });
      }, DELAY);
    } else {
      this.records2 = null;
      this.noRecords2 = false;
      this.loading2 = false;
    }
  }
  addToSelected(event) {
    var params = {};
    var selectedId = event.target.getAttribute('value');
    this.records.map(record => {
      if (record.Id == selectedId) {
            this.selectedRecord = record;
            this.showPill = true;
            saveAddress({ objectApiName: 'Quote', recordId: this.recordId, addressId: record.Id, type: 'Ship-To' })
            .then((result) => {
                const toastEvent = new ShowToastEvent({
                    "variant": "Success",
                    title: 'Success',
                    message: 'Quote Bill-to updated',
                  });
                  this.dispatchEvent(toastEvent);
            })
            .catch((ex) => {
                this.clear();
            });
      }
    })
    
    if (this.multiSelect) {
      params = this.selectedRecords;
    } else {
      params = this.selectedRecord;
    }
    //const selectedEvent = new CustomEvent('recordupdated', { detail: params });
    //this.dispatchEvent(selectedEvent);
    this.records = null;
    console.log('this.selectedRecord');
    console.log(this.selectedRecord);
  }
  addToSelected2(event) {
    console.log('addToSelected2');
    this.loading2 = true;
    var selectedId2 = event.target.getAttribute('value');
    console.log('addToSelected3');
    console.log(selectedId2);
    this.records2.map(record => {
    console.log('addToSelected4');
        console.log(record.Id);
      if (record.Id == selectedId2) {
    console.log('addToSelected5');

        this.selectedRecord2 = record;
        this.showPill2 = true;
        saveAddress({ objectApiName: 'Quote', recordId: this.recordId, addressId: record.Id, type: 'Bill-To' })
        .then((result) => {
            this.loading2 = false;
            const toastEvent = new ShowToastEvent({
                "variant": "Success",
                title: 'Success',
                message: 'Quote Bill-to updated',
                });
                this.dispatchEvent(toastEvent);
        })
        .catch((ex) => {
            this.loading2 = false;
            this.clear2();
        });
      }
    })
    
    // if (this.multiSelect) {
    //   params = this.selectedRecords;
    // } else {
    //   params = this.selectedRecord;
    // }
    //const selectedEvent = new CustomEvent('recordupdated', { detail: params });
    //this.dispatchEvent(selectedEvent);
    this.records2 = null;
  }
//   handleRemove(event) {
//     var toRemove = event.detail.name;
//     if (this.selectedIds.includes(toRemove)) {
//       this.selectedRecords.splice(this.selectedIds.indexOf(toRemove), 1);
//       this.selectedIds.splice(this.selectedIds.indexOf(toRemove), 1);
//     }
//     deleteAddress({ objectApiName: 'Opportunity', recordId: this.recordId , type: 'Ship-To' })
//     .then((result) => {
//         this.loading = false;
//         const toastEvent = new ShowToastEvent({
//             title: 'Success',
//             message: 'Ship-To removed',
//           });
//           this.dispatchEvent(toastEvent);
//     })
//     .catch((ex) => {
//       this.loading = false;
//       const toastEvent = new ShowToastEvent({
//         title: 'Error',
//         message: ex.body.message,
//       });
//       this.dispatchEvent(toastEvent);
//       this.error = ex;
//       this.records = null;
//     });
//     //const selectedEvent = new CustomEvent('recordupdated', { detail: this.selectedRecords });
//     //this.dispatchEvent(selectedEvent);
//   }
//   handleRemove2(event) {
//       console.log('Remove bill to');
//     var toRemove2 = event.detail.name;
//     console.log(event.detail.name);
//     console.log(event.detail.id);
//     if (this.selectedIds2.includes(toRemove)) {
//         console.log(this.selectedIds2);
//       this.selectedRecords2.splice(this.selectedIds2.indexOf(toRemove2), 1);
//       this.selectedIds2.splice(this.selectedIds2.indexOf(toRemove2), 1);
//     }
//     deleteAddress({ objectApiName: 'Opportunity', recordId: this.recordId , type: 'Bill-To' })
//     .then((result) => {
//         this.loading2 = false;
//         const toastEvent = new ShowToastEvent({
//             title: 'Success',
//             message: 'Bill-To removed',
//           });
//           this.dispatchEvent(toastEvent);
//     })
//     .catch((ex) => {
//       this.loading2 = false;
//       const toastEvent = new ShowToastEvent({
//         title: 'Error',
//         message: ex.body.message,
//       });
//       this.dispatchEvent(toastEvent);
//       this.error2 = ex;
//       this.records2 = null;
//     });

//     //const selectedEvent = new CustomEvent('recordupdated', { detail: this.selectedRecords });
//     //this.dispatchEvent(selectedEvent);
//   }
  clear(event) {
    deleteAddress({ objectApiName: 'Quote', recordId: this.recordId , type: 'Ship-To' })
    .then((result) => {
        this.loading = false;
        const toastEvent = new ShowToastEvent({
            "variant": "Success",
            title: 'Success',
            message: 'Ship-To removed',
            });
            this.dispatchEvent(toastEvent);
            this.selectedRecord = null;
        this.showPill = false;
    })
    .catch((ex) => {
      this.loading = false;
      const toastEvent = new ShowToastEvent({
        title: 'Error',
        message: ex.body.message,
      });
      this.dispatchEvent(toastEvent);
      this.error = ex;
      this.records = null;
    });
    
    //const selectedEvent = new CustomEvent('recordupdated', { detail: this.selectedRecord });
    //this.dispatchEvent(selectedEvent);
  }
  clear2(event) {
    this.loading2 = true;
    deleteAddress({ objectApiName: 'Quote', recordId: this.recordId , type: 'Bill-To' })
    .then((result) => {
        this.loading2 = false;
        const toastEvent = new ShowToastEvent({
            "variant": "Success",
            title: 'Success',
            message: 'Bill-To removed',
        });
        this.dispatchEvent(toastEvent);
        this.selectedRecord2 = null;
        this.showPill2 = false;
    })
    .catch((ex) => {
      this.loading2 = false;
      const toastEvent = new ShowToastEvent({
        title: 'Error',
        message: ex.body.message,
      });
      this.dispatchEvent(toastEvent);
      this.error2 = ex;
      this.records2 = null;
    });
    
    //const selectedEvent = new CustomEvent('recordupdated', { detail: this.selectedRecord });
    //this.dispatchEvent(selectedEvent);
  }
}