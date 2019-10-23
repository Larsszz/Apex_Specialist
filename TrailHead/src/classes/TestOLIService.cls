/**
 * Created by IlarionTokarskyi on 10/21/2019.
 */
@IsTest
public with sharing class TestOLIService {
    @TestSetup static void setup() {
        Id priceBookId = Test.getStandardPricebookId();
        Product2 prod = new Product2(
                Name = 'Product X',
                ProductCode = 'Pro-X',
                IsActive = true
        );
        insert prod;
        Product2 prod2 = new Product2(
                Name = 'Product Y',
                ProductCode = 'Pro-Y',
                IsActive = true
        );
        insert prod2;
        PricebookEntry pbEntry = new PricebookEntry(
                Pricebook2Id = priceBookId,
                Product2Id = prod.Id,
                UnitPrice = 100.00,
                IsActive = true
        );
        insert pbEntry;
        PricebookEntry pbEntry2 = new PricebookEntry(
                Pricebook2Id = priceBookId,
                Product2Id = prod2.Id,
                UnitPrice = 100.00,
                IsActive = true
        );
        insert pbEntry2;
        Account acc = new Account(Name = 'Test');
        insert acc;
        Opportunity opp = new Opportunity(
                Name = 'Test Opp',
                StageName = 'Closed Won',
                CloseDate = System.today() + 7,
                AccountId = acc.Id
        );
        insert opp;
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        for (Integer i = 0; i < 200; i++) {
            oliList.add(new OpportunityLineItem(
                    OpportunityId = opp.Id,
                    Quantity = 5,
                    PricebookEntryId = pbEntry.Id,
                    Product2Id = prod.Id,
                    TotalPrice = 5 * pbEntry.UnitPrice
            ));
        }
        insert oliList;
    }

    @IsTest static void testInsert() {
        Product2 prod = [SELECT Id,Name,ProductCode FROM Product2 LIMIT 1];
        PricebookEntry pbEntry = [SELECT Id, Product2Id, UnitPrice FROM PricebookEntry WHERE Product2Id = :prod.Id];
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        OpportunityLineItem oli = new OpportunityLineItem(
                OpportunityId = opp.Id,
                Quantity = 10,
                PricebookEntryId = pbEntry.Id,
                Product2Id = prod.Id,
                Product2 = prod,
                TotalPrice = 5 * pbEntry.UnitPrice
        );
        insert oli;
        OpportunityLineItem opportunityLineItem = [SELECT Id, CustomProduct__c FROM OpportunityLineItem WHERE Quantity = 10 LIMIT 1];
        System.assertEquals(prod.Id, opportunityLineItem.CustomProduct__c);
    }

    @IsTest static void testUpdate() {
        Product2 product2 = [SELECT Id FROM Product2 WHERE Name = 'Product Y'];
        List<OpportunityLineItem> listOli = [
                SELECT Id, CustomProduct__c, Product2Id
                FROM OpportunityLineItem
                WHERE Product2.Name = 'Product X'
        ];
        for (OpportunityLineItem oli : listOli) {
            oli.CustomProduct__c = product2.Id;

        }
        update listOli;
        List<OpportunityLineItem> updatedOli = [
                SELECT Id, CustomProduct__c, Product2Id
                FROM OpportunityLineItem
                WHERE CustomProduct__c = :product2.Id
        ];
        for (OpportunityLineItem oli: updatedOli) {
            System.assertEquals(product2.Id, oli.Product2Id);
        }
    }

}