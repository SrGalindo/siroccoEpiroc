@IsTest
public class QuoteProductPickerTest {
    
    @testSetup
    public static void setup(){
       
        Opportunity opp = TestDataFactory.createOppWithAccountWithAddress('QuoteProductPickerTest, setup');
        
        Product2 product = new Product2();
        product.Name = 'Simple Item';
        product.IsActive = true;
        insert product;
        
        Pricebook2 book = new Pricebook2();
        book.Name = 'Test Price Book';
        book.isActive = true;
        insert book;
        
        PricebookEntry entry = new PricebookEntry();
        entry.Product2Id = product.Id;
        entry.Pricebook2Id = Test.getStandardPricebookId();
        entry.IsActive = true;
        entry.UnitPrice = 1000;
        entry.CurrencyIsoCode = 'EUR';
        insert entry;
        
        Quote newQuote = new Quote();
        newQuote.Name = 'Test Quote';
        newQuote.OpportunityId = opp.Id;
        newQuote.Pricebook2Id = Test.getStandardPricebookId();
        insert newQuote;
        
    } 
    
    // @isTest static void addProductToQuoteWithQuoteTest(){

    //     Quote quoteObj = [select Id from Quote  Limit 1]; 
        
    //     QuoteProductPicker.addProductToQuote(quoteObj.Id, 'Test', 1, '100');
    //     QuoteLineItem  QLItem = [select Id, QuoteId  from QuoteLineItem  Limit 1]; 
        
    //     Test.startTest();
    //     System.assertEquals(QLItem.QuoteId, quoteObj.Id);
    //     Test.stopTest();
    // }
    
    // @isTest static void addProductToQuoteWithOppTest(){

    //     Opportunity opp = [select Id from Opportunity Limit 1];  
        
    //     QuoteProductPicker.addProductToQuote(opp.Id, 'Test', 1, '100');
    //     OpportunityLineItem oppItem = [select Id,OpportunityId from OpportunityLineItem Limit 1];
        
    //     Test.startTest();
    //     System.assertEquals(opp.Id, oppItem.OpportunityId);
    //     Test.stopTest();
    // }

    @isTest static void testGetItem(){
        String famCode = 'PRX';
        String itemNumber = '1202586901';
        String mockResponseBody = mockItemResponse();
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'success', mockResponseBody, null);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        CallbackWrapper actualValue = QuoteProductPicker.getItem(famCode, itemNumber);
        Test.stopTest();

