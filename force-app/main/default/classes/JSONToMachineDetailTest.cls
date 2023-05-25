@IsTest
public class JSONToMachineDetailTest {
	
	// This test method should give 100% coverage
	@isTest static void testParse() {
		String json = '{'+
		'    \"getMachineByIdResponse\": {'+
		'        \"getMachineByIdResult\": {'+
		'            \"machine\": {'+
		'                \"id\": \"2f5094be-97b5-11e4-9784-005056920978\",'+
		'                \"brandName\": \"Atlas Copco\",'+
		'                \"businessLineFamCode\": \"SDE\",'+
		'                \"commissioningDate\": \"2015-05-27T22:00:00Z\",'+
		'                \"customerCenterFamCode\": \"ZAM\",'+
		'                \"divisionFamCode\": \"SDE\",'+
		'                \"localizedSerialNumber\": \"HR153\",'+
		'                \"machineCountryLocated\": \"ZA\",'+
		'                \"machineItemNumber\": \"8992302807\",'+
		'                \"manufacturingDate\": \"2015-01-07T23:00:00Z\",'+
		'                \"manufacturingFamCode\": \"JPS\",'+
		'                \"modelName\": \"PowerROC T45 -12\",'+
		'                \"productGroupCode\": \"17A\",'+
		'                \"productLine\": \"Surface Drill Rigs Top Hammer\",'+
		'                \"serialNumber\": \"JPS15SED1902\",'+
		'                \"shippingDate\": \"2015-01-28T04:29:44.737Z\",'+
		'                \"worksite\": \"LIQHOBONG - LESOTHO\",'+
		'                \"SubSystems\": ['+
		'                    {'+
		'                        \"id\": \"7c3df4ab-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Options\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4ac-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"Node 1（Length）:131786/Node 2（Angle 2 axis）:135350/Node 3（Sight）:134827/Node 4（Boom-Joint）:134762\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Angle Indicator\",'+
		'                                \"serialNumber\": \"135143\",'+
		'                                \"supplier\": \"Transtronic\",'+
		'                                \"type\": \"2653260410(3D)\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4ad-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Power Pack System\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4ae-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Compressor\",'+
		'                                \"serialNumber\": \"AIA8164072\",'+
		'                                \"supplier\": \"Atlas Copco\",'+
		'                                \"type\": \"2653294575\"'+
		'                            },'+
		'                            {'+
		'                                \"id\": \"7c3df4af-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"2653277273\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"2014-11-11T23:00:00Z\",'+
		'                                \"name\": \"Diesel Engine\",'+
		'                                \"serialNumber\": \"26870290\",'+
		'                                \"supplier\": \"Cummins\",'+
		'                                \"type\": \"QSC8.3C\"'+
		'                            },'+
		'                            {'+
		'                                \"id\": \"7c3df4b0-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Engine Oil\",'+
		'                                \"serialNumber\": \"NA\",'+
		'                                \"supplier\": \"Nippon Oil\",'+
		'                                \"type\": \"CH4-15W40\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4b1-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Cooling System\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4b2-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Oil Coolers\",'+
		'                                \"serialNumber\": \"1010 0097/2014/W32-01\",'+
		'                                \"supplier\": \"YMER\",'+
		'                                \"type\": \"2653267969\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4b3-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Cabin\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4b4-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Cabin / Cab\",'+
		'                                \"serialNumber\": \"YA327\",'+
		'                                \"supplier\": \"Yamaguchi Syatai\",'+
		'                                \"type\": \"2653224556\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4b5-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Drilling System\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4b6-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Rock Drill\",'+
		'                                \"serialNumber\": \"H158A00121\",'+
		'                                \"supplier\": \"Montabert\",'+
		'                                \"type\": \"HC158R\"'+
		'                            },'+
		'                            {'+
		'                                \"id\": \"7c3df4b7-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Feed Motor\",'+
		'                                \"serialNumber\": \"5043\",'+
		'                                \"supplier\": \"Atlas Copco\",'+
		'                                \"type\": \"2-160MT2S-E\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4b8-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Positioning System\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4b9-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Dump Base\",'+
		'                                \"serialNumber\": \"ES1404133\",'+
		'                                \"supplier\": \"Atlas Copco\",'+
		'                                \"type\": \"2653164620\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4ba-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Tramming System\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4bb-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Final Drive RH\",'+
		'                                \"serialNumber\": \"14C03623/ST1409012R\",'+
		'                                \"supplier\": \"Nabtesco\",'+
		'                                \"type\": \"2653289526\"'+
		'                            },'+
		'                            {'+
		'                                \"id\": \"7c3df4bc-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Final Drive LH\",'+
		'                                \"serialNumber\": \"14C03624/ST1409012L\",'+
		'                                \"supplier\": \"Nabtesco\",'+
		'                                \"type\": \"2653289526\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4bd-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Air System\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4be-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Vaposol Tank\",'+
		'                                \"serialNumber\": \"123722/0038\",'+
		'                                \"supplier\": \"EURE\",'+
		'                                \"type\": \"2653317434 (ASME/CE)\"'+
		'                            },'+
		'                            {'+
		'                                \"id\": \"7c3df4bf-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Air Receiver\",'+
		'                                \"serialNumber\": \"2489\",'+
		'                                \"supplier\": \"Atlas Copco\",'+
		'                                \"type\": \"1092061097(Other)\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4c0-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Hydraulic System\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4c1-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Hydraulic Oil\",'+
		'                                \"serialNumber\": \"NA\",'+
		'                                \"supplier\": \"Nippon Oil\",'+
		'                                \"type\": \"HYRANDO WIDE 46\"'+
		'                            },'+
		'                            {'+
		'                                \"id\": \"7c3df4c2-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Hydraulic Pump - PTO\",'+
		'                                \"serialNumber\": \"0414-0256\",'+
		'                                \"supplier\": \"Shimadzu\",'+
		'                                \"type\": \"SDB1818R895\"'+
		'                            },'+
		'                            {'+
		'                                \"id\": \"7c3df4c3-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Hydraulic Pump - Main\",'+
		'                                \"serialNumber\": \"V4Y-0001\",'+
		'                                \"supplier\": \"Shimadzu\",'+
		'                                \"type\": \"PHS3035-3035-2523AGL\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4c4-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"DCT System\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4c5-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Dust Collector\",'+
		'                                \"serialNumber\": \"148\",'+
		'                                \"supplier\": \"ERC\",'+
		'                                \"type\": \"SDC-1000C\"'+
		'                            }'+
		'                        ]'+
		'                    },'+
		'                    {'+
		'                        \"id\": \"7c3df4c6-97b5-11e4-9784-005056920978\",'+
		'                        \"name\": \"Adaption/Installation\",'+
		'                        \"SubComponents\": ['+
		'                            {'+
		'                                \"id\": \"7c3df4c7-97b5-11e4-9784-005056920978\",'+
		'                                \"atlasCopcoPartNumber\": \"\",'+
		'                                \"comment\": \"\",'+
		'                                \"manufacturingDate\": \"\",'+
		'                                \"name\": \"Option\",'+
		'                                \"serialNumber\": \"YES\",'+
		'                                \"supplier\": \"\",'+
		'                                \"type\": \"Environmental Declaration\"'+
		'                            }'+
		'                        ]'+
		'                    }'+
		'                ],'+
		'                \"customer\": {'+
		'                    \"id\": \"5438e41e-e2d5-4908-af10-b703ac5ac492\",'+
		'                    \"name\": \"BLASTING & EXCAVATING PTY LTD\",'+
		'                    \"number\": \"150347\"'+
		'                },'+
		'                \"machineFamilyName\": \"Powerroc\",'+
		'                \"externalCustomer\": {'+
		'                    \"id\": \"\",'+
		'                    \"name\": \"\"'+
		'                },'+
		'                \"serviceAgreement\": {'+
		'                    \"serviceAgreementNumber\": \"CV\",'+
		'                    \"serviceAgreementTypeID\": \"1085ebaa-97d7-e411-867c-001b21337959\",'+
		'                    \"serviceAgreementSubTypeID\": \"\",'+
		'                    \"serviceAgreementLastUpdated\": \"2020-09-10T13:10:46.093Z\"'+
		'                },'+
		'                \"registrationStatus\": 7,'+
		'                \"operationalStatus\": 1,'+
		'                \"brandID\": \"6ebbadeb-a9ca-4210-ae3e-e75e8eb1b4bd\",'+
		'                \"modelID\": \"4095d48d-fc52-11df-9d23-005056812a5f\",'+
		'                \"productLineID\": \"261436ad-58ea-11e3-aa7b-544c46e8800e\",'+
		'                \"machineFamilyID\": \"17df4319-7cbf-4d13-9e50-c11419c515e3\",'+
		'                \"digitalId\": \"\"'+
		'            }'+
		'        }'+
		'    }'+
		'}';
		JSONToMachineDetail r = JSONToMachineDetail.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSONToMachineDetail.SubSystems objSubSystems = new JSONToMachineDetail.SubSystems(System.JSON.createParser(json));
		System.assert(objSubSystems != null);
		System.assert(objSubSystems.id == null);
		System.assert(objSubSystems.name == null);
		System.assert(objSubSystems.SubComponents == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSONToMachineDetail.ServiceAgreement objServiceAgreement = new JSONToMachineDetail.ServiceAgreement(System.JSON.createParser(json));
		System.assert(objServiceAgreement != null);
		System.assert(objServiceAgreement.serviceAgreementNumber == null);
		System.assert(objServiceAgreement.serviceAgreementTypeID == null);
		System.assert(objServiceAgreement.serviceAgreementSubTypeID == null);
		System.assert(objServiceAgreement.serviceAgreementLastUpdated == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSONToMachineDetail.GetMachineByIdResult objGetMachineByIdResult = new JSONToMachineDetail.GetMachineByIdResult(System.JSON.createParser(json));
		System.assert(objGetMachineByIdResult != null);
		System.assert(objGetMachineByIdResult.machine == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSONToMachineDetail.ExternalCustomer objExternalCustomer = new JSONToMachineDetail.ExternalCustomer(System.JSON.createParser(json));
		System.assert(objExternalCustomer != null);
		System.assert(objExternalCustomer.id == null);
		System.assert(objExternalCustomer.name == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSONToMachineDetail.Customer objCustomer = new JSONToMachineDetail.Customer(System.JSON.createParser(json));
		System.assert(objCustomer != null);
		System.assert(objCustomer.id == null);
		System.assert(objCustomer.name == null);
		System.assert(objCustomer.number_Z == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSONToMachineDetail.SubComponents objSubComponents = new JSONToMachineDetail.SubComponents(System.JSON.createParser(json));
		System.assert(objSubComponents != null);
		System.assert(objSubComponents.id == null);
		System.assert(objSubComponents.atlasCopcoPartNumber == null);
		System.assert(objSubComponents.comment == null);
		System.assert(objSubComponents.manufacturingDate == null);
		System.assert(objSubComponents.name == null);
		System.assert(objSubComponents.serialNumber == null);
		System.assert(objSubComponents.supplier == null);
		System.assert(objSubComponents.type == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSONToMachineDetail.GetMachineByIdResponse objGetMachineByIdResponse = new JSONToMachineDetail.GetMachineByIdResponse(System.JSON.createParser(json));
		System.assert(objGetMachineByIdResponse != null);
		System.assert(objGetMachineByIdResponse.getMachineByIdResult == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSONToMachineDetail objJSONToMachineDetail = new JSONToMachineDetail(System.JSON.createParser(json));
		System.assert(objJSONToMachineDetail != null);
		System.assert(objJSONToMachineDetail.getMachineByIdResponse == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSONToMachineDetail.Machine objMachine = new JSONToMachineDetail.Machine(System.JSON.createParser(json));
		System.assert(objMachine != null);
		System.assert(objMachine.id == null);
		System.assert(objMachine.brandName == null);
		System.assert(objMachine.businessLineFamCode == null);
		System.assert(objMachine.commissioningDate == null);
		System.assert(objMachine.customerCenterFamCode == null);
		System.assert(objMachine.divisionFamCode == null);
		System.assert(objMachine.localizedSerialNumber == null);
		System.assert(objMachine.machineCountryLocated == null);
		System.assert(objMachine.machineItemNumber == null);
		System.assert(objMachine.manufacturingDate == null);
		System.assert(objMachine.manufacturingFamCode == null);
		System.assert(objMachine.modelName == null);
		System.assert(objMachine.productGroupCode == null);
		System.assert(objMachine.productLine == null);
		System.assert(objMachine.serialNumber == null);
		System.assert(objMachine.shippingDate == null);
		System.assert(objMachine.worksite == null);
		System.assert(objMachine.SubSystems == null);
		System.assert(objMachine.customer == null);
		System.assert(objMachine.machineFamilyName == null);
		System.assert(objMachine.externalCustomer == null);
		System.assert(objMachine.serviceAgreement == null);
		System.assert(objMachine.registrationStatus == null);
		System.assert(objMachine.operationalStatus == null);
		System.assert(objMachine.brandID == null);
		System.assert(objMachine.modelID == null);
		System.assert(objMachine.productLineID == null);
		System.assert(objMachine.machineFamilyID == null);
		System.assert(objMachine.digitalId == null);
	}
}