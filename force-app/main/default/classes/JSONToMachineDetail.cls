public class JSONToMachineDetail {

	public class SubSystems {
		public String id {get;set;} 
		public String name {get;set;} 
		public List<SubComponents> SubComponents {get;set;} 

		public SubSystems(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'SubComponents') {
							SubComponents = arrayOfSubComponents(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'SubSystems consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ServiceAgreement {
		public String serviceAgreementNumber {get;set;} 
		public String serviceAgreementTypeID {get;set;} 
		public String serviceAgreementSubTypeID {get;set;} 
		public String serviceAgreementLastUpdated {get;set;} 

		public ServiceAgreement(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'serviceAgreementNumber') {
							serviceAgreementNumber = parser.getText();
						} else if (text == 'serviceAgreementTypeID') {
							serviceAgreementTypeID = parser.getText();
						} else if (text == 'serviceAgreementSubTypeID') {
							serviceAgreementSubTypeID = parser.getText();
						} else if (text == 'serviceAgreementLastUpdated') {
							serviceAgreementLastUpdated = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ServiceAgreement consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class GetMachineByIdResult {
		public Machine machine {get;set;} 

		public GetMachineByIdResult(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'machine') {
							machine = new Machine(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'GetMachineByIdResult consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ExternalCustomer {
		public String id {get;set;} 
		public String name {get;set;} 

		public ExternalCustomer(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ExternalCustomer consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Customer {
		public String id {get;set;} 
		public String name {get;set;} 
		public String number_Z {get;set;} // in json: number

		public Customer(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'number') {
							number_Z = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Customer consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class SubComponents {
		public String id {get;set;} 
		public String atlasCopcoPartNumber {get;set;} 
		public String comment {get;set;} 
		public String manufacturingDate {get;set;} 
		public String name {get;set;} 
		public String serialNumber {get;set;} 
		public String supplier {get;set;} 
		public String type {get;set;} 

		public SubComponents(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'atlasCopcoPartNumber') {
							atlasCopcoPartNumber = parser.getText();
						} else if (text == 'comment') {
							comment = parser.getText();
						} else if (text == 'manufacturingDate') {
							manufacturingDate = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'serialNumber') {
							serialNumber = parser.getText();
						} else if (text == 'supplier') {
							supplier = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'SubComponents consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class GetMachineByIdResponse {
		public GetMachineByIdResult getMachineByIdResult {get;set;} 

		public GetMachineByIdResponse(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'getMachineByIdResult') {
							getMachineByIdResult = new GetMachineByIdResult(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'GetMachineByIdResponse consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public GetMachineByIdResponse getMachineByIdResponse {get;set;} 

	public JSONToMachineDetail(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'getMachineByIdResponse') {
						getMachineByIdResponse = new GetMachineByIdResponse(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'JSONToMachineDetail consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Machine {
		public String id {get;set;} 
		public String brandName {get;set;} 
		public String businessLineFamCode {get;set;} 
		public String commissioningDate {get;set;} 
		public String customerCenterFamCode {get;set;} 
		public String divisionFamCode {get;set;} 
		public String localizedSerialNumber {get;set;} 
		public String machineCountryLocated {get;set;} 
		public String machineItemNumber {get;set;} 
		public String manufacturingDate {get;set;} 
		public String manufacturingFamCode {get;set;} 
		public String modelName {get;set;} 
		public String productGroupCode {get;set;} 
		public String productLine {get;set;} 
		public String serialNumber {get;set;} 
		public String shippingDate {get;set;} 
		public String worksite {get;set;} 
		public List<SubSystems> SubSystems {get;set;} 
		public Customer customer {get;set;} 
		public String machineFamilyName {get;set;} 
		public ExternalCustomer externalCustomer {get;set;} 
		public ServiceAgreement serviceAgreement {get;set;} 
		public Integer registrationStatus {get;set;} 
		public Integer operationalStatus {get;set;} 
		public String brandID {get;set;} 
		public String modelID {get;set;} 
		public String productLineID {get;set;} 
		public String machineFamilyID {get;set;} 
		public String digitalId {get;set;} 

		public Machine(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'brandName') {
							brandName = parser.getText();
						} else if (text == 'businessLineFamCode') {
							businessLineFamCode = parser.getText();
						} else if (text == 'commissioningDate') {
							commissioningDate = parser.getText();
						} else if (text == 'customerCenterFamCode') {
							customerCenterFamCode = parser.getText();
						} else if (text == 'divisionFamCode') {
							divisionFamCode = parser.getText();
						} else if (text == 'localizedSerialNumber') {
							localizedSerialNumber = parser.getText();
						} else if (text == 'machineCountryLocated') {
							machineCountryLocated = parser.getText();
						} else if (text == 'machineItemNumber') {
							machineItemNumber = parser.getText();
						} else if (text == 'manufacturingDate') {
							manufacturingDate = parser.getText();
						} else if (text == 'manufacturingFamCode') {
							manufacturingFamCode = parser.getText();
						} else if (text == 'modelName') {
							modelName = parser.getText();
						} else if (text == 'productGroupCode') {
							productGroupCode = parser.getText();
						} else if (text == 'productLine') {
							productLine = parser.getText();
						} else if (text == 'serialNumber') {
							serialNumber = parser.getText();
						} else if (text == 'shippingDate') {
							shippingDate = parser.getText();
						} else if (text == 'worksite') {
							worksite = parser.getText();
						} else if (text == 'SubSystems') {
							SubSystems = arrayOfSubSystems(parser);
						} else if (text == 'customer') {
							customer = new Customer(parser);
						} else if (text == 'machineFamilyName') {
							machineFamilyName = parser.getText();
						} else if (text == 'externalCustomer') {
							externalCustomer = new ExternalCustomer(parser);
						} else if (text == 'serviceAgreement') {
							serviceAgreement = new ServiceAgreement(parser);
						} else if (text == 'registrationStatus') {
							registrationStatus = parser.getIntegerValue();
						} else if (text == 'operationalStatus') {
							operationalStatus = parser.getIntegerValue();
						} else if (text == 'brandID') {
							brandID = parser.getText();
						} else if (text == 'modelID') {
							modelID = parser.getText();
						} else if (text == 'productLineID') {
							productLineID = parser.getText();
						} else if (text == 'machineFamilyID') {
							machineFamilyID = parser.getText();
						} else if (text == 'digitalId') {
							digitalId = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Machine consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}	
	
	public static JSONToMachineDetail parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSONToMachineDetail(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}

    private static List<SubComponents> arrayOfSubComponents(System.JSONParser p) {
        List<SubComponents> res = new List<SubComponents>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new SubComponents(p));
        }
        return res;
    }

    private static List<SubSystems> arrayOfSubSystems(System.JSONParser p) {
        List<SubSystems> res = new List<SubSystems>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new SubSystems(p));
        }
        return res;
    }
}