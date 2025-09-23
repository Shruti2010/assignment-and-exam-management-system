import { LightningElement, api, wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
import { refreshApex } from '@salesforce/apex';

export default class AssignmentSummary extends LightningElement {
    @api recordId; // Student Id
    assignments;
    error;
    wiredAssignmentsResult;

    // Listen for custom event 'submissionupdated' from child components
    connectedCallback() {
        this.template.addEventListener('submissionupdated', () => {
            this.handleSubmissionUpdated();
        });
    }

    @wire(getRelatedListRecords, {
        parentRecordId: '$recordId',
        relatedListId: 'Submissions__r', // API name of related list from Student__c
        fields: [
            'Submission__c.Assignment__r.Name',
            'Submission__c.Assignment__r.Due_Date__c',
            'Submission__c.Status__c'
        ]
    })
    wiredAssignments(result) {
        this.wiredAssignmentsResult = result;
        const { data, error } = result;
        if (data) {
            // Map submissions → assignments
            this.assignments = data.records.map(r => ({
                Id: r.fields.Assignment__c.value,
                Name: r.fields.Assignment__r.value.fields.Name.value,
                Due_Date__c: r.fields.Assignment__r.value.fields.Due_Date__c.value,
                Status__c: r.fields.Status__c.value
            }));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.assignments = undefined;
        }
    }

    handleSubmissionUpdated() {
        // Refresh the wired data to reflect new submissions
        return refreshApex(this.wiredAssignmentsResult);
    }
}