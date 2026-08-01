public class OpportunityBatchUpdate implements Database.Batchable<SObject> {
public Database.QueryLocator start(Database.BatchableContext bc) {
return Database.getQueryLocator([SELECT Id, Description FROM Opportunity WHERE IsClosed=TRUE]);
}
public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
for(Opportunity opp : scope) {
opp.Description ='Archived';
}
update scope;
}
public void finish(Database.BatchableContext bc) {
System.debug('Batch Complet');
}
}