@isTest
private class WarehouseCalloutServiceTest {
    @IsTest
    static void testWarehouseCalloutService() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
    }

    @IsTest
    static void testWarehouseschedule() {
        String testTime = '00 00 01 * * ?';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        String jobID = System.schedule('Test Job', testTime, new WarehouseSyncSchedule());
        Test.stopTest();
    }
}