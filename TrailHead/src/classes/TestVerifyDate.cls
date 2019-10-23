/**
 * Created by IlarionTokarskyi on 10/16/2019.
 */
@IsTest
public with sharing class TestVerifyDate {
    @IsTest
    public static void testCheckDate20Days() {
        Date d1 = Date.newInstance(2019, 10, 10);
        Date d2 = Date.newInstance(2019,10,30);
        System.assertEquals(d2, VerifyDate.CheckDates(d1,d2));
    }

    @IsTest
    public static void testCheckDate40Days() {
        Date d1 = Date.newInstance(2019, 10, 10);
        Date d2 = Date.newInstance(2019,11,20);
        Date expectedDate = Date.newInstance(2019, 10, 31);
        System.assertEquals(expectedDate, VerifyDate.CheckDates(d1,d2));
    }

    @IsTest
    public static void testCheckDateDate2Less() {
        Date d1 = Date.newInstance(2019, 10, 10);
        Date d2 = Date.newInstance(2018,11,20);
        Date expectedDate = Date.newInstance(2019, 10, 31);
        System.assertEquals(expectedDate, VerifyDate.CheckDates(d1,d2));
    }
}