@isTest
private class ReceivablesTest {
    @isTest static void testGetReceivables() {
        Account account = TestDataFactory.createSingelAccount();
        String mockResponseBody = setMockResponse();
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'success', mockResponseBody, null);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        CallbackWrapper actualValue = Receivables.getReceivables((String.valueOf(account.Id)));
        Test.stopTest();

        System.assertEquals(mockResponseBody, actualValue.message, 'expected and actual missmatch');
        System.assertEquals('success', actualValue.status, 'expected and actual missmatch');
    }

    private static String setMockResponse(){
        String mockResponse = '{'+
		'    "cRcustNo": "220005",'+
		'    "cRname": "THOROUGHTEC SIMULATION PTY COD",'+
		'    "cRaddr1": "24 SPRING GLOVE",'+
		'    "cRaddr2": "UMLANGA RIDGE",'+
		'    "cRaddr3": "DURBAN",'+
		'    "cRstate": "",'+
		'    "cRpostCode": "4319",'+
		'    "cRcountry": "ZA",'+
		'    "cRamountDue": -12610.72,'+
		'    "cRopenOrderAmt": 12443.38,'+
		'    "cRytdSalesAmt": 571121.23,'+
		'    "cRmtdSalesAmt": 164.20,'+
		'    "cRlastTransDate": 20221118,'+
		'    "cRreceivables": ['+
		'        {'+
		'            "cRHinvoiceNo": 150397,'+
		'            "cRHinvoiceAmount": -5438.79,'+
		'            "cRHdueAmount": -5438.79,'+
		'            "cRHcurrencyCode": "ZAR",'+
		'            "cRHorderTermsCode": "09",'+
		'            "cRHorderTermsDescription": "\"Cash Sale\"",'+
		'            "cRHinvoiceDate": 20221018,'+
		'            "cRHdueDate": 20221018,'+
		'            "cRHinvoiceType": "UNALLOCATED PAYMENT",'+
		'            "cRHdaysPastDue": 43,'+
		'            "cRHdivision": "N/A",'+
		'            "cRHsalesOrderNo": 0,'+
		'            "cRHcustomerPORef": "",'+
		'            "cRpayments": []'+
		'        },'+
		'        {'+
		'            "cRHinvoiceNo": 591740,'+
		'            "cRHinvoiceAmount": -7360.77,'+
		'            "cRHdueAmount": -7360.76,'+
		'            "cRHcurrencyCode": "ZAR",'+
		'            "cRHorderTermsCode": "09",'+
		'            "cRHorderTermsDescription": "\"Cash Sale\"",'+
		'            "cRHinvoiceDate": 20220704,'+
		'            "cRHdueDate": 20220709,'+
		'            "cRHinvoiceType": "CREDIT NOTE",'+
		'            "cRHdaysPastDue": 144,'+
		'            "cRHdivision": "MRS",'+
		'            "cRHsalesOrderNo": 12785,'+
		'            "cRHcustomerPORef": "PO610077",'+
		'            "cRpayments": ['+
		'                {'+
		'                    "cRPpaymentDate": 20220811,'+
		'                    "cRPpaymentAmount": 0.01'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "cRHinvoiceNo": 605801,'+
		'            "cRHinvoiceAmount": 188.83,'+
		'            "cRHdueAmount": 188.83,'+
		'            "cRHcurrencyCode": "ZAR",'+
		'            "cRHorderTermsCode": "09",'+
		'            "cRHorderTermsDescription": "\"Cash Sale\"",'+
		'            "cRHinvoiceDate": 20221118,'+
		'            "cRHdueDate": 20221123,'+
		'            "cRHinvoiceType": "INVOICE",'+
		'            "cRHdaysPastDue": 7,'+
		'            "cRHdivision": "MRS",'+
		'            "cRHsalesOrderNo": 159123,'+
		'            "cRHcustomerPORef": "PO612541",'+
		'            "cRpayments": []'+
		'        }'+
		'    ]'+
		'}';
        return mockResponse;
    }

}