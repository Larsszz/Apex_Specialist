/**
 * Created by IlarionTokarskyi on 10/22/2019.
 */

trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, before update, before delete, after insert, after update, after delete) {
    if(Trigger.isBefore && Trigger.isInsert) {
        OpportunityLineItemHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate) {
        OpportunityLineItemHandler.afterUpdate(Trigger.oldMap, Trigger.newMap);
    }
}