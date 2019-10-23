/**
 * Created by IlarionTokarskyi on 10/16/2019.
 */

public with sharing class AddPrimaryContact implements Queueable {
    Contact contact = new Contact();
    String state = '';

    public AddPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }

    public void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id, BillingState FROM Account WHERE BillingState = :state LIMIT 200];
        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts) {
            Contact buffer = contact.clone();
            buffer.Account = account;
            contacts.add(buffer);
        }
    }
}