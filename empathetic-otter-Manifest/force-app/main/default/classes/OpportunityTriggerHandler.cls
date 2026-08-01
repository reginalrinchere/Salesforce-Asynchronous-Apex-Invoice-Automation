public virtual class OpportunityTriggerHandler extends TriggerHandler {
public override void afterUpdate() {
OpportunityService.handleClosedWonOpps((List<Opportunity>) Trigger.new, (Map<Id, Opportunity>) Trigger.oldMap);
}
}