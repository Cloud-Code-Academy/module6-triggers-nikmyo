public with sharing class OpportunityHandler {
    public static void checkOppAmount(List<Opportunity> newOpps) {
        for(Opportunity o : newOpps) {
            if(o.Amount <= 5000) {
                o.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    public static void setPrimaryContact(List<Opportunity> newOpps) {
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity o : newOpps) {
            accountIds.add(o.AccountId);
        }
        List<Account> accounts = [SELECT Id, (SELECT Id, Title FROM Contacts WHERE Title = 'CEO') FROM Account WHERE Id IN :accountIds];

        Map<Id,Id> accountIdsContactIds = new Map<Id,Id>();

        for(Account a : accounts) {
            if(!a.Contacts.isEmpty()) {
                accountIdsContactIds.put(a.Id, a.Contacts.get(0).Id);
            }
        }

       for(Opportunity o : newOpps) {
        if(accountIdsContactIds.containsKey(o.AccountId)) {
            o.Primary_Contact__c = accountIdsContactIds.get(o.AccountId);
        }
       }
    }

    public static void preventOppDelete(List<Opportunity> deletedOpps) {
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity o : deletedOpps) {
            if(o.StageName == 'Closed Won') {
                accountIds.add(o.AccountId);
            }
        }
        List<Account> accounts = [SELECT Id, Industry FROM Account WHERE Id IN :accountIds AND Industry = 'Banking'];
        Set<Id> bankingAccountIds = new Set<Id>();
        for(Account a : accounts) {
            bankingAccountIds.add(a.Id);
        }
        for(Opportunity o : deletedOpps) {
            if(bankingAccountIds.contains(o.AccountId)) {
                o.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }
}