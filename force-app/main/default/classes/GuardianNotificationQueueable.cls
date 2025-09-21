public with sharing class GuardianNotificationQueueable implements Queueable {
    private Set<Id> studentIds;

    public GuardianNotificationQueueable(Set<Id> studentIds) {
        this.studentIds = studentIds;
    }

    public void execute(QueueableContext ctx) {
        // Query Students with their linked Guardian and Guardian Email
        List<Student__c> studs = [
            SELECT Id, Name, Guardian__c, Guardian__r.Email__c
            FROM Student__c
            WHERE Id IN :studentIds AND Guardian__c != null
        ];

        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

        for (Student__c s : studs) {
            if (s.Guardian__r != null && String.isNotBlank(s.Guardian__r.Email__c)) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] { s.Guardian__r.Email__c });
                mail.setSubject('Notification: Update for ' + s.Name);
                mail.setPlainTextBody(
                    'Dear Guardian, a new update for ' + s.Name +
                    ' is available. Please login to check details.'
                );
                mails.add(mail);
            }
        }

        if (!mails.isEmpty()) {
            Messaging.sendEmail(mails);
        }
    }
}