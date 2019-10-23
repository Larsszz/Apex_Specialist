/**
 * Created by Xiaomi on 9/12/2019.
 */

({
    packItem: function (component, event, helper) {
        component.set("v.item.Packed__c", true);
        var button = event.getSource();
        button.setAttribute("disabled", true);
    }
});