public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';

    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @Future(Callout = true)
    public static void runWarehouseEquipmentSync() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        //request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<Object> jsonResponse = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Product2> listToUpsert = new List<Product2>();
            for (Object ob : jsonResponse) {
                Map<String, Object> jsonMap = (Map<String, Object>) ob;
                Product2 product = new Product2();
                product.Replacement_Part__c = (Boolean) jsonMap.get('replacement');
                product.Name = (String) jsonMap.get('name');
                product.Maintenance_Cycle__c = (Integer) jsonMap.get('maintenanceperiod');
                product.Lifespan_Months__c = (Integer) jsonMap.get('lifespan');
                product.Cost__c = (Decimal) jsonMap.get('lifespan');
                product.Warehouse_SKU__c = (String) jsonMap.get('sku');
                product.Current_Inventory__c = (Double) jsonMap.get('quantity');
                listToUpsert.add(product);
            }

            if (listToUpsert.size() > 0) upsert listToUpsert;
        } else {
            System.debug('StatusCode is not 200');
            System.debug(response.getStatusCode());
        }

    }

}