@isTest
private class QuoteIntegrationTest {
    @isTest static void testgetQuotes() {
        Account account = TestDataFactory.createSingelAccount();
        String mockResponseBody = setMockResponseBody();
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'success', mockResponseBody, null);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        CallbackWrapper actualValue = QuoteIntegration.getQuotes(String.valueOf(account.Id));
        Test.stopTest();

        System.assertEquals(mockResponseBody, actualValue.message, 'expected and actual missmatch');
        System.assertEquals('success', actualValue.status, 'expected and actual missmatch');
    }

    private static String setMockResponseBody(){
        String mockRes = '{'+
		'    "oRcustNo": "150347",'+
		'    "oRnumberOrdersQuotes": 20,'+
		'    "oRname": "BLASTING & EXCAVATING PTY LTD",'+
		'    "oRaddr1": "P.O BOX 26889",'+
		'    "oRaddr2": "EAST RAND",'+
		'    "oRaddr3": "",'+
		'    "oRstate": "",'+
		'    "oRpostCode": "1462",'+
		'    "oRcountry": "ZA",'+
		'    "oRamountDue": 4005081.60,'+
		'    "oRopenOrderAmt": 1694834.36,'+
		'    "oRytdSalesAmt": 5848107.48,'+
		'    "oRmtdSalesAmt": 2128032.99,'+
		'    "oRlastTransDate": 20221118,'+
		'    "oRorders": ['+
		'        {'+
		'            "oRHorderNo": 370289,'+
		'            "oRHorderAmount": 31531.07,'+
		'            "oRHorderTaxAmount": 4729.66,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20220921,'+
		'            "oRHrequestedDate": 20470315,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "2650594779",'+
		'                    "oRLitemDesc": "ADAPTER,SLEEVE-SAE B",'+
		'                    "oRLquantityOrdered": 6.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20470315,'+
		'                    "oRLschedshipDate": 20470315,'+
		'                    "oRLnetSellingPrice": 5255.178,'+
		'                    "oRLlistPrice": 5839.087,'+
		'                    "oRLorderLineEntryDate": 20220921,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "BPPA",'+
		'                    "oRLPGC": "BPPA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373650,'+
		'            "oRHorderAmount": 82540.12,'+
		'            "oRHorderTaxAmount": 12381.02,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221117,'+
		'            "oRHrequestedDate": 20221117,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "2658466569",'+
		'                    "oRLitemDesc": "GUARD WINDOW",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221117,'+
		'                    "oRLschedshipDate": 20221117,'+
		'                    "oRLnetSellingPrice": 81087.373,'+
		'                    "oRLlistPrice": 90097.081,'+
		'                    "oRLorderLineEntryDate": 20221117,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "BPPA",'+
		'                    "oRLPGC": "BPPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "2695919197",'+
		'                    "oRLitemDesc": "CAPSCREW",'+
		'                    "oRLquantityOrdered": 5.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221117,'+
		'                    "oRLschedshipDate": 20221117,'+
		'                    "oRLnetSellingPrice": 23.103,'+
		'                    "oRLlistPrice": 25.670,'+
		'                    "oRLorderLineEntryDate": 20221117,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "BPPA",'+
		'                    "oRLPGC": "BPPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 3,'+
		'                    "oRLitemNo": "2695919254",'+
		'                    "oRLitemDesc": "CAPSCREW",'+
		'                    "oRLquantityOrdered": 13.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221117,'+
		'                    "oRLschedshipDate": 20221117,'+
		'                    "oRLnetSellingPrice": 27.881,'+
		'                    "oRLlistPrice": 30.979,'+
		'                    "oRLorderLineEntryDate": 20221117,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "BPPA",'+
		'                    "oRLPGC": "BPPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 4,'+
		'                    "oRLitemNo": "2695935037",'+
		'                    "oRLitemDesc": "WASHER",'+
		'                    "oRLquantityOrdered": 18.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221117,'+
		'                    "oRLschedshipDate": 20221117,'+
		'                    "oRLnetSellingPrice": 23.742,'+
		'                    "oRLlistPrice": 26.380,'+
		'                    "oRLorderLineEntryDate": 20221117,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "BPPA",'+
		'                    "oRLPGC": "BPPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 5,'+
		'                    "oRLitemNo": "2658600689",'+
		'                    "oRLitemDesc": "GASKET,RUBBE",'+
		'                    "oRLquantityOrdered": 18.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221117,'+
		'                    "oRLschedshipDate": 20221117,'+
		'                    "oRLnetSellingPrice": 30.412,'+
		'                    "oRLlistPrice": 33.791,'+
		'                    "oRLorderLineEntryDate": 20221117,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "BPCA",'+
		'                    "oRLPGC": "BPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373608,'+
		'            "oRHorderAmount": 1209.24,'+
		'            "oRHorderTaxAmount": 181.39,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221116,'+
		'            "oRHrequestedDate": 20221116,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "2250252800",'+
		'                    "oRLitemDesc": "PLUG",'+
		'                    "oRLquantityOrdered": 2.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221116,'+
		'                    "oRLnetSellingPrice": 503.032,'+
		'                    "oRLlistPrice": 558.924,'+
		'                    "oRLorderLineEntryDate": 20221116,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "0653122700",'+
		'                    "oRLitemDesc": "GASKET",'+
		'                    "oRLquantityOrdered": 2.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221116,'+
		'                    "oRLnetSellingPrice": 101.591,'+
		'                    "oRLlistPrice": 112.879,'+
		'                    "oRLorderLineEntryDate": 20221116,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "TPPA",'+
		'                    "oRLPGC": "TPPA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373603,'+
		'            "oRHorderAmount": 4865.68,'+
		'            "oRHorderTaxAmount": 729.85,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221116,'+
		'            "oRHrequestedDate": 20221116,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "4350261802",'+
		'                    "oRLitemDesc": "RADIAL LIP SEAL",'+
		'                    "oRLquantityOrdered": 6.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221116,'+
		'                    "oRLnetSellingPrice": 648.755,'+
		'                    "oRLlistPrice": 720.839,'+
		'                    "oRLorderLineEntryDate": 20221116,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "TPPA",'+
		'                    "oRLPGC": "TPPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "3222290119",'+
		'                    "oRLitemDesc": "COVER",'+
		'                    "oRLquantityOrdered": 3.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221116,'+
		'                    "oRLnetSellingPrice": 324.383,'+
		'                    "oRLlistPrice": 360.426,'+
		'                    "oRLorderLineEntryDate": 20221116,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373601,'+
		'            "oRHorderAmount": 12736.10,'+
		'            "oRHorderTaxAmount": 1910.42,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221116,'+
		'            "oRHrequestedDate": 20221116,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3216746600",'+
		'                    "oRLitemDesc": "#001 FLANGE BEARING",'+
		'                    "oRLquantityOrdered": 4.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221116,'+
		'                    "oRLnetSellingPrice": 3184.024,'+
		'                    "oRLlistPrice": 3537.804,'+
		'                    "oRLorderLineEntryDate": 20221116,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373599,'+
		'            "oRHorderAmount": 11942.94,'+
		'            "oRHorderTaxAmount": 1791.44,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221116,'+
		'            "oRHrequestedDate": 20221116,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222340046",'+
		'                    "oRLitemDesc": "BUSHING",'+
		'                    "oRLquantityOrdered": 4.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221116,'+
		'                    "oRLnetSellingPrice": 2985.736,'+
		'                    "oRLlistPrice": 3317.484,'+
		'                    "oRLorderLineEntryDate": 20221116,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373546,'+
		'            "oRHorderAmount": 1191.03,'+
		'            "oRHorderTaxAmount": 178.66,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221116,'+
		'            "oRHrequestedDate": 20221116,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "2651126027",'+
		'                    "oRLitemDesc": "MIRROR        GOP-1635",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221116,'+
		'                    "oRLnetSellingPrice": 1191.031,'+
		'                    "oRLlistPrice": 1323.368,'+
		'                    "oRLorderLineEntryDate": 20221116,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373542,'+
		'            "oRHorderAmount": 11936.33,'+
		'            "oRHorderTaxAmount": 1790.45,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221116,'+
		'            "oRHrequestedDate": 20221116,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222349872",'+
		'                    "oRLitemDesc": "TOUCHPANEL",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221116,'+
		'                    "oRLschedshipDate": 20221116,'+
		'                    "oRLnetSellingPrice": 11936.331,'+
		'                    "oRLlistPrice": 13262.590,'+
		'                    "oRLorderLineEntryDate": 20221116,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373385,'+
		'            "oRHorderAmount": 7685.15,'+
		'            "oRHorderTaxAmount": 1152.77,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221114,'+
		'            "oRHrequestedDate": 20221114,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "4350258213",'+
		'                    "oRLitemDesc": "PLUG",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221114,'+
		'                    "oRLschedshipDate": 20221114,'+
		'                    "oRLnetSellingPrice": 7588.403,'+
		'                    "oRLlistPrice": 8431.559,'+
		'                    "oRLorderLineEntryDate": 20221114,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "0661107000",'+
		'                    "oRLitemDesc": "SEAL WASHER",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221114,'+
		'                    "oRLschedshipDate": 20221114,'+
		'                    "oRLnetSellingPrice": 96.753,'+
		'                    "oRLlistPrice": 107.503,'+
		'                    "oRLorderLineEntryDate": 20221114,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "TPCA",'+
		'                    "oRLPGC": "TPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373369,'+
		'            "oRHorderAmount": 2985.74,'+
		'            "oRHorderTaxAmount": 447.86,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221114,'+
		'            "oRHrequestedDate": 20221114,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222340046",'+
		'                    "oRLitemDesc": "BUSHING",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221114,'+
		'                    "oRLschedshipDate": 20221114,'+
		'                    "oRLnetSellingPrice": 2985.736,'+
		'                    "oRLlistPrice": 3317.484,'+
		'                    "oRLorderLineEntryDate": 20221114,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373368,'+
		'            "oRHorderAmount": 2985.74,'+
		'            "oRHorderTaxAmount": 447.86,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221114,'+
		'            "oRHrequestedDate": 20221114,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222340046",'+
		'                    "oRLitemDesc": "BUSHING",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221114,'+
		'                    "oRLschedshipDate": 20221114,'+
		'                    "oRLnetSellingPrice": 2985.736,'+
		'                    "oRLlistPrice": 3317.484,'+
		'                    "oRLorderLineEntryDate": 20221114,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373329,'+
		'            "oRHorderAmount": 2985.74,'+
		'            "oRHorderTaxAmount": 447.86,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221111,'+
		'            "oRHrequestedDate": 20221111,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222340046",'+
		'                    "oRLitemDesc": "BUSHING",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221111,'+
		'                    "oRLschedshipDate": 20221111,'+
		'                    "oRLnetSellingPrice": 2985.736,'+
		'                    "oRLlistPrice": 3317.484,'+
		'                    "oRLorderLineEntryDate": 20221111,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373315,'+
		'            "oRHorderAmount": 36572.38,'+
		'            "oRHorderTaxAmount": 5485.86,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221111,'+
		'            "oRHrequestedDate": 20221111,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "4350265005",'+
		'                    "oRLitemDesc": "ADAPTER",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221111,'+
		'                    "oRLschedshipDate": 20221111,'+
		'                    "oRLnetSellingPrice": 36572.377,'+
		'                    "oRLlistPrice": 40635.974,'+
		'                    "oRLorderLineEntryDate": 20221111,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373295,'+
		'            "oRHorderAmount": 16830.19,'+
		'            "oRHorderTaxAmount": 2524.53,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221111,'+
		'            "oRHrequestedDate": 20221111,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222323153",'+
		'                    "oRLitemDesc": "ATTACHMENT",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221111,'+
		'                    "oRLschedshipDate": 20221111,'+
		'                    "oRLnetSellingPrice": 12507.375,'+
		'                    "oRLlistPrice": 13897.083,'+
		'                    "oRLorderLineEntryDate": 20221111,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "3222324924",'+
		'                    "oRLitemDesc": "RUBBER MOULDING",'+
		'                    "oRLquantityOrdered": 3.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221111,'+
		'                    "oRLschedshipDate": 20221111,'+
		'                    "oRLnetSellingPrice": 1440.938,'+
		'                    "oRLlistPrice": 1601.042,'+
		'                    "oRLorderLineEntryDate": 20221111,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373282,'+
		'            "oRHorderAmount": 531189.64,'+
		'            "oRHorderTaxAmount": 79678.45,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221110,'+
		'            "oRHrequestedDate": 20221110,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222330758",'+
		'                    "oRLitemDesc": "DISTANCE",'+
		'                    "oRLquantityOrdered": 2.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 12482.166,'+
		'                    "oRLlistPrice": 13869.073,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "3222309380",'+
		'                    "oRLitemDesc": "PRESS REGULATOR",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 22682.457,'+
		'                    "oRLlistPrice": 25202.730,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 3,'+
		'                    "oRLitemNo": "3222330180",'+
		'                    "oRLitemDesc": "WIDEN CONSOLE",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 222168.342,'+
		'                    "oRLlistPrice": 246853.713,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 4,'+
		'                    "oRLitemNo": "3222330183",'+
		'                    "oRLitemDesc": "WIDEN CONSOLE",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 261374.507,'+
		'                    "oRLlistPrice": 290416.119,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373256,'+
		'            "oRHorderAmount": 226328.05,'+
		'            "oRHorderTaxAmount": 33949.21,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221110,'+
		'            "oRHrequestedDate": 20221110,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222323635",'+
		'                    "oRLitemDesc": "DISTRIBUTION",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 35057.575,'+
		'                    "oRLlistPrice": 38952.861,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "3222323636",'+
		'                    "oRLitemDesc": "DISTRIBUTIONSET",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 35057.575,'+
		'                    "oRLlistPrice": 38952.861,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 3,'+
		'                    "oRLitemNo": "3222323637",'+
		'                    "oRLitemDesc": "CABLE",'+
		'                    "oRLquantityOrdered": 2.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 26302.749,'+
		'                    "oRLlistPrice": 29225.277,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 4,'+
		'                    "oRLitemNo": "3222323588",'+
		'                    "oRLitemDesc": "DISTRIBUTION SET",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 32890.204,'+
		'                    "oRLlistPrice": 36544.671,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 5,'+
		'                    "oRLitemNo": "3222323589",'+
		'                    "oRLitemDesc": "DISTRIBUTION",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 27669.491,'+
		'                    "oRLlistPrice": 30743.879,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 6,'+
		'                    "oRLitemNo": "3222323590",'+
		'                    "oRLitemDesc": "DISTRIBUTION",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 32668.065,'+
		'                    "oRLlistPrice": 36297.850,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 7,'+
		'                    "oRLitemNo": "3222314497",'+
		'                    "oRLitemDesc": "JOYSTICK",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221110,'+
		'                    "oRLschedshipDate": 20221110,'+
		'                    "oRLnetSellingPrice": 10379.625,'+
		'                    "oRLlistPrice": 11532.917,'+
		'                    "oRLorderLineEntryDate": 20221110,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373163,'+
		'            "oRHorderAmount": 45544.84,'+
		'            "oRHorderTaxAmount": 6831.73,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221109,'+
		'            "oRHrequestedDate": 20221109,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "2651522506",'+
		'                    "oRLitemDesc": "WHEEL,VANE",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221109,'+
		'                    "oRLschedshipDate": 20221109,'+
		'                    "oRLnetSellingPrice": 45544.837,'+
		'                    "oRLlistPrice": 50605.374,'+
		'                    "oRLorderLineEntryDate": 20221109,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373153,'+
		'            "oRHorderAmount": 215350.02,'+
		'            "oRHorderTaxAmount": 32302.50,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221109,'+
		'            "oRHrequestedDate": 20221109,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "3222341492",'+
		'                    "oRLitemDesc": "ROLLER CHAIN",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221109,'+
		'                    "oRLschedshipDate": 20221109,'+
		'                    "oRLnetSellingPrice": 47742.353,'+
		'                    "oRLlistPrice": 53047.059,'+
		'                    "oRLorderLineEntryDate": 20221109,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "3222330885",'+
		'                    "oRLitemDesc": "VIBR. DAMPER",'+
		'                    "oRLquantityOrdered": 4.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221109,'+
		'                    "oRLschedshipDate": 20221109,'+
		'                    "oRLnetSellingPrice": 1843.795,'+
		'                    "oRLlistPrice": 2048.661,'+
		'                    "oRLorderLineEntryDate": 20221109,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SPCA",'+
		'                    "oRLPGC": "SPCA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 3,'+
		'                    "oRLitemNo": "3222349129",'+
		'                    "oRLitemDesc": "EXHAUST SET",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221109,'+
		'                    "oRLschedshipDate": 20221109,'+
		'                    "oRLnetSellingPrice": 160232.490,'+
		'                    "oRLlistPrice": 178036.100,'+
		'                    "oRLorderLineEntryDate": 20221109,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "SOPA",'+
		'                    "oRLPGC": "SOPA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 373096,'+
		'            "oRHorderAmount": 8792.59,'+
		'            "oRHorderTaxAmount": 1318.89,'+
		'            "oRHcurrencyCode": "ZAR",'+
		'            "oRHorderTermsCode": "01",'+
		'            "oRHorderTermsDescription": "30 Days",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "MRS",'+
		'            "oRHstatus": "Entered",'+
		'            "oRHorderEntryDate": 20221108,'+
		'            "oRHrequestedDate": 20221108,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": ['+
		'                {'+
		'                    "oRLlineNo": 1,'+
		'                    "oRLitemNo": "2657694358",'+
		'                    "oRLitemDesc": "RUBBER,DOOR,NON-DRILL",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221108,'+
		'                    "oRLschedshipDate": 20221108,'+
		'                    "oRLnetSellingPrice": 4608.122,'+
		'                    "oRLlistPrice": 5120.135,'+
		'                    "oRLorderLineEntryDate": 20221108,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "BPPA",'+
		'                    "oRLPGC": "BPPA",'+
		'                    "oRLstatus": "Entered"'+
		'                },'+
		'                {'+
		'                    "oRLlineNo": 2,'+
		'                    "oRLitemNo": "2657694366",'+
		'                    "oRLitemDesc": "RUBBER,DOOR,DRILL SIDE",'+
		'                    "oRLquantityOrdered": 1.000,'+
		'                    "oRLquantityAllocated": 0.000,'+
		'                    "oRLquantityShipped": 0.000,'+
		'                    "oRLrequestedDate": 20221108,'+
		'                    "oRLschedshipDate": 20221108,'+
		'                    "oRLnetSellingPrice": 4184.474,'+
		'                    "oRLlistPrice": 4649.416,'+
		'                    "oRLorderLineEntryDate": 20221108,'+
		'                    "oRLdivision": "MRS",'+
		'                    "oRLGAC": "BPPA",'+
		'                    "oRLPGC": "BPPA",'+
		'                    "oRLstatus": "Entered"'+
		'                }'+
		'            ]'+
		'        },'+
		'        {'+
		'            "oRHorderNo": 0,'+
		'            "oRHorderAmount": 0.00,'+
		'            "oRHorderTaxAmount": 0.00,'+
		'            "oRHcurrencyCode": "",'+
		'            "oRHorderTermsCode": "",'+
		'            "oRHorderTermsDescription": "Maximum invoice",'+
		'            "oRHcustPO": "",'+
		'            "oRHdivision": "",'+
		'            "oRHstatus": "",'+
		'            "oRHorderEntryDate": 0,'+
		'            "oRHrequestedDate": 0,'+
		'            "oRHoriginalQuoteNo": 0,'+
		'            "oRHmachineItem": "",'+
		'            "oRHrepairItemType": "",'+
		'            "oRHserialNumber": "",'+
		'            "oRHorderNotes": [],'+
		'            "oRorderLines": []'+
		'        }'+
		'    ]'+
		'}';
        return mockRes;
    }
}