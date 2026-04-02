public with sharing class AccountHandler {
    public static void updateAccountType(List<Account> newAccounts) {
        for(Account a : newAccounts) {
            if(a.Type == null) {
                a.Type = 'Prospect';
            }
        }
    }

    public static void updateAccountBillingAddress(List<Account> newAccounts) {
        for(Account a : newAccounts) {
            if(a.ShippingStreet != null && a.ShippingCity != null && a.ShippingState != null && a.ShippingPostalCode != null && a.ShippingCountry != null) {
            a.BillingStreet = a.ShippingStreet;
            a.BillingCity = a.ShippingCity;
            a.BillingState = a.ShippingState;
            a.BillingPostalCode = a.ShippingPostalCode;
            a.BillingCountry = a.ShippingCountry;
        }
        }
    }

    public static void setAccountRating(List<Account> newAccounts) {
        for(Account a : newAccounts) {
            if(a.Phone != null && a.Website != null && a.Fax != null) {
            a.Rating = 'Hot';
        }
        }
    }

    public static void createRelatedContact(List<Account> newAccounts) {
        List<Contact> newContacts = new List<Contact>();
        for(Account a : newAccounts) {
            Contact c = new Contact();
            c.AccountId = a.Id;
            c.LastName = 'DefaultContact';
            c.Email = 'default@email.com';
            newContacts.add(c);
        }
        insert newContacts;
    }
}