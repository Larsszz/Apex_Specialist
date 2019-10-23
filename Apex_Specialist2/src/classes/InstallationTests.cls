/* 
 * This class can be safely deleted from your org. 
 * It was only used to ensure 100% test coverage
 * for the managed package installation.
 */

@IsTest
private class InstallationTests {
    @IsTest
    static void testMaintenanceRequest() {
        List<Case> newCases = new List<Case>();
        List<Case> newUpdatedCases = new List<Case>();
        Vehicle__c testVehicle = new Vehicle__c(Name = 'Test', Backup_Camera_Monitor__c = true, Model__c = 'Testing');
        insert testVehicle;
        Product2 testEquipment = new Product2(Name = 'Test', Cost__c = 1, Current_Inventory__c = 100,
                Replacement_Part__c = true, Warehouse_SKU__c = 'Test', Lifespan_Months__c = 12, Maintenance_Cycle__c = 20);
        insert testEquipment;
        for (Integer i = 0; i < 300; i++) {
            Case testCase = new Case(Subject = 'Test', Type = 'Repair', Status = 'New',
                    Equipment__c = testEquipment.Id, Vehicle__c = testVehicle.Id);
            newCases.add(testCase);
        }
        insert newCases;
        for (Case tempCase : newCases) {
            tempCase.Status = 'Closed';
            tempCase.Date_Due__c = System.today().addDays(Integer.valueOf(testEquipment.Maintenance_Cycle__c));
            newUpdatedCases.add(tempCase);
        }
        Test.startTest();
        Database.SaveResult[] updatedResults = Database.update(newUpdatedCases);
        Test.stopTest();
        for (Database.SaveResult saveResult: updatedResults) {
            System.assertEquals(true, saveResult.isSuccess());
        }
    }
}