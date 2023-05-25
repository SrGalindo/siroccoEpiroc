/**
 * Created by Sirocco on 2023-02-02.
 */
@IsTest
public with sharing class QT_Controller_Test {

    @TestSetup
    public static void testSetup() {
        QuoteLineItem QL = TestDataFactory.createQuoteLineItem();
    }

    @IsTest
    public static void testGetQuoteLineItems() {
        QuoteLineItem QLI = [SELECT Id, LineNumber FROM QuoteLineItem LIMIT 1];
        Quote Q = [SELECT Id, Name FROM Quote LIMIT 1];
        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(Q);
        ApexPages.currentPage().getParameters().put('id', String.valueOf(Q.Id));
        QT_Controller qtController = new QT_Controller(sc);
        List<QuoteLineItem> QLIList = qtController.getQuoteLines();
        Test.stopTest();
        Assert.areEqual(QLI.Id, QLIList[0].Id);
        Assert.areEqual(QLI.LineNumber, QLIList[0].LineNumber);
    }

    @IsTest
    public static void testController() {
        Quote Q = [SELECT Id, Name FROM Quote LIMIT 1];
        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(Q);
        ApexPages.currentPage().getParameters().put('id', String.valueOf(Q.Id));
        QT_Controller qtController = new QT_Controller(sc);
        Test.stopTest();
        Assert.areEqual(Q.Id,qtController.quote.Id);
        Assert.areEqual(Q.Name,qtController.quote.Name);
    }

    @IsTest
    public static void testControllerIdNull() {
        Quote Q = [SELECT Id, Name FROM Quote LIMIT 1];
        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(Q);
        //ApexPages.currentPage().getParameters().put('id', String.valueOf(Q.Id));
        QT_Controller qtController = new QT_Controller(sc);
        Test.stopTest();
        Assert.areEqual(new Quote(),qtController.quote);
        Assert.areEqual(null, qtController.relatedQuote);
    }

}