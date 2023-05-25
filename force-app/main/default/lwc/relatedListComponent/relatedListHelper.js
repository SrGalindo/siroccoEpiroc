/**
 * Created by Sirocco on 2022-11-29.
 */
import initDataMethod from "@salesforce/apex/relatedListController.initData";

export default class relatedListHelper {

    fetchData(state) {
        let jsonData = Object.assign({}, state);
        jsonData.numberOfRecords = state.numberOfRecords + 1;
        jsonData = JSON.stringify(jsonData);
        return initDataMethod({ jsonData })
            .then(response => {
                console.log('JSON.response: ', JSON.parse(response));
                const data = JSON.parse(response);
                return this.processData(data, state);
            })
            .catch(error => {
                console.log('Error: ',error);
            });
    }

    processData(data, state){
        const records = data.records;
        this.generateLinks(records)
        if (records.length > state.numberOfRecords) {
            records.pop();
            data.title = `${data.sobjectLabelPlural} (${state.numberOfRecords}+)`;
        } else {
            data.title = `${data.sobjectLabelPlural} (${Math.min(state.numberOfRecords, records.length)})`;
        }
        return data;
    }


    initColumnsWithActions(columns, customActions) {
        if (!customActions.length) {
            customActions = [
                { label: 'Edit', name: 'edit' },
                { label: 'Delete', name: 'delete' }
            ];
        }
        return [...columns, { type: 'action', typeAttributes: { rowActions: customActions } }];
    }

    createColumns(columnsInput, fieldsInput, state) {
        let columns = columnsInput.split(',');
        let fields = fieldsInput.split(',');
        let fieldTypes = state.fieldTypes.split(',');
        console.log('columns: ', columns);
        console.log('fields: ', fields);
        if(state.records.length == 0) {
            let columnHeaders = [];
            for(let i = 0; i < columns.length; i++) {
               let column = {
                   label: columns[i],
                   fieldName: fields[i]
               };
               columnHeaders.push(column);
            }
            return columnHeaders;
        }
        const columnHeaders = [];
        for(let i = 0; i < columns.length;i++) {
            console.log('fields[i]: '+fields[i]);
            let fieldNameFlattened = fields[i].replaceAll('.', "_");
            console.log('fieldNameFlattened: ',fieldNameFlattened);
            let LinkName = fieldNameFlattened.slice(0, fields[i].lastIndexOf('.')+1) + 'LinkName';
            console.log('LinkName: ', LinkName);
            if(fieldTypes[i] == 'url') {
                let column =
                {
                    label: columns[i],
                    fieldName: LinkName,
                    type: 'url',
                    sortable: true,
                    typeAttributes: {
                        label: {
                            fieldName: fieldNameFlattened
                        },
                    target: '_top'
                    }
                };
                if(state.wrapText) {
                    column.wrapText = true;
                }
                console.log('column: ',column);
                columnHeaders.push(column);
            } else {
                let column = {
                    label: columns[i],
                    fieldName: fieldNameFlattened
                };
                if(fieldTypes[i] != null && fieldTypes[i] != 'text') {
                    column.type = fieldTypes[i];
                }
                if(state.wrapText) {
                    column.wrapText = true;
                }
                columnHeaders.push(column);
            }
        }
        console.log('ColumnHeaders: ', columnHeaders);
        return columnHeaders;
    }

    generateLinks(records) {
        records.forEach(record => {
            record.LinkName = '/' + record.Id;
            for (const propertyName in record) {
                const propertyValue = record[propertyName];
                if (typeof propertyValue === 'object') {
                    const newValue = propertyValue.Id ? ('/' + propertyValue.Id) : null;
                    this.flattenStructure(record, propertyName + '_', propertyValue);
                    if (newValue !== null) {
                        record[propertyName + '_LinkName'] = newValue;
                    }
                }
            }
        });

    }

    flattenStructure(topObject, prefix, toBeFlattened) {
        for (const propertyName in toBeFlattened) {
            const propertyValue = toBeFlattened[propertyName];
            if (typeof propertyValue === 'object') {
                this.flattenStructure(topObject, prefix + propertyName + '_', propertyValue);
                const newValue = propertyValue.Id ? ('/' + propertyValue.Id) : null;
                if(newValue !== null) {
                    topObject[prefix + propertyName + '_LinkName'] = newValue;
                }
            } else {
                topObject[prefix + propertyName] = propertyValue;
            }
        }
    }
}