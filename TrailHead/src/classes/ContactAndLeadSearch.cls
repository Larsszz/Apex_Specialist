/**
 * Created by IlarionTokarskyi on 10/16/2019.
 */

public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String incoming) {
        List<List<SObject>> searchList = [FIND :incoming IN ALL FIELDS
                RETURNING Contact(FirstName,LastName), Lead(FirstName,LastName)];
        System.debug(searchList.size());
        return searchList;
    }
}