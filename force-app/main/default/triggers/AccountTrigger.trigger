trigger AccountTrigger on Account (before insert, after insert) {
    if(Trigger.isBefore) {
        AccountHandler.updateAccountType(Trigger.New);
        AccountHandler.updateAccountBillingAddress(Trigger.New);
        AccountHandler.setAccountRating(Trigger.New);
    }

    if(Trigger.isAfter) {
        AccountHandler.createRelatedContact(Trigger.New);
    }
}