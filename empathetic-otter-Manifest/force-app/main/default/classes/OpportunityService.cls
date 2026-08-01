public class OpportunityService {
public static void handleClosedWonOpps(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
Set<Id> wonOppIds = new Set<Id>();
for(Opportunity newOpp : newOpps) {
Opportunity oldOpp = oldOppsMap.get(newOpp.Id);
if(oldOpp == null) continue;
if(oldOpp.StageName !='Closed Won' && newOpp.StageName =='Closed Won') {
wonOppIds.add(newOpp.Id);
}
}
if(!wonOppIds.isEmpty()) {
System.enqueueJob(new InvoiceQueueable(wonOppIds));
}
}
}