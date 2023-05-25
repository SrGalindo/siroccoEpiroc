@isTest
private class AccountIntegrationTest {
    @isTest static void testDoPost() {
		User adminIntegrationUser = TestDataFactory.createAdminTestUser();
		System.runAs(adminIntegrationUser) {
			List<Account> mockAccounts = TestDataFactory.createAccountsForAccountIntegration(1); 
			Test.startTest();
			RestRequest req = new RestRequest();
			req.requestBody = Blob.valueOf(setMockBlob()); 
			req.requestURI = '/services/apexrest/Account';    
			req.addHeader('Content-Type', 'application/json');
			RestResponse res = new RestResponse();
			RestContext.request = req;
			RestContext.response = res;
			String actualValue = AccountIntegration.doPost();
			Test.stopTest();
			String expectedValue = 'success';
			System.assertEquals(expectedValue, actualValue, 'expected and actual mismatch');
		}
    }

    private static String setMockBlob(){
        String jsonBlob = '['+
		'  {'+
		'    \"sourceSystem\": \"BPCS\",'+
		'    \"sourceTimestamp\": \"2022-11-08T12:32:55.887+00:00\",'+
		'    \"cMrecordID\": \"CM\",'+
		'    \"cMIbosEvent\": \"3\",'+
		'    \"cMfamCode\": \"ZAM\",'+
		'    \"cMcustNo\": 4830,'+
		'    \"cMname\": \"AFRISAM (SOUTH AFRICA) (PTY)\",'+
		'    \"cMaddr1\": \"LIMITED\",'+
		'    \"cMaddr2\": \"P.O. BOX 6367\",'+
		'    \"cMaddr3\": \"WELTEVREDEN PARK\",'+
		'    \"cMstate\": \" \",'+
		'    \"cMpostCode\": \"1715\",'+
		'    \"cMamountDue\": 0,'+
		'    \"cMcreditLimit\": 250000,'+
		'    \"cMcountry\": \"ZA\",'+
		'    \"cMcountryDesc\": \" \",'+
		'    \"cMtype\": \"5101\",'+
		'    \"cMtypeDesc\": \"Kuruman General Customer\",'+
		'    \"cMOpenOrderAmt\": 0,'+
		'    \"cMytdSalesAmt\": 0,'+
		'    \"cMmtdSalesAmt\": 0,'+
		'    \"cMlastYTDSalesAmt\": 0,'+
		'    \"cMytdCostSales\": 0,'+
		'    \"cMlastYTDCostSales\": 0,'+
		'    \"cMmtdCostSales\": 0,'+
		'    \"cMphoneNo\": \"011-670-5582\",'+
		'    \"cMsalesman\": 2216,'+
		'    \"cMsalesmanName\": \"SDE\",'+
		'    \"cMterms\": \"01\",'+
		'    \"cMtermsDesc\": \"30 Days\",'+
		'    \"cMlastTransDate\": \"2007-04-30\",'+
		'    \"cMdiscCode\": \"AS\",'+
		'    \"cMtaxCode\": \"CUST\",'+
		'    \"cMcommCode\": \"53\",'+
		'    \"cMshipTo\": 0,'+
		'    \"cMcostCtr\": \"0000\",'+
		'    \"cMcorpCust\": 4830,'+
		'    \"cMreg\": 0,'+
		'    \"cMshipVia\": 0,'+
		'    \"cMpayTypeCode\": \"C\",'+
		'    \"cMcontact\": \"DOLLY 011 670-5582\",'+
		'    \"cMwhs\": \"AA\",'+
		'    \"cMtaxID\": \"4730110089\",'+
		'    \"cMdateAcctOpen\": \"1990-12-04\",'+
		'    \"cmCurrency\": \"ZAR\",'+
		'    \"cMabc\": \" \",'+
		'    \"cMsic\": \"1541\",'+
		'    \"cMdunNo\": \" \",'+
		'    \"cMdunRank\": \" \",'+
		'    \"cMfiscalTaxID\": \" \",'+
		'    \"cMalphaLookup\": \"HOLCIM (AFRISAM)\",'+
		'    \"cMrouteCode\": \"1\",'+
		'    \"cMdocPrefix\": \"01\",'+
		'    \"cMprno\": \" \",'+
		'    \"cMtransCode\": \" \",'+
		'    \"cMstopFlag\": \" \",'+
		'    \"cMstopYTD\": 0,'+
		'    \"cMstopLYTD\": 0,'+
		'    \"cMintext\": \"E\",'+
		'    \"cMytdRcv\": 0,'+
		'    \"cMmtdRcv\": 0,'+
		'    \"cMlytdRcv\": 0,'+
		'    \"cMytdCostRcv\": 0,'+
		'    \"cMlytdCostRcv\": 0,'+
		'    \"cMmtdCostRcv\": 0,'+
		'    \"cMconsCode\": \"D\",'+
		'    \"cMFAMCountryCode\": \" \",'+
		'    \"cMInterCompanyFlag\": \"1\",'+
		'    \"cmConsDesc\": \"EPIROC SOUTH AFRICA (PTY) LTD\",'+
		'    \"cMlangCode\": \" \",'+
		'    \"cMpriceListCode\": \" \",'+
		'    \"cMfaxNo\": \" \",'+
		'    \"cMglblCustCode\": \" \",'+
		'    \"cMglblIndCode\": \"236210\",'+
		'    \"cMasapRepCode1\": \"CM\",'+
		'    \"cMasapRepCode2\": \" \",'+
		'    \"cMasapRepCode3\": \"FC\",'+
		'    \"cMdftNoDels\": 0,'+
		'    \"cMemail\": \" \",'+
		'    \"cMbrandCode\": \" \",'+
		'    \"cMspeedDelCode\": \" \",'+
		'    \"cMserviceSalesman\": 0,'+
		'    \"cMserviceSalesName\": \" \",'+
		'    \"cMnaicsCode\": \" \",'+
		'    \"cMshopOnline\": \"No\",'+
		'    \"cMcashCred\": \"CRED\",'+
		'    \"cMcustFam\": \" \",'+
		'    \"cMsalesforceID\": \"\",'+
		'    \"notes\": ['+
		'      {'+
		'        \"sNnoteSequence\": 1,'+
		'        \"sNnoteText\": \"Hydraulic Attachment products and Rock Drilling\",'+
		'        \"interchangeID\": \"a95bc03d-5a6d-1a89-95bf-0004ac1cc4be-2\",'+
		'        \"sourceSystem\": \"BPCS\"'+
		'      }'+
		'    ],'+
		'    \"ship-tos\": ['+
		'      {'+
		'        \"sTrecordID\": \"ST\",'+
		'        \"sTcustNo\": 800385,'+
		'        \"sTshipToNo\": 1,'+
		'        \"sTname\": \"PETERSON TRACTOR CO.\",'+
		'        \"sTattn\": \" \",'+
		'        \"sTaddr1\": \"955 MARINA BLVD.\",'+
		'        \"sTaddr2\": \" \",'+
		'        \"sTaddr3\": \"SAN LEANDRO\",'+
		'        \"sTstate\": \"CA\",'+
		'        \"sTcountry\": \"US\",'+
		'        \"sTpostCode\": \"94577\",'+
		'        \"sTphoneNo\": \"510-357-6200\",'+
		'        \"sTsalesman\": 9502,'+
		'        \"sTsalesmanName\": \"Dealer\",'+
		'        \"sTreg\": 300,'+
		'        \"sTcontact\": \" \",'+
		'        \"sTtaxCode\": \"EXEMP\",'+
		'        \"sTwhs\": \" \",'+
		'        \"sTrouteCode\": \" \",'+
		'        \"sTconsCode\": \"A\",'+
		'        \"sTConsDesc\": \"Dropshipment - Direct To Customer\",'+
		'        \"sTdestAreaCode\": \" \",'+
		'        \"sTemail\": \" \",'+
		'        \"sTfaxNo\": \" \",'+
		'        \"sTalphaLookup\": \" \",'+
		'        \"notes\": [],'+
		'        \"interchangeID\": \"a95bc03d-5a6d-1a89-95bf-0004ac1cc4be-2\",'+
		'        \"sourceSystem\": \"BPCS\"'+
		'      }'+
		'    ],'+
		'    \"interchangeID\": \"a95bc03d-5a6d-1a89-95bf-0004ac1cc4be-2\"'+
		'  }'+
		']';
        return jsonBlob;
    }
}