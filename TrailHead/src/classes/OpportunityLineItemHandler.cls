/**
 * Created by IlarionTokarskyi on 10/22/2019.
 */

public with sharing class OpportunityLineItemHandler {
    public static void beforeInsert(List<OpportunityLineItem> oppLItems) {
        for (OpportunityLineItem opportunityLineItem : oppLItems) {
            if (opportunityLineItem.Product2Id != null) {
                opportunityLineItem.CustomProduct__c = opportunityLineItem.Product2Id;
                opportunityLineItem.CustomProduct__r = opportunityLineItem.Product2;
            }
        }
    }

    public static void afterUpdate(Map<Id, OpportunityLineItem> oldOli, Map<Id, OpportunityLineItem> newOli) {
        Map<Id, OpportunityLineItem> oliToUpdate = OpportunityLineItemService.checkProductUpdate(oldOli, newOli);
        if (oliToUpdate.isEmpty()) return;
        List<OpportunityLineItem> clonedOli = OpportunityLineItemService.cloneOli(oliToUpdate.values());
        delete [SELECT Id FROM OpportunityLineItem WHERE Id IN : oliToUpdate.values()];
        //clonedOli = OpportunityLineItemService.updateProduct(clonedOli);
        insert clonedOli;
    }
}