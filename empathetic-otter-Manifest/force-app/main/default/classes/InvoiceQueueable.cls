public class InvoiceQueueable implements Queueable, Database.AllowsCallouts {
private Set<Id> opportunityIds;
public InvoiceQueueable(Set<Id> oppIds) {
this.opportunityIds = oppIds;
}
public void execute(QueueableContext context) {
List<Opportunity> opportunities = [SELECT Id, Amount, Account.Name FROM Opportunity WHERE Id IN :opportunityIds AND IsClosed=TRUE];
for(Opportunity opp : opportunities) {
try {
HttpRequest req = new HttpRequest();
req.setEndpoint('callout:Stripe_Named_Credential/invoices');
req.setMethod('POST');
req.setHeader('Content-Type','application/json');
Map<String, Object> payload = new Map<String, Object>{
'opportunityId' => opp.Id,
'amount' => opp.Amount,
'accountName' => opp.Account.Name
};
req.setBody(JSON.serialize(payload));
Http http = new Http();
HttpResponse res = http.send(req);
if(res.getStatusCode() >= 300) {
IntegrationLogger.Log('Invoice Failed', res.getBody());
} else {
Invoice_Event__e event = new Invoice_Event__e(
Invoice_Id__c = opp.Id,
Amount__c = opp.Amount
);
EventBus.publish(event);
}
} catch(Exception e) {
IntegrationLogger.Log('Queueable Failure', e.getMessage());
}
}
}
}