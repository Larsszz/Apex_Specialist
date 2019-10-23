/**
 * Created by IlarionTokarskyi on 10/21/2019.
 */

public with sharing class OpportunityLineItemService {
    public static Map<Id, OpportunityLineItem> checkProductUpdate(Map<Id, OpportunityLineItem> oldOli,
            Map<Id, OpportunityLineItem> newOli) {
        Map<Id, OpportunityLineItem> result = new Map<Id, OpportunityLineItem>();
        for(Id id: newOli.keySet()) {
            if (newOli.get(id).CustomProduct__c != oldOli.get(id).CustomProduct__c) {
                result.put(id, newOli.get(id));
            }
        }
        return result;

    }

    public static List<OpportunityLineItem> cloneOli(List<OpportunityLineItem> oldOli) {
        List<OpportunityLineItem> result = new List<OpportunityLineItem>();
        for (OpportunityLineItem opportunityLineItem: oldOli) {
            OpportunityLineItem buffer = new OpportunityLineItem(
                    CustomProduct__c = opportunityLineItem.CustomProduct__c,
                    Description = opportunityLineItem.Description,
                    Discount = opportunityLineItem.Discount,
                    OpportunityId = opportunityLineItem.OpportunityId,
                    Product2 = opportunityLineItem.CustomProduct__r,
                    Product2Id = opportunityLineItem.CustomProduct__c,
                    Quantity = opportunityLineItem.Quantity,
                    ServiceDate = opportunityLineItem.ServiceDate,
                    SortOrder = opportunityLineItem.SortOrder,
                    TotalPrice = opportunityLineItem.TotalPrice
            );

            result.add(buffer);
        }
        return result;
    }

    /*public static List<OpportunityLineItem> updateProduct(List<OpportunityLineItem> oliToUpdate) {
        for (OpportunityLineItem opportunityLineItem: oliToUpdate) {
            opportunityLineItem.Product2Id = opportunityLineItem.CustomProduct__c;
            opportunityLineItem.Product2 = opportunityLineItem.CustomProduct__r;
        }
        return oliToUpdate;
    }*/
}