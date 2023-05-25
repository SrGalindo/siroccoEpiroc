import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import getItems from "@salesforce/apex/ForeignEquipment.getItems";

export default class ForeignEquipment extends NavigationMixin(LightningElement) {
    @api recordId;
    mainWindowOpen = false;
    loadingWindowOpen = true;
    errorWindowOpen = false;
    displayedData;
    errorData;
    columns = [
        { fieldName: 'brandname',label: 'Brand', initialWidth: 110 },
        { fieldName: 'model', label: 'Model', initialWidth: 110 },
        { fieldName: 'operationalStatusCode', label: 'operationalStatusCode', initialWidth: 80 },
        { fieldName: 'serialNumber', label: 'serialNumber',  initialWidth: 95 },
        { fieldName: 'machinetype', label: 'Machine Type', initialWidth: 130 },
        { fieldName: 'manufacturingDate', label: 'manufacturingDate', initialWidth: 80 },
        { fieldName: 'segment', label: 'Segment', initialWidth: 110 },
        { fieldName: 'worksite', label: 'worksite', initialWidth: 110 },
        { fieldName: 'utilization', label: 'utilization', initialWidth: 90 },
        { fieldName: 'dateOfVisiting', label: 'Date of visit', initialWidth: 150 },
        { fieldName: 'inputSource', label: 'Input source', initialWidth: 80 },
        { fieldName: 'name', label: 'name', initialWidth: 80 },
        { fieldName: 'id', label: 'id', initialWidth: 80 },
        { fieldName: 'rdtDrilledMetersPerYear', label: 'rdtDrilledMetersPerYear', initialWidth: 80 },
        { fieldName: 'rdtRatio', label: 'rdtRatio', initialWidth: 80 },
        { fieldName: 'rdtCostPerMeter', label: 'rdtCostPerMeter', initialWidth: 80 },
        { fieldName: 'rdtBrandOfConsumable', label: 'rdtBrandOfConsumable', initialWidth: 80 },
        { fieldName: 'rdtEnabled', label: 'rdtEnabled', initialWidth: 80 },
        { fieldName: 'runningCostPerHour', label: 'runningCostPerHour', initialWidth: 80 },
        { fieldName: 'localSerialNumber', label: 'localSerialNumber', initialWidth: 80 },
        { fieldName: 'localName', label: 'localName', initialWidth: 80 },
        { fieldName: 'stateOrRegion', label: 'stateOrRegion', initialWidth: 80 },
        { fieldName: 'town', label: 'town', initialWidth: 80 },
        { fieldName: 'responsible', label: 'responsible', initialWidth: 80 },
        { fieldName: 'dieselEngineHours', label: 'dieselEngineHours', initialWidth: 80 },
        { fieldName: 'dieselEngineHoursUpdatedDate', label: 'dieselEngineHoursUpdatedDate', initialWidth: 80 },
        { fieldName: 'dieselEngineHoursReadDate', label: 'dieselEngineHoursReadDate', initialWidth: 80 },
        { fieldName: 'impactHours', label: 'impactHours', initialWidth: 80 },
        { fieldName: 'impactHoursUpdatedDate', label: 'impactHoursUpdatedDate', initialWidth: 80 },
        { fieldName: 'impactHoursReadDate', label: 'impactHoursReadDate', initialWidth: 80 },
        { fieldName: 'subequipmentSerialNumber1', label: 'subequipmentSerialNumber1', initialWidth: 80 },
        { fieldName: 'subequipmentComponentType1', label: 'subequipmentComponentType1', initialWidth: 80 },
        { fieldName: 'subequipmentBrand1', label: 'subequipmentBrand1', initialWidth: 80 },
        { fieldName: 'subequipmentSerialNumber2', label: 'subequipmentSerialNumber2', initialWidth: 80 },
        { fieldName: 'subequipmentComponentType2', label: 'subequipmentComponentType2', initialWidth: 80 },
        { fieldName: 'subequipmentBrand2', label: 'subequipmentBrand2', initialWidth: 80 },
        { fieldName: 'subequipmentSerialNumber3', label: 'subequipmentSerialNumber3', initialWidth: 80 },
        { fieldName: 'subequipmentComponentType3', label: 'subequipmentComponentType3', initialWidth: 80 },
        { fieldName: 'subequipmentBrand3', label: 'subequipmentBrand3', initialWidth: 80 },
        { fieldName: 'subequipmentSerialNumber4', label: 'subequipmentSerialNumber4', initialWidth: 80 },
        { fieldName: 'subequipmentComponentType4', label: 'subequipmentComponentType4', initialWidth: 80 },
        { fieldName: 'subequipmentBrand4', label: 'subequipmentBrand4', initialWidth: 80 }
        ];
        
   connectedCallback(){
    //Custno is integer in database. We need to treat it as a string due to some beginning with 0. Octal literals are not allowed.
    this.fetchForeignEquipmentData();
   }
    
   fetchForeignEquipmentData(){
    getItems({recordId: this.recordId})
    .then((result) => {
    this.activeSearch = false;
    console.log('FE status? '+result.status);
    if(result.status === 'error'){
        this.errorData = result.message;
        this.loadingWindowOpen = false;
        this.errorWindowOpen = true;
        //this.showErrorNotification(result.message, result.message);
    }
    else if(result.status ==='success'){
        let itemsParsed = JSON.parse(result.message);
        if(itemsParsed.total === 0){
            this.errData = 'No data to display';
            this.loadingWindowOpen = false;
            this.errorWindowOpen = true;
        } else {
            this.displayedData = itemsParsed.items.map((elem) => ({
                ...elem,
                ...{
                    'brandname': elem.brand?.name,
                    'machinetype': elem.machineType?.name,
                    'segment': elem.segment?.name,
                    
                    // and so on for other fields
                }
            }));
            this.loadingWindowOpen = false;
            this.mainWindowOpen = true;
        }
    }
    })
    .catch((error) => {
        console.log('FE CATCH!');
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