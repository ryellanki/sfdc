trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

List<Task> newTaskList = new List<Task>();

for(Opportunity opp:Trigger.New)
{
  if(opp.StageName=='Closed Won')
  {
   newTaskList.add(new Task(subject='Follow Up Test Task',whatid=opp.id));
  }
}
if(newTaskList.size()>0)
insert newTaskList;

}