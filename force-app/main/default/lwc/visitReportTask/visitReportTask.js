import { LightningElement, api, track } from 'lwc';
import getVistReportTasks from '@salesforce/apex/VisitReportTaskHandler.getVistReportTasks';
import updateTaskStatus from '@salesforce/apex/VisitReportTaskHandler.updateTaskStatus';

export default class VisitReportTask extends LightningElement {
    @api recordId;
    @api taskId;
    mainWindowOpen = true;
    @track preVisitsReports = [];
    activeSectionsMessage = '';

    get options() {
        return [
            { label: 'Not started', value: 'Not started' },
            { label: 'In progress', value: 'In progress' },
            { label: 'Waiting on Someone else', value: 'Waiting on Someone else' },
            { label: 'Deferred', value: 'Deferred' },
            { label: 'Completed', value: 'Completed' },
        ];
    }

    connectedCallback(){
        this.getPreVisitsReports();
    }

    handleToggleSection(event) {
        const openSections = event.detail.openSections;
        if(openSections.length === 0){
            this.activeSectionMessage = 'All sections are closed';
        } else {
            this.activeSectionMessage = 'Open sections: ' + openSections.join(', ');
        }
    }

    getPreVisitsReports(){
        getVistReportTasks({recordId: this.recordId})
        .then(result => {
            let reports = JSON.parse(result);
            console.log(reports, 'response');
            this.preVisitsReports = reports.map(report => ({
                ...report
            }));
            console.log(this.preVisitsReports, 'data');
        })
        .catch(error => {
            console.log('Error in catch');
            console.log(error.message);
        });
    }

    handleChange(event){
        let taskId = event.target.dataset.id;
        updateTaskStatus({taskId: taskId, status: event.detail.value})
        .then(response => {
            let currentTask = this.preVisitsReports.find(report => 
                report.tasks.find(task => task.id == taskId)).tasks.find(task => task.id == taskId);
            currentTask.status = response;
            console.log(currentTask);
            console.log(currentTask.status);
        })
        .catch(error => {console.log(error.message)});
        
        
        // let currentTask = currentReport.tasks.find(task => task.id === taskId).then(task => task.status = newStatus).catch(error => {console.log(error.message)});
        // console.log(currentTask);

        
    }

    updateTask(taskId, status){
        console.log('hit in update');
        let newStatus = updateTaskStatus({taskId: taskId, status: status});
        console.log(newStatus);
        // let currentReport = preVisitsReports.find(report => report.includes(taskId)).catch(error => {console.log(error.message)});
        // console.log(currentReport);
        // let currentTask = currentReport.tasks.find(task => task.id === taskId).then(task => task.status = newStatus).catch(error => {console.log(error.message)});
        // console.log(currentTask);

    }
}