@isTest
private class OrderControllerTest {
    @isTest static void testGetOrder() {
        Account account = TestDataFactory.createSingelAccount();
        String mockResponseBody = setMockResponseBody();
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'success', mockResponseBody, null);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        CallbackWrapper actualValue = OrderController.getOrders(String.valueOf(account.Id), 2);
        Test.stopTest();

        System.assertEquals(mockResponseBody, actualValue.message, 'expected and actual missmatch');
        System.assertEquals('success', actualValue.status, 'expected and actual missmatch');
    }

    private static String setMockResponseBody(){
        String mockRes = '{'+
		'    "oRcustNo": "220005",'+
		'    "oRnumberOrdersQuotes": 2,'+
		'    "oRname": "THOROUGHTEC SIMULATION PTY COD",'+
		'    "oRaddr1": "24 SPRING GLOVE",'+
		'    "oRaddr2": "UMLANGA RIDGE",'+
		'    "oRaddr3": "DURBAN",'+
		'    "oRstate": "",'+
		'    "oRpostCode": "4319",'+
		'    "oRcountry": "ZA",'+
		'    "oRamountDue": -12610.72,'+
		'    "oRopenOrderAmt": 12443.38,'+
		'    "oRytdSalesAmt": 571121.23,'+
		'    "oRmtdSalesAmt": 164.20,'+
		'    "oRlastTransDate": 20221118,'+
		'    "oRorders": ['+
		'        {'+
		'            "oRHorderNo": 159123,'+
		'            "oRHorderAmount": 2308.62,'+
		'            "oRHorderTaxAmount": 346.29,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "09",'+
		'            "oRHorderTermsDescription": "\"Cash Sale\"",'+
		'            "oRHcustPO": "PO612541",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221111,'+
		'            "oRHrequestedDate": 20221116,'+
		'            "oRHoriginalQuoteNo": 123457,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222989421",'+
		'                    "oRLitemDesc": "SYMBOL PLATE",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 1.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221129,'+
		'                    "oRLnetSellingPrice": 164.202,'+
		'                    "oRLlistPrice": 164.202,'+
		'                    "oRLorderLineEntryDate": 20221111,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": ""'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "3222334734",'+
		'                    "oRLitemDesc": "PUSH BUTTON",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221215,'+
		'                    "oRLnetSellingPrice": 2308.624,'+
		'                    "oRLlistPrice": 2308.624,'+
		'                    "oRLorderLineEntryDate": 20221111,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 156111,'+
		'            "oRHorderAmount": 8511.71,'+
		'            "oRHorderTaxAmount": 1276.76,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "09",'+
		'            "oRHorderTermsDescription": "\"Cash Sale\"",'+
		'            "oRHcustPO": "PO612200",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221003,'+
		'            "oRHrequestedDate": 20221116,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222334053",'+
		'                    "oRLitemDesc": "KNOB",'+
		'                    "oRLquantityOrdered": 4.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221216,'+
		'                    "oRLnetSellingPrice": 2127.928,'+
		'                    "oRLlistPrice": 2127.928,'+
		'                    "oRLorderLineEntryDate": 20221003,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        }'+
		'    ]'+
		'}';
        return mockRes;
    }

}