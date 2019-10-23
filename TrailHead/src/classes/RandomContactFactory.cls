/**
 * Created by IlarionTokarskyi on 10/16/2019.
 */

public with sharing class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String LastName) {
        List<Contact> result = new List<Contact>();
        for (Integer i = 0; i < numberOfContacts; i++) {
            result.add(new Contact(LastName=LastName, FirstName = 'Test ' + i));
        }
        return result;
    }
}