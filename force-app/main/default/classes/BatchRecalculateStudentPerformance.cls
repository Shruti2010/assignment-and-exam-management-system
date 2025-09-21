global with sharing class BatchRecalculateStudentPerformance 
       implements Database.Batchable<sObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Fetch all students for processing
        return Database.getQueryLocator([SELECT Id FROM Student__c]);
    }

    global void execute(Database.BatchableContext bc, List<Student__c> scope) {
        Set<Id> studentIds = new Set<Id>();
        for (Student__c s : scope) {
            studentIds.add(s.Id);
        }

        if (studentIds.isEmpty()) return;

        // Aggregate average marks per student across their submissions
        List<AggregateResult> aggs = [
            SELECT Submission__r.Student__c studentId, 
                   AVG(Marks_Obtained__c) avgMarks
            FROM Grade__c
            WHERE Submission__r.Student__c IN :studentIds
            GROUP BY Submission__r.Student__c
        ];

        // Map of studentId → avgMarks
        Map<Id, Decimal> avgMap = new Map<Id, Decimal>();
        for (AggregateResult ar : aggs) {
            Id studId = (Id) ar.get('studentId');
            Decimal avg = (Decimal) ar.get('avgMarks');
            avgMap.put(studId, avg);
        }

        // Prepare updates
        List<Student__c> updates = new List<Student__c>();
        for (Student__c stud : scope) {
            Decimal avgVal = avgMap.containsKey(stud.Id) ? avgMap.get(stud.Id) : 0;
            updates.add(new Student__c(Id = stud.Id, Average_Marks__c = avgVal));
        }

        if (!updates.isEmpty()) {
            update updates;
        }
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('✅ BatchRecalculateStudentPerformance finished successfully.');
    }
}