public with sharing class LmsPushJob implements Queueable, Database.AllowsCallouts {
    private Id gradeId;
    public LmsPushJob(Id gradeId) {
        this.gradeId = gradeId;
    }

    public void execute(QueueableContext ctx) {
        // Adjust fields to match your org
        Grade__c g = [SELECT Id, Marks_Obtained__c, Submission__r.Student__c FROM Grade__c WHERE Id = :gradeId LIMIT 1];

        Map<String, Object> payload = new Map<String, Object>{
            'studentId' => g.Submission__r.Student__c,
            'grade' => g.Marks_Obtained__c,
            'gradeId' => g.Id
        };
        String body = JSON.serialize(payload);

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:LMS_Named_Cred/grades'); // relative path
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setBody(body);

        String responseBody;
        Integer statusCode = 0;
        String errorMessage;

        try {
            Http http = new Http();
            HttpResponse res = http.send(req);
            responseBody = res.getBody();
            statusCode = res.getStatusCode();
        } catch (Exception e) {
            responseBody = null;
            errorMessage = e.getMessage();
        }

        // Write Integration Log
        Integration_Log__c log = new Integration_Log__c(
            Direction__c = 'Outbound',
            Endpoint__c = req.getEndpoint(),
            Request_Body__c = body,
            Response_Body__c = responseBody,
            Status__c = statusCode == 0 ? 'ERROR' : String.valueOf(statusCode),
            Error_Message__c = errorMessage,
            Related_Record__c = g.Id
        );
        insert log;
    }
}