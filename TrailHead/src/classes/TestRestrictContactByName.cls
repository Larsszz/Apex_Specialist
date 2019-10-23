/**
 * Created by IlarionTokarskyi on 10/16/2019.
 */
@IsTest
public with sharing class TestRestrictContactByName {
    @IsTest
    static void testInsertContact() {
       Test.startTest();
        Contact contact = new Contact(LastName='INVALIDNAME');
        Database.SaveResult result = Database.insert(contact, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
                result.getErrors()[0].getMessage());
    }
}