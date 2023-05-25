import { LightningElement, api, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getMachinesByCustomerNumber from '@salesforce/apex/MolDataController.getMachinesByCustomerNumber';
import getMachineDetail from '@salesforce/apex/MolDataController.getMachineDetail';

export default class MolData extends NavigationMixin(LightningElement) {
    @api recordId;
    mainWindowOpen = false;
    loadingWindowOpen = true;
    errorWindowOpen = false;
    data = [];
    errorData;

    molcolumns = [
        { label: 'Model', fieldName: 'modelName'},
        { label: 'Serial Number', fieldName: 'serialNumber'},
        { label: 'Registration Status', fieldName: 'registrationStatus'},
        { label: 'Business Line', fieldName: 'businessLineFamCode'},
        { label: 'Product Line', fieldName: 'productLine'},
        { label: 'Comm. Date', fieldName: 'commissioningDate'},
        { label: 'Hours', fieldName: 'hours'},
        { label: 'Hours Type', fieldName: 'hoursType'},
        { label: 'Worksite', fieldName: 'worksite'},
        { label: 'Service Agreement', fieldName: 'serviceAgreement'},
    ];

    connectedCallback(){
        this.getMolData();
    }

    getMolData(){
        getMachinesByCustomerNumber({recordId: this.recordId})
        .then(result => {
            if(result.status === 'error'){
                //this.showErrorNotification('api error',result.message, 'error');
                this.errorData = result.message;
                this.loadingWindowOpen = false;
                this.errorWindowOpen = true;
            } else if(result.status === 'success'){
                let items = JSON.parse(result.message);
                this.data = items.map(item => ({
                    ...item
                }));
                let itemIds2 = this.data.map(item => item.id);
                let itemIds = itemIds2.slice(0, 99);

                getMachineDetail({machineItems: itemIds}).then(result => {
                    if(result.status === 'error'){
                        this.showErrorNotification('api error',result.message, 'error');
                        this.errorData = result.message;
                        this.loadingWindowOpen = false;
                        this.errorWindowOpen = true;
                    } else if(result.status === 'success'){
                        let items = JSON.parse(result.message);
                        this.data = items.map(item => ({
                            ...item
                        }));
                        if(itemIds.length == 99){
                            this.data.push({'modelName': 'More', 'serialNumber': 'machines', 'registrationStatus': 'available', 'businessLineFamCode': 'in', 'productLine': 'MOL'})
                        }
                        this.loadingWindowOpen = false;
                        this.mainWindowOpen = true;
                    }
                })
            }
        })
        .catch(error => {
            this.showNotification('Error', error.body.message, 'error');
            this.errorData = error.body.message;
            this.loadingWindowOpen = false;
            this.errorWindowOpen = true;
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