        System.assertEquals(mockResponseBody, actualValue.message, 'expected and actual missmatch');
        System.assertEquals('success', actualValue.status, 'expected and actual missmatch');
    }
    // @isTest static void testGetItem(){
    //     String famCode = 'ZAT';
    //     String itemNumber = 'smart';
    //     String currencyArg = 'SEK';
    //     Integer custNo = 220005;
    //     String mockResponseBody = mockItemResponse();
    //     RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'success', mockResponseBody, null);
    //     Test.startTest();
    //     Test.setMock(HttpCalloutMock.class, mockResponse);
    //     CallbackWrapper actualValue = QuoteProductPicker.getItem(famCode, itemNumber, currencyArg, custNo);
    //     Test.stopTest();

    //     System.assertEquals(mockResponseBody, actualValue.message, 'expected and actual missmatch');
    //     System.assertEquals('success', actualValue.status, 'expected and actual missmatch');
    // }
    
    @isTest static void testGetItemsWithDescription(){
        String famCode = 'ZAT';
        String itemDescription = 'smart';
        String itemNumber = null;
        String mockResponseBody = mockItemsResponse();
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'success', mockResponseBody, null);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        CallbackWrapper actualValue = QuoteProductPicker.getItems(famCode, itemDescription, itemNumber);
        Test.stopTest();

        System.assertEquals(mockResponseBody, actualValue.message, 'expected and actual missmatch');
        System.assertEquals('success', actualValue.status, 'expected and actual missmatch');
    }

    @isTest static void testGetItemsWithItemNumber(){
        String famCode = 'ZAT';
        String itemDescription = null;
        String itemNumber = 'smart';
        String mockResponseBody = mockItemsResponse();
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'success', mockResponseBody, null);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        CallbackWrapper actualValue = QuoteProductPicker.getItems(famCode, itemDescription, itemNumber);
        Test.stopTest();

        System.assertEquals(mockResponseBody, actualValue.message, 'expected and actual missmatch');
        System.assertEquals('success', actualValue.status, 'expected and actual missmatch');
    }

    @isTest static void testGetObjectDataWithOpp(){
        Test.startTest();
        Quote qt = TestDataFactory.createQuoteWithOppOld();
        CallbackWrapper actualValue = QuoteProductPicker.getObjectData(String.valueOf(qt.OpportunityId));
        Test.stopTest();
        System.assertEquals('success', actualValue.status, 'Expected and acutal mismatch');
        System.assert(actualValue.message != null, 'no value');

    }
    
    @isTest static void testGetObjectDataWithQuote(){
        Test.startTest();
        Quote qt = TestDataFactory.createQuoteWithOppOld();
        CallbackWrapper actualValue = QuoteProductPicker.getObjectData(String.valueOf(qt.Id));
        Test.stopTest();
        System.assertEquals('success', actualValue.status, 'Expected and acutal mismatch');
        System.assert(actualValue.message != null, 'no value');

    }

    private static String mockItemResponse(){
        String apiRespone = '{'+
		'    "itemNumber": "1202586901",'+
		'    "itemDescription": "THERMOSTAT",'+
		'    "extraItemDescription": "TILLV.BET. 1202586901",'+
		'    "unitOfMessure": "EA",'+
		'    "lastTransactionDate": 0,'+
		'    "listPrice": 241.040,'+
		'    "weight": 235.0,'+
		'    "productDivision": MRS'+
		'    "productLineCode": MRS'+
		'    "gac": SPCA'+
		'    "gacDescription": Commercial Parts Drill Rigs'+
		'    "pgc": SPCA'+
		'    "pgcDescription": Commercial Parts Drill Rigs'+
		'    "vendorNumber": 40358'+
		'    "vendorName": EPIROC ROCK DRILLS AB (BEC)'+
		'    "freeStockDetail": []'+
		'}';
        return apiRespone;
    }
    // private static String mockItemResponse(){
    //     String apiRespone = '{'+
	// 	'    "cPfamCode": "ZAT",'+
	// 	'    "cPcustNo": "220005",'+
	// 	'    "cPcurrency": "SEK",'+
	// 	'    "cPitemNumber": "smart",'+
	// 	'    "cPquantity": 0,'+
	// 	'    "cPnetPrice": 0.000,'+
	// 	'    "cPlistPrice": 0.000,'+
	// 	'    "cPdiscountPercent": 0.000'+
	// 	'}';
    //     return apiRespone;
    // }

    private static String mockItemsResponse(){
        String apiResonse = '{'+
		'    "items": ['+
		'        {'+
		'            "itemNumber": "8992008818",'+
		'            "itemDescription": "SMARTROC D65LF",'+
		'            "extraItemDescription": "AVO13A1358",'+
		'            "unitOfMessure": "EA",'+
		'            "lastTransactionDate": 20131009,'+
		'            "listPrice": 9500000.000,'+
		'            "weight": 0.0,'+
		'            "productDivision": "MR",'+
		'            "productLineCode": "SED",'+
		'            "gac": "113S",'+
		'            "gacDescription": "POWERROC DOWN THE HOLE",'+
		'            "pgc": "113S",'+
		'            "pgcDescription": "TH AND DTH HISTORY",'+
		'            "vendorNumber": 80143,'+
		'            "vendorName": "EPIROC ROCK DRILLS AB (DC)",'+
		'            "freeStock": 0.000'+
		'        },'+
		'        {'+
		'            "itemNumber": "8440309246",'+
		'            "itemDescription": "SMART DRIVE",'+
		'            "extraItemDescription": "",'+
		'            "unitOfMessure": "EA",'+
		'            "lastTransactionDate": 20210228,'+
		'            "listPrice": 14205.508,'+
		'            "weight": 160.0,'+
		'            "productDivision": "MR",'+
		'            "productLineCode": "MRS",'+
		'            "gac": "IPCA",'+
		'            "gacDescription": "Commercial Parts Infrastructur",'+
		'            "pgc": "IPCA",'+
		'            "pgcDescription": "Commercial Parts Infrastructur",'+
		'            "vendorNumber": 81003,'+
		'            "vendorName": "Epiroc Regional DC S.A",'+
		'            "freeStock": 0.000'+
		'        },'+
		'        {'+
		'            "itemNumber": "8992009702",'+
		'            "itemDescription": "SMARTROC D65-10LF NO 2046",'+
		'            "extraItemDescription": "TMG15SED0344",'+
		'            "unitOfMessure": "EA",'+
		'            "lastTransactionDate": 20151223,'+
		'            "listPrice": 11455882.350,'+
		'            "weight": 0.0,'+
		'            "productDivision": "MR",'+
		'            "productLineCode": "SED",'+
		'            "gac": "113S",'+
		'            "gacDescription": "POWERROC DOWN THE HOLE",'+
		'            "pgc": "113S",'+
		'            "pgcDescription": "TH AND DTH HISTORY",'+
		'            "vendorNumber": 80143,'+
		'            "vendorName": "EPIROC ROCK DRILLS AB (DC)",'+
		'            "freeStock": 0.000'+
		'        }'+
		'    ]'+
		'}';
        return apiResonse;
    }

}