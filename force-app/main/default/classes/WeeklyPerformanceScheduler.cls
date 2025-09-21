global with sharing class WeeklyPerformanceScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new BatchRecalculateStudentPerformance(), 200);
    }
}