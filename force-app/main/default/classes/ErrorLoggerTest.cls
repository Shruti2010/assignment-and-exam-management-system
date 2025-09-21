@isTest
private class ErrorLoggerTest {

    @isTest 
    static void testLogCreatesRecord() {
        Test.startTest();
        try {
            // Force an exception
            Integer i = 1 / 0; // This will throw a System.MathException
        } catch (Exception ex) {
            // Call your logger with the caught exception
            ErrorLogger.log(ex, 'UnitTestContext', null);
        }
        Test.stopTest();

        // Query the inserted error log
        List<Error_Log__c> logs = [
            SELECT Id, Context__c, Exception_Message__c
            FROM Error_Log__c
            WHERE Context__c = 'UnitTestContext'
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];

        // Validations
        System.assert(!logs.isEmpty(), 'Error log should have been created.');
        System.assertEquals('UnitTestContext', logs[0].Context__c);
        System.assert(logs[0].Exception_Message__c.contains('Divide by 0'), 
            'Exception message should mention divide by zero.');
    }
}