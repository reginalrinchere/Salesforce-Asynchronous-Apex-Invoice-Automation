public class IntegrationLogger {
public static void Log(String context, String errorMessage) {
insert new Integration_Log__c(
Context__c = context,
Error_Message__c = errorMessage,
Logged_At__c = System.now()
);
}
}
