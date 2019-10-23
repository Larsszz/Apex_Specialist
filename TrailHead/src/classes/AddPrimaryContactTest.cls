/**
 * Created by IlarionTokarskyi on 10/16/2019.
 */
@IsTest
public with sharing class AddPrimaryContactTest {
    @TestSetup
    static void setup(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(Name = 'Test'+i, BillingState = 'NY'));
            accounts.add(new Account(Name = 'Test'+i+100, BillingState = 'CA'));
        }
        insert accounts;
    }

    @IsTest
    static void testInsertAccounts() {
        AddPrimaryContact testing = new AddPrimaryContact(new Contact(LastName = 'Test'), 'CA');
        Test.startTest();
        System.enqueueJob(testing);
        Test.stopTest();
        
    }
}