/**
 * @description       : 
 * @author            : Ahmad Nawaz
 * @group             : 
 * @last modified on  : 09-08-2022
 * @last modified by  : Ahmad Nawaz
**/
import { LightningElement, track, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
//import saveFile from '@salesforce/apex/QuoteProductPicker.saveFile';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Name', fieldName: 'Name__c' },
    { label: 'Quantity', fieldName: 'Quantity' },
    { label: 'Unit Price', fieldName: 'UnitPrice' }
 ];

export default class ImportQuoteLines extends LightningElement {

    @api recId;
    @track columns = columns;
    @track data;
    @track fileName = 'No file selected';
    @track color = 'color:red';
    @track UploadFile = 'Upload CSV File';
    @track showLoadingSpinner = false;
    @track isTrue = false;
    selectedRecords;
    filesUploaded = [];
    file;
    fileContents;
    fileReader;
    content;
    MAX_FILE_SIZE = 1500000;
    closeModel;

    handleFilesChange(event) {
        if(event.target.files.length > 0) {
            this.filesUploaded = event.target.files;
            this.fileName = event.target.files[0].name;
            this.color='color:green';
        }
    }

    handleSave() {
        if(this.filesUploaded.length > 0) {
            this.uploadHelper();
        }
        else {
            this.fileName = 'Please select a CSV file to upload!!';
        }
    }

    uploadHelper() {
        this.file = this.filesUploaded[0];
       if (this.file.size > this.MAX_FILE_SIZE) {
            window.console.log('File Size is to long');
            return ;
        }
        //this.showLoadingSpinner = true;
        this.fileReader= new FileReader();
        this.fileReader.onloadend = (() => {
            this.fileContents = this.fileReader.result;
            this.saveToFile();
        });
        this.fileReader.readAsText(this.file);
    }

        saveToFile() {
    //     saveFile({ base64Data: JSON.stringify(this.fileContents), quoteId: this.recId})
    //     .then(result => {
    //         window.console.log('result ====> ');
    //         window.console.log(result);
    //         this.data = result;
    //         this.fileName = this.fileName + ' - Uploaded Successfully';
    //         this.isTrue = false;
    //         this.showLoadingSpinner = false;
    //         this.dispatchEvent(
    //             new ShowToastEvent({
    //                 title: 'Success!!',
    //                 message: 'Quote lines have been imported successfully',
    //                 variant: 'success',
    //             }),
    //         );
    //         this.closeAction();
            
            
    //     })
    //     .catch(error => {
    //         window.console.log(error);
    //         this.dispatchEvent(
    //             new ShowToastEvent({
    //                 title: 'Error while uploading File',
    //                 message: error.message,
    //                 variant: 'error',
    //             }),
    //         );
    //     });
    }
    closeAction() {
        this.closeModel = true;

        const closeModel = this.closeModel;
            const valueChangeEvent = new CustomEvent("valuechange", {
                detail: { closeModel}
            });
            // Fire the custom event
            this.dispatchEvent(valueChangeEvent);
     }
}