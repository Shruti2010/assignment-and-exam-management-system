public with sharing class GradeTriggerHandler {

    // Insert & Update
    public static void afterChange(List<Grade__c> newList, Map<Id, Grade__c> oldMap) {
        Set<Id> submissionIds = new Set<Id>();
        for (Grade__c g : newList) {
            if (g.Assignment__c != null) submissionIds.add(g.Assignment__c); // we'll fix below
            if (g.Submission__c != null) submissionIds.add(g.Submission__c);
        }
        if (!submissionIds.isEmpty()) recalcAvgForSubmissions(submissionIds);
    }

    // Delete
    public static void afterDelete(List<Grade__c> deletedList) {
        Set<Id> submissionIds = new Set<Id>();
        for (Grade__c g : deletedList) {
            if (g.Submission__c != null) submissionIds.add(g.Submission__c);
        }
        if (!submissionIds.isEmpty()) recalcAvgForSubmissions(submissionIds);
    }

    // Recalculate averages
    private static void recalcAvgForSubmissions(Set<Id> submissionIds) {
        try {
            // Map Submission -> Student
            Map<Id, Submission__c> subMap = new Map<Id, Submission__c>(
                [SELECT Id, Student__c FROM Submission__c WHERE Id IN :submissionIds AND Student__c != null]
            );

            Set<Id> studentIds = new Set<Id>();
            for (Submission__c s : subMap.values()) studentIds.add(s.Student__c);

            if (studentIds.isEmpty()) return;

            // Aggregate grades per student
            List<AggregateResult> aggs = [
                SELECT Submission__r.Student__c studentId, AVG(Marks_Obtained__c) avgMarks
                FROM Grade__c
                WHERE Submission__r.Student__c IN :studentIds
                GROUP BY Submission__r.Student__c
            ];

            Map<Id, Decimal> avgMap = new Map<Id, Decimal>();
            for (AggregateResult ar : aggs) {
                Id studId = (Id) ar.get('studentId');
                Decimal avg = (Decimal) ar.get('avgMarks');
                avgMap.put(studId, avg);
            }

            // Update Student records
            List<Student__c> studentsToUpdate = new List<Student__c>();
            for (Id sid : studentIds) {
                Decimal avgVal = avgMap.containsKey(sid) ? avgMap.get(sid) : 0;
                studentsToUpdate.add(new Student__c(Id = sid, Average_Marks__c = avgVal));
            }

            if (!studentsToUpdate.isEmpty()) update studentsToUpdate;

        } catch (Exception ex) {
            ErrorLogger.log(ex, 'GradeTriggerHandler.recalcAvgForSubmissions', null);
            throw ex;
        }
    }
}