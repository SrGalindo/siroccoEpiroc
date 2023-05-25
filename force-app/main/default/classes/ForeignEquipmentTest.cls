@isTest
private class ForeignEquipmentTest {
    @isTest static void testgetItems() {
        Account account = TestDataFactory.createSingelAccount();
        String mockResponseBody = setMockResponse();
        RestSingleRequestMock mockResponse = new RestSingleRequestMock(200, 'success', mockResponseBody, null);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        CallbackWrapper actualValue = ForeignEquipment.getItems(String.valueOf(account.Id));
        Test.stopTest();

        System.assertEquals(mockResponseBody, actualValue.message, 'expected and actual missmatch');
        System.assertEquals('success', actualValue.status, 'expected and actual missmatch');
    }

    private static String setMockResponse(){
        String mockResponse = '{'+
		'    "items": ['+
		'        {'+
		'            "id": "b270be36-162a-4399-1b7c-08dac262b441",'+
		'            "name": null,'+
		'            "serialNumber": "ZAM000076",'+
		'            "worksite": "Gigantic Mine",'+
		'            "operationalStatusCode": true,'+
		'            "manufacturingDate": "2002-01-01T01:00:00",'+
		'            "inputSource": "Foreign Equipment Import",'+
		'            "utilization": 0,'+
		'            "dateOfVisiting": "2019-06-24T02:00:00",'+
		'            "rdtDrilledMetersPerYear": null,'+
		'            "rdtRatio": false,'+
		'            "rdtCostPerMeter": null,'+
		'            "rdtBrandOfConsumable": "",'+
		'            "rdtEnabled": true,'+
		'            "runningCostPerHour": null,'+
		'            "model": "DH550",'+
		'            "localSerialNumber": "",'+
		'            "localName": "URE",'+
		'            "customerName": "THOROUGHTEC SIMULATION PTY COD",'+
		'            "customerNumber": "220005",'+
		'            "stateOrRegion": "",'+
		'            "town": "",'+
		'            "responsible": "Mrs Z",'+
		'            "dieselEngineHours": "",'+
		'            "dieselEngineHoursUpdatedDate": null,'+
		'            "dieselEngineHoursReadDate": null,'+
		'            "impactHours": "",'+
		'            "impactHoursUpdatedDate": null,'+
		'            "impactHoursReadDate": null,'+
		'            "subequipmentSerialNumber1": "",'+
		'            "subequipmentComponentType1": "NONE",'+
		'            "subequipmentBrand1": "",'+
		'            "subequipmentSerialNumber2": "",'+
		'            "subequipmentComponentType2": "",'+
		'            "subequipmentBrand2": "",'+
		'            "subequipmentSerialNumber3": "",'+
		'            "subequipmentComponentType3": "",'+
		'            "subequipmentBrand3": "",'+
		'            "subequipmentSerialNumber4": "",'+
		'            "subequipmentComponentType4": "",'+
		'            "subequipmentBrand4": "",'+
		'            "country": {'+
		'                "famCode": "ZAM",'+
		'                "name": "South Africa",'+
		'                "created": "2020-10-12T13:30:03.6596679",'+
		'                "createdBy": "FleetSync",'+
		'                "updated": "2022-04-27T18:48:49.6935558",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "0e74d65b-3d81-4c50-b006-08d86eb12acb"'+
		'            },'+
		'            "machineType": {'+
		'                "rdtEnabled": true,'+
		'                "name": "SURFACE DRILL RIGS DTH",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T09:04:43.3670589",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "9d736055-8c96-4f02-b386-d034e630b6e1"'+
		'            },'+
		'            "brand": {'+
		'                "name": "SANDVIK",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T06:13:35.8686724",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "778c5ff0-6f69-4c19-be30-2301203714e6"'+
		'            },'+
		'            "segment": {'+
		'                "name": "Underground Volume Mining",'+
		'                "created": "2020-07-28T17:44:49.7170296",'+
		'                "createdBy": "FleetSync",'+
		'                "updated": "2022-04-27T18:49:09.9958228",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "db90a832-5215-4788-72be-08d8331de243"'+
		'            },'+
		'            "rockCondition": null,'+
		'            "rdtProductLine": null,'+
		'            "commodity": null,'+
		'            "updated": "2022-11-14T09:45:40.6717431",'+
		'            "created": "2022-11-10T15:28:31.3579246",'+
		'            "updatedBy": "Mattias Eriksson",'+
		'            "createdBy": "Mattias Eriksson"'+
		'        },'+
		'        {'+
		'            "id": "77a0bcd6-8195-49d0-1b7d-08dac262b441",'+
		'            "name": null,'+
		'            "serialNumber": "ZAM000077",'+
		'            "worksite": "Medium Mine",'+
		'            "operationalStatusCode": true,'+
		'            "manufacturingDate": null,'+
		'            "inputSource": "Foreign Equipment Import",'+
		'            "utilization": 0,'+
		'            "dateOfVisiting": "2019-06-24T00:00:00",'+
		'            "rdtDrilledMetersPerYear": null,'+
		'            "rdtRatio": false,'+
		'            "rdtCostPerMeter": null,'+
		'            "rdtBrandOfConsumable": "",'+
		'            "rdtEnabled": true,'+
		'            "runningCostPerHour": null,'+
		'            "model": "DINO 500",'+
		'            "localSerialNumber": "",'+
		'            "localName": "SED",'+
		'            "customerName": "THOROUGHTEC SIMULATION PTY COD",'+
		'            "customerNumber": "220005",'+
		'            "stateOrRegion": "",'+
		'            "town": "",'+
		'            "responsible": "MRS Y",'+
		'            "dieselEngineHours": "",'+
		'            "dieselEngineHoursUpdatedDate": null,'+
		'            "dieselEngineHoursReadDate": null,'+
		'            "impactHours": "",'+
		'            "impactHoursUpdatedDate": null,'+
		'            "impactHoursReadDate": null,'+
		'            "subequipmentSerialNumber1": "",'+
		'            "subequipmentComponentType1": "HL 500",'+
		'            "subequipmentBrand1": "",'+
		'            "subequipmentSerialNumber2": "",'+
		'            "subequipmentComponentType2": "",'+
		'            "subequipmentBrand2": "",'+
		'            "subequipmentSerialNumber3": "",'+
		'            "subequipmentComponentType3": "",'+
		'            "subequipmentBrand3": "",'+
		'            "subequipmentSerialNumber4": "",'+
		'            "subequipmentComponentType4": "",'+
		'            "subequipmentBrand4": "",'+
		'            "country": {'+
		'                "famCode": "ZAM",'+
		'                "name": "South Africa",'+
		'                "created": "2020-10-12T13:30:03.6596679",'+
		'                "createdBy": "FleetSync",'+
		'                "updated": "2022-04-27T18:48:49.6935558",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "0e74d65b-3d81-4c50-b006-08d86eb12acb"'+
		'            },'+
		'            "machineType": {'+
		'                "rdtEnabled": true,'+
		'                "name": "SURFACE DRILL RIGS TOPHAMMER",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T09:04:44.3773167",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "9fb6aee3-50cb-439d-9bfb-1efd6f038d02"'+
		'            },'+
		'            "brand": {'+
		'                "name": "SANDVIK",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T06:13:35.8686724",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "778c5ff0-6f69-4c19-be30-2301203714e6"'+
		'            },'+
		'            "segment": {'+
		'                "name": "Quarrying Aggregate",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T09:04:55.9941762",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "e4fc0a40-a97b-43a8-9757-941e7c9610ab"'+
		'            },'+
		'            "rockCondition": null,'+
		'            "rdtProductLine": null,'+
		'            "commodity": null,'+
		'            "updated": "2022-11-10T15:28:31.3579246",'+
		'            "created": "2022-11-10T15:28:31.3579246",'+
		'            "updatedBy": "Mattias Eriksson",'+
		'            "createdBy": "Mattias Eriksson"'+
		'        },'+
		'        {'+
		'            "id": "cd6790de-d757-495a-1b7e-08dac262b441",'+
		'            "name": null,'+
		'            "serialNumber": "ZAM000078",'+
		'            "worksite": "Big Mine",'+
		'            "operationalStatusCode": true,'+
		'            "manufacturingDate": "2011-01-01T00:00:00",'+
		'            "inputSource": "Foreign Equipment Import",'+
		'            "utilization": 0,'+
		'            "dateOfVisiting": "2019-06-24T00:00:00",'+
		'            "rdtDrilledMetersPerYear": null,'+
		'            "rdtRatio": false,'+
		'            "rdtCostPerMeter": null,'+
		'            "rdtBrandOfConsumable": "",'+
		'            "rdtEnabled": false,'+
		'            "runningCostPerHour": null,'+
		'            "model": "HC 05 ND",'+
		'            "localSerialNumber": "",'+
		'            "localName": "HAT",'+
		'            "customerName": "THOROUGHTEC SIMULATION PTY COD",'+
		'            "customerNumber": "220005",'+
		'            "stateOrRegion": "",'+
		'            "town": "",'+
		'            "responsible": "Mr X",'+
		'            "dieselEngineHours": "",'+
		'            "dieselEngineHoursUpdatedDate": null,'+
		'            "dieselEngineHoursReadDate": null,'+
		'            "impactHours": "",'+
		'            "impactHoursUpdatedDate": null,'+
		'            "impactHoursReadDate": null,'+
		'            "subequipmentSerialNumber1": "",'+
		'            "subequipmentComponentType1": "",'+
		'            "subequipmentBrand1": "",'+
		'            "subequipmentSerialNumber2": "",'+
		'            "subequipmentComponentType2": "",'+
		'            "subequipmentBrand2": "",'+
		'            "subequipmentSerialNumber3": "",'+
		'            "subequipmentComponentType3": "",'+
		'            "subequipmentBrand3": "",'+
		'            "subequipmentSerialNumber4": "",'+
		'            "subequipmentComponentType4": "",'+
		'            "subequipmentBrand4": "",'+
		'            "country": {'+
		'                "famCode": "ZAM",'+
		'                "name": "South Africa",'+
		'                "created": "2020-10-12T13:30:03.6596679",'+
		'                "createdBy": "FleetSync",'+
		'                "updated": "2022-04-27T18:48:49.6935558",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "0e74d65b-3d81-4c50-b006-08d86eb12acb"'+
		'            },'+
		'            "machineType": {'+
		'                "rdtEnabled": false,'+
		'                "name": "RIG MOUNTED HYD ATT/COMBI CUTTERS",'+
		'                "created": "2021-04-27T14:24:32.219415",'+
		'                "createdBy": "Mattias Eriksson",'+
		'                "updated": "2021-06-22T09:04:34.6117137",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "875e4c72-1876-4656-c278-08d90981628a"'+
		'            },'+
		'            "brand": {'+
		'                "name": "TREVIBENNE",'+
		'                "created": "2021-06-03T07:57:10.43795",'+
		'                "createdBy": "Mattias Eriksson",'+
		'                "updated": "2022-04-27T18:48:21.9692934",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "ad952558-0f13-4d1e-90d1-08d92656db40"'+
		'            },'+
		'            "segment": {'+
		'                "name": "Surface Civil Engineering",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T09:04:57.4678843",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "31ed5483-e3bf-4661-ac87-5556ea2c8283"'+
		'            },'+
		'            "rockCondition": null,'+
		'            "rdtProductLine": null,'+
		'            "commodity": null,'+
		'            "updated": "2022-11-10T15:28:31.3579246",'+
		'            "created": "2022-11-10T15:28:31.3579246",'+
		'            "updatedBy": "Mattias Eriksson",'+
		'            "createdBy": "Mattias Eriksson"'+
		'        },'+
		'        {'+
		'            "id": "60d8ee1e-0689-48d1-1b7f-08dac262b441",'+
		'            "name": null,'+
		'            "serialNumber": "ZAM000079",'+
		'            "worksite": "Small Mine",'+
		'            "operationalStatusCode": true,'+
		'            "manufacturingDate": "2007-01-01T00:00:00",'+
		'            "inputSource": "Foreign Equipment Import",'+
		'            "utilization": 25,'+
		'            "dateOfVisiting": "2019-06-24T00:00:00",'+
		'            "rdtDrilledMetersPerYear": null,'+
		'            "rdtRatio": false,'+
		'            "rdtCostPerMeter": null,'+
		'            "rdtBrandOfConsumable": "",'+
		'            "rdtEnabled": true,'+
		'            "runningCostPerHour": null,'+
		'            "model": "RANGER 800",'+
		'            "localSerialNumber": "",'+
		'            "localName": "SED",'+
		'            "customerName": "THOROUGHTEC SIMULATION PTY COD",'+
		'            "customerNumber": "220005",'+
		'            "stateOrRegion": "",'+
		'            "town": "",'+
		'            "responsible": "MRS Y",'+
		'            "dieselEngineHours": "",'+
		'            "dieselEngineHoursUpdatedDate": null,'+
		'            "dieselEngineHoursReadDate": null,'+
		'            "impactHours": "",'+
		'            "impactHoursUpdatedDate": null,'+
		'            "impactHoursReadDate": null,'+
		'            "subequipmentSerialNumber1": "",'+
		'            "subequipmentComponentType1": "",'+
		'            "subequipmentBrand1": "",'+
		'            "subequipmentSerialNumber2": "",'+
		'            "subequipmentComponentType2": "",'+
		'            "subequipmentBrand2": "",'+
		'            "subequipmentSerialNumber3": "",'+
		'            "subequipmentComponentType3": "",'+
		'            "subequipmentBrand3": "",'+
		'            "subequipmentSerialNumber4": "",'+
		'            "subequipmentComponentType4": "",'+
		'            "subequipmentBrand4": "",'+
		'            "country": {'+
		'                "famCode": "ZAM",'+
		'                "name": "South Africa",'+
		'                "created": "2020-10-12T13:30:03.6596679",'+
		'                "createdBy": "FleetSync",'+
		'                "updated": "2022-04-27T18:48:49.6935558",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "0e74d65b-3d81-4c50-b006-08d86eb12acb"'+
		'            },'+
		'            "machineType": {'+
		'                "rdtEnabled": true,'+
		'                "name": "SURFACE DRILL RIGS TOPHAMMER",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T09:04:44.3773167",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "9fb6aee3-50cb-439d-9bfb-1efd6f038d02"'+
		'            },'+
		'            "brand": {'+
		'                "name": "SANDVIK",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T06:13:35.8686724",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "778c5ff0-6f69-4c19-be30-2301203714e6"'+
		'            },'+
		'            "segment": {'+
		'                "name": "Quarrying Aggregate",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T09:04:55.9941762",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "e4fc0a40-a97b-43a8-9757-941e7c9610ab"'+
		'            },'+
		'            "rockCondition": null,'+
		'            "rdtProductLine": null,'+
		'            "commodity": null,'+
		'            "updated": "2022-11-10T15:28:31.3579246",'+
		'            "created": "2022-11-10T15:28:31.3579246",'+
		'            "updatedBy": "Mattias Eriksson",'+
		'            "createdBy": "Mattias Eriksson"'+
		'        },'+
		'        {'+
		'            "id": "da913202-21d8-49cb-1b80-08dac262b441",'+
		'            "name": null,'+
		'            "serialNumber": "ZAM000080",'+
		'            "worksite": "Medium Mine",'+
		'            "operationalStatusCode": true,'+
		'            "manufacturingDate": "2005-01-01T00:00:00",'+
		'            "inputSource": "Foreign Equipment Import",'+
		'            "utilization": 0,'+
		'            "dateOfVisiting": "2019-06-24T00:00:00",'+
		'            "rdtDrilledMetersPerYear": null,'+
		'            "rdtRatio": false,'+
		'            "rdtCostPerMeter": null,'+
		'            "rdtBrandOfConsumable": "",'+
		'            "rdtEnabled": false,'+
		'            "runningCostPerHour": null,'+
		'            "model": "TORO 400�",'+
		'            "localSerialNumber": "",'+
		'            "localName": "URE",'+
		'            "customerName": "THOROUGHTEC SIMULATION PTY COD",'+
		'            "customerNumber": "220005",'+
		'            "stateOrRegion": "",'+
		'            "town": "",'+
		'            "responsible": "Mr X",'+
		'            "dieselEngineHours": "",'+
		'            "dieselEngineHoursUpdatedDate": null,'+
		'            "dieselEngineHoursReadDate": null,'+
		'            "impactHours": "",'+
		'            "impactHoursUpdatedDate": null,'+
		'            "impactHoursReadDate": null,'+
		'            "subequipmentSerialNumber1": "",'+
		'            "subequipmentComponentType1": "NONE",'+
		'            "subequipmentBrand1": "",'+
		'            "subequipmentSerialNumber2": "",'+
		'            "subequipmentComponentType2": "",'+
		'            "subequipmentBrand2": "",'+
		'            "subequipmentSerialNumber3": "",'+
		'            "subequipmentComponentType3": "",'+
		'            "subequipmentBrand3": "",'+
		'            "subequipmentSerialNumber4": "",'+
		'            "subequipmentComponentType4": "",'+
		'            "subequipmentBrand4": "",'+
		'            "country": {'+
		'                "famCode": "ZAM",'+
		'                "name": "South Africa",'+
		'                "created": "2020-10-12T13:30:03.6596679",'+
		'                "createdBy": "FleetSync",'+
		'                "updated": "2022-04-27T18:48:49.6935558",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "0e74d65b-3d81-4c50-b006-08d86eb12acb"'+
		'            },'+
		'            "machineType": {'+
		'                "rdtEnabled": false,'+
		'                "name": "UNDERGROUND LOADERS",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T09:04:46.5957831",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "33cbf2a6-77ac-4557-a73d-bf784be75ae8"'+
		'            },'+
		'            "brand": {'+
		'                "name": "SANDVIK",'+
		'                "created": "2020-04-17T23:10:30",'+
		'                "createdBy": "EF-Migrations",'+
		'                "updated": "2021-06-22T06:13:35.8686724",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "778c5ff0-6f69-4c19-be30-2301203714e6"'+
		'            },'+
		'            "segment": {'+
		'                "name": "Underground Volume Mining",'+
		'                "created": "2020-07-28T17:44:49.7170296",'+
		'                "createdBy": "FleetSync",'+
		'                "updated": "2022-04-27T18:49:09.9958228",'+
		'                "updatedBy": "Foreign Equipment App",'+
		'                "id": "db90a832-5215-4788-72be-08d8331de243"'+
		'            },'+
		'            "rockCondition": null,'+
		'            "rdtProductLine": null,'+
		'            "commodity": null,'+
		'            "updated": "2022-11-10T15:28:31.3579246",'+
		'            "created": "2022-11-10T15:28:31.3579246",'+
		'            "updatedBy": "Mattias Eriksson",'+
		'            "createdBy": "Mattias Eriksson"'+
		'        }'+
		'    ],'+
		'    "total": 5'+
		'}';
        return mockResponse;
    }

}