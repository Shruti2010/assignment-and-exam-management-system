trigger GradeTrigger on Grade__c (after insert, after update, after delete) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) GradeTriggerHandler.afterChange(Trigger.new, null);
        if (Trigger.isUpdate) GradeTriggerHandler.afterChange(Trigger.new, Trigger.oldMap);
        if (Trigger.isDelete) GradeTriggerHandler.afterDelete(Trigger.old);
    }
}