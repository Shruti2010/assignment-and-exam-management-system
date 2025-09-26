trigger GradePushTrigger on Grade__c (after insert, after update) {
    List<Id> toEnqueue = new List<Id>();
    for (Grade__c g : Trigger.new) {
        // only enqueue if Marks_Obtained__c is not null
        if (g.Marks_Obtained__c != null) {
            toEnqueue.add(g.Id);
        }
    }
    for (Id gid : toEnqueue) {
        System.enqueueJob(new LmsPushJob(gid));
    }
}