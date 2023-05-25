@isTest
private class MolDataControllerTest {
    @isTest static void testApiCalloutForGetMachinesByCustomerNumber() {
        Test.startTest();
        String mockResponseBody = setResponseValueForMachines();
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'OK', mockResponseBody, null);
        Test.setMock(HttpCalloutMock.class, mockResponse);
        // Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String request = '{'+
		'    "getMachinesByCustomerNumber": {'+
		'        "customerNumber": "220005",'+
		'        "customerCenterFamCode": "ZAM"'+
		'    }'+
		'}';
        HttpResponse response = MolDataController.apiCallout(request, 'callout:azure_integration/mol/machine/proxy/v1/GetMachinesByCustomerNumber');
        Test.stopTest();
        System.assert(response != null, 'failed to get call out api');
        System.assert(response.getBody() != null, 'failed to get call out api');
        System.assertEquals(mockResponseBody, response.getBody(), 'response is not right');
        System.assertEquals(200, response.getStatusCode(), 'faild to get response from api call out');
    }

    @isTest static void testApiCalloutForGetMachinesDetails() {
        Test.startTest();
        String mockResponseBody = setReponseValueForMachineDetails();
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'OK', mockResponseBody, null);
        Test.setMock(HttpCalloutMock.class, mockResponse);

        String request = '{"getMachineById":{"machineId":"2f5094be-97b5-11e4-9784-005056920978"}}';
        HttpResponse response = MolDataController.apiCallout(request, 'callout:azure_integration/mol/machine/proxy/v1/GetMachineById');
        Test.stopTest();
        System.assert(response != null, 'failed to get call out api');
        System.assert(response.getBody() != null, 'failed to get call out api');
        System.assertEquals(mockResponseBody, response.getBody(), 'response is not right');
        System.assertEquals(200, response.getStatusCode(), 'faild to get response from api call out');
    }

    @isTest static void testGetMachinesByCustomerNumber(){
        Account account = TestDataFactory.createSingelAccount();
        String mockResponseBody = setResponseValueForMachines();
        String expectedResponse = '[{"divisionFamCode":"URE","serialNumber":"AVO08A457","modelName":"Boomer S1 L","machineItemNumber":"8991759600","id":"a22aadbb-7ea9-4743-be7f-0256a2c71d87"},{"divisionFamCode":"URE","serialNumber":"AVO08A555","modelName":"Boomer S1 L","machineItemNumber":"8991769800","id":"32032e8e-1c10-4c96-952d-d792ada62387"},{"divisionFamCode":"URE","serialNumber":"AVO10X334","modelName":"ST7LP","machineItemNumber":"8997269900","id":"bff79e99-0ecd-4a62-b0a9-14ab9f3b6a2b"}]';
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'OK', mockResponseBody, null);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        String request = '{'+
		'    "getMachinesByCustomerNumber": {'+
		'        "customerNumber": "220005",'+
		'        "customerCenterFamCode": "ZAM"'+
		'    }'+
		'}';
        HttpResponse response = MolDataController.apiCallout(request, 'callout:azure_integration/mol/machine/proxy/v1/GetMachinesByCustomerNumber');
        CallbackWrapper actualResponse = MolDataController.getMachinesByCustomerNumber(String.valueOf(account.Id));
        Test.stopTest();

        System.assertEquals(expectedResponse, actualResponse.message, 'The expected value is not right');
        System.assertEquals('success', actualResponse.status, 'The expected value is not right');
    }

    @isTest static void testGetMachineDetail(){
        Account account = TestDataFactory.createSingelAccount();
        String mockResponseBody = setReponseValueForMachineDetails();
        String expectedResponse = '[{"worksite":"LIQHOBONG - LESOTHO","serviceAgreement":"CV","serialNumber":"JPS15SED1902","registrationStatus":"Commissioned","productLine":"Surface Drill Rigs Top Hammer","modelName":"PowerROC T45 -12","hoursType":"Stay tuned","hours":"Stay tuned","commissioningDate":"2015-05-27T22:00:00Z","businessLineFamCode":"SDE"}]';
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'OK', mockResponseBody, null);
        List<String> machineIds = new List<String>{'2f5094be-97b5-11e4-9784-005056920978'};
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        String request = '{"getMachineById":{"machineId":"2f5094be-97b5-11e4-9784-005056920978"}}';
        HttpResponse response = MolDataController.apiCallout(request, 'callout:azure_integration/mol/machine/proxy/v1/GetMachineById');
        CallbackWrapper actualResponse = MolDataController.getMachineDetail(machineIds);
        Test.stopTest();

        System.assertEquals(expectedResponse, actualResponse.message, 'The expected value is not right');
        System.assertEquals('success', actualResponse.status, 'The expected value is not right');
    }

    private static String setResponseValueForMachines(){
        String mockResponseBody = '{'+
		'    "getMachinesByCustomerNumberResponse": {'+
		'        "getMachinesByCustomerNumberResult": {'+
		'            "totalCount": 4,'+
		'            "customerName": "THOROUGHTEC SIMULATION PTY COD",'+
		'            "customerCenterFamCode": "ZAM",'+
		'            "MachineItemNumbers": ['+
		'                {'+
		'                    "id": "a22aadbb-7ea9-4743-be7f-0256a2c71d87",'+
		'                    "machineItemNumber": "8991759600",'+
		'                    "modelName": "Boomer S1 L",'+
		'                    "serialNumber": "AVO08A457",'+
		'                    "divisionFamCode": "URE"'+
		'                },'+
		'                {'+
		'                    "id": "32032e8e-1c10-4c96-952d-d792ada62387",'+
		'                    "machineItemNumber": "8991769800",'+
		'                    "modelName": "Boomer S1 L",'+
		'                    "serialNumber": "AVO08A555",'+
		'                    "divisionFamCode": "URE"'+
		'                },'+
		'                {'+
		'                    "id": "bff79e99-0ecd-4a62-b0a9-14ab9f3b6a2b",'+
		'                    "machineItemNumber": "8997269900",'+
		'                    "modelName": "ST7LP",'+
		'                    "serialNumber": "AVO10X334",'+
		'                    "divisionFamCode": "URE"'+
		'                }'+
		'            ]'+
		'        }'+
		'    }'+
		'}';
        return mockResponseBody;
    }

    private static String setReponseValueForMachineDetails(){
        String mockResponseBody = '{'+
		'    "getMachineByIdResponse": {'+
		'        "getMachineByIdResult": {'+
		'            "machine": {'+
		'                "id": "2f5094be-97b5-11e4-9784-005056920978",'+
		'                "brandName": "Atlas Copco",'+
		'                "businessLineFamCode": "SDE",'+
		'                "commissioningDate": "2015-05-27T22:00:00Z",'+
		'                "customerCenterFamCode": "ZAM",'+
		'                "divisionFamCode": "SDE",'+
		'                "localizedSerialNumber": "HR153",'+
		'                "machineCountryLocated": "ZA",'+
		'                "machineItemNumber": "8992302807",'+
		'                "manufacturingDate": "2015-01-07T23:00:00Z",'+
		'                "manufacturingFamCode": "JPS",'+
		'                "modelName": "PowerROC T45 -12",'+
		'                "productGroupCode": "17A",'+
		'                "productLine": "Surface Drill Rigs Top Hammer",'+
		'                "serialNumber": "JPS15SED1902",'+
		'                "shippingDate": "2015-01-28T04:29:44.737Z",'+
		'                "worksite": "LIQHOBONG - LESOTHO",'+
		'                "SubSystems": ['+
		'                    {'+
		'                        "id": "7c3df4ab-97b5-11e4-9784-005056920978",'+
		'                        "name": "Options",'+
		'                        "SubComponents": ['+
		'                            {'+
		'                                "id": "7c3df4ac-97b5-11e4-9784-005056920978",'+
		'                                "atlasCopcoPartNumber": "",'+
		'                                "comment": "Node 1（Length）:131786/Node 2（Angle 2 axis）:135350/Node 3（Sight）:134827/Node 4（Boom-Joint）:134762",'+
		'                                "manufacturingDate": "",'+
		'                                "name": "Angle Indicator",'+
		'                                "serialNumber": "135143",'+
		'                                "supplier": "Transtronic",'+
		'                                "type": "2653260410(3D)"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        "id": "7c3df4ad-97b5-11e4-9784-005056920978",'+
		'                        "name": "Power Pack System",'+
		'                        "SubComponents": ['+
		'                            {'+
		'                                "id": "7c3df4b0-97b5-11e4-9784-005056920978",'+
		'                                "atlasCopcoPartNumber": "",'+
		'                                "comment": "",'+
		'                                "manufacturingDate": "",'+
		'                                "name": "Engine Oil",'+
		'                                "serialNumber": "NA",'+
		'                                "supplier": "Nippon Oil",'+
		'                                "type": "CH4-15W40"'+
		'                            }'+
		'                        ]'+
		'                    }'+
		'                ],'+
		'                "customer": {'+
		'                    "id": "5438e41e-e2d5-4908-af10-b703ac5ac492",'+
		'                    "name": "BLASTING & EXCAVATING PTY LTD",'+
		'                    "number": "150347"'+
		'                },'+
		'                "machineFamilyName": "Powerroc",'+
		'                "externalCustomer": {'+
		'                    "id": null,'+
		'                    "name": null'+
		'                },'+
		'                "serviceAgreement": {'+
		'                    "serviceAgreementNumber": "CV",'+
		'                    "serviceAgreementTypeID": "1085ebaa-97d7-e411-867c-001b21337959",'+
		'                    "serviceAgreementSubTypeID": "",'+
		'                    "serviceAgreementLastUpdated": "2020-09-10T13:10:46.093Z"'+
		'                },'+
		'                "registrationStatus": 7,'+
		'                "operationalStatus": 1,'+
		'                "brandID": "6ebbadeb-a9ca-4210-ae3e-e75e8eb1b4bd",'+
		'                "modelID": "4095d48d-fc52-11df-9d23-005056812a5f",'+
		'                "productLineID": "261436ad-58ea-11e3-aa7b-544c46e8800e",'+
		'                "machineFamilyID": "17df4319-7cbf-4d13-9e50-c11419c515e3",'+
		'                "digitalId": ""'+
		'            }'+
		'        }'+
		'    }'+
		'}';
        return mockResponseBody;
    }
}