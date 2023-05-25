/**
 * Created by Sirocco on 2022-11-29.
 */

import { LightningElement, track, api } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import RelatedListHelper from "./relatedListHelper";

export default class RelatedListComponent extends NavigationMixin(LightningElement) {
    @track state = {}
    @api sobjectApiName;
    @api relatedFieldApiName;
    @api numberOfRecords = 6;
    @api sortedBy;
    @api sortedDirection = "ASC";
    @api fields;
    @api columns;
    @api customActions = [];
    @api recordId;
    @api filterBy;
    @api fieldTypes;
    @api matchTo;
    @api renderComponent = false;
    @api wrapText;

    helper = new RelatedListHelper();

    get hasRecords() {
        return this.state.records != null && this.state.records.length;
    }

    connectedCallback() {
        this.init();
    }

    get showViewAll() {
        console.log('parentRelationshipApiName: ', this.state.parentRelationshipApiName);
        return this.state.parentRelationshipApiName != null;
    }
    async init() {
        this.state.showRelatedList = this.recordId != null;
        if (!this.renderComponent) {
            this.state.records = [];
            return;
        }

        this.state.fields = this.fields;
        this.state.relatedFieldApiName = this.relatedFieldApiName;
        this.state.recordId = this.recordId;
        this.state.numberOfRecords = this.numberOfRecords;
        this.state.sobjectApiName = this.sobjectApiName;
        this.state.sortedBy = this.sortedBy;
        this.state.filterBy = this.filterBy;
        this.state.sortedDirection= this.sortedDirection;
        this.state.matchTo = this.matchTo;
        const data = await this.helper.fetchData(this.state);
        console.log('SHOW Data: ', data);
        if(data == null ) {
            console.log('ERROR!');
            return;
        }
        this.state.records = data.records;
        this.state.iconName = data.iconName;
        this.state.sobjectLabel = data.sobjectLabel;
        this.state.sobjectLabelPlural = data.sobjectLabelPlural;
        this.state.title = data.title;
        this.state.parentRelationshipApiName = data.parentRelationshipApiName;
        this.state.fieldTypes = this.fieldTypes;
        this.state.wrapText = this.wrapText;
        if(this.state.records.length > 0) {
            this.state.columns = this.helper.createColumns(this.columns, this.fields, this.state);
            this.state.columns = this.helper.initColumnsWithActions(this.state.columns, this.customActions);
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        switch (actionName) {
            case "delete":
                this.handleDeleteRecord(row);
                break;
            case "edit":
                this.handleEditRecord(row);
                break;
            default:
        }
    }

    handleGotoRelatedList() {
        this[NavigationMixin.Navigate]({
            type: "standard__recordRelationshipPage",
            attributes: {
                recordId: this.recordId,
                relationshipApiName: this.state.parentRelationshipApiName,
                actionName: "view",
                objectApiName: this.sobjectApiName
            }
        });
    }

    handleCreateRecord() {
        const newEditPopup = this.template.querySelector("c-related-list-popup");
        newEditPopup.recordId = null;
        newEditPopup.recordName = null;
        newEditPopup.sobjectApiName = this.sobjectApiName;
        newEditPopup.sobjectLabel = this.state.sobjectLabel;
        newEditPopup.isDelete = false;
        newEditPopup.show();
    }

    handleEditRecord(row) {
        const newEditPopup = this.template.querySelector("c-related-list-popup");
        newEditPopup.recordId = row.Id;
        newEditPopup.recordName = row.Name;
        newEditPopup.sobjectApiName = this.sobjectApiName;
        newEditPopup.sobjectLabel = this.state.sobjectLabel;
        newEditPopup.isDelete = false;
        newEditPopup.show();
    }

    handleDeleteRecord(row) {
        const newEditPopup = this.template.querySelector("c-related-list-popup");
        newEditPopup.recordId = row.Id;
        newEditPopup.recordName = row.Name;
        newEditPopup.sobjectLabel = this.state.sobjectLabel;
        newEditPopup.sobjectApiName = this.sobjectApiName;
        newEditPopup.isDelete = true;
        newEditPopup.show();
    }

    handleRefreshData() {
        this.init();
    }
}