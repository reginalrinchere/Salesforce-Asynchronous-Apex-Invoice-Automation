public class NightlyOpportunityCleanup implements Schedulable {
public void execute(SchedulableContext sc) {
Database.executeBatch(new OpportunityBatchUpdate(), 200);
}
}