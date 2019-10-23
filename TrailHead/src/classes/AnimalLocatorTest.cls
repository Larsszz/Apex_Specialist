/**
 * Created by IlarionTokarskyi on 10/18/2019.
 */
@IsTest
public with sharing class AnimalLocatorTest {
    @isTest static  void AnimalLocatorMock1() {
        Test.SetMock(HttpCallOutMock.class, new AnimalLocatorMock());
        string result=AnimalLocator.getAnimalNameById(1);
        string expectedResult='chicken';
        System.assertEquals(result, expectedResult);
    }
}