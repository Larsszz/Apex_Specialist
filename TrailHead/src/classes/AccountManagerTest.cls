/**
 * Created by IlarionTokarskyi on 10/18/2019.
 */
@IsTest
public with sharing class AccountManagerTest {
    @IsTest
    static void testGetAccount() {
        Account objAccount = new Account(Name = 'test Account');
        insert objAccount;
        Contact objContact = new Contact(LastName = 'test Contact',
                AccountId = objAccount.Id);
        insert objContact;
        Id accId = objAccount.Id;
        RestRequest request = new RestRequest();
        request.requestURI =
                'https://curious-hawk-x03kbk-dev-ed.lightning.force.com/services/apexrest/Accounts/'
                        + accId +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();

        System.assert(thisAccount!= null);
        System.assertEquals('test Account', thisAccount.Name);
    }
}