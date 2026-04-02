trigger OpportunityTrigger on Opportunity (before update, before delete) {
    if(Trigger.isUpdate) {
        OpportunityHandler.checkOppAmount(Trigger.New);

        OpportunityHandler.setPrimaryContact(Trigger.New);
    }

    if(Trigger.isDelete) {
        OpportunityHandler.preventOppDelete(Trigger.Old);
    }
}