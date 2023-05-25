public with sharing class FieldMappingTables {
    public static String getThreeCharCountryCode(String countryCode) {
        String calcCode = '';
        switch on countryCode {
            when 'AL' { calcCode = 'ALB';}
            when 'DZ' { calcCode = 'DZA';}
            when 'AS' { calcCode = 'ASM';}
            when 'AD' { calcCode = 'AND';}
            when 'AF' { calcCode = 'AFG';}
            when 'AO' { calcCode = 'AGO';}
            when 'AI' { calcCode = 'AIA';}
            when 'AQ' { calcCode = 'ATA';}
            when 'AG' { calcCode = 'ATG';}
            when 'AR' { calcCode = 'ARG';}
            when 'AM' { calcCode = 'ARM';}
            when 'AW' { calcCode = 'ABW';}
            when 'AU' { calcCode = 'AUS';}
            when 'AT' { calcCode = 'AUT';}
            when 'AZ' { calcCode = 'AZE';}
            when 'BS' { calcCode = 'BHS';}
            when 'BH' { calcCode = 'BHR';}
            when 'BD' { calcCode = 'BGD';}
            when 'BB' { calcCode = 'BRB';}
            when 'BY' { calcCode = 'BLR';}
            when 'BE' { calcCode = 'BEL';}
            when 'BZ' { calcCode = 'BLZ';}
            when 'BJ' { calcCode = 'BEN';}
            when 'BM' { calcCode = 'BMU';}
            when 'BT' { calcCode = 'BTN';}
            when 'BO' { calcCode = 'BOL';}
            when 'BQ' { calcCode = 'BES';}
            when 'BA' { calcCode = 'BIH';}
            when 'BW' { calcCode = 'BWA';}
            when 'BV' { calcCode = 'BVT';}
            when 'BR' { calcCode = 'BRA';}
            when 'IO' { calcCode = 'IOT';}
            when 'BN' { calcCode = 'BRN';}
            when 'BG' { calcCode = 'BGR';}
            when 'BF' { calcCode = 'BFA';}
            when 'BI' { calcCode = 'BDI';}
            when 'CV' { calcCode = 'CPV';}
            when 'KH' { calcCode = 'KHM';}
            when 'CM' { calcCode = 'CMR';}
            when 'CA' { calcCode = 'CAN';}
            when 'KY' { calcCode = 'CYM';}
            when 'CF' { calcCode = 'CAF';}
            when 'TD' { calcCode = 'TCD';}
            when 'CL' { calcCode = 'CHL';}
            when 'CN' { calcCode = 'CHN';}
            when 'CX' { calcCode = 'CXR';}
            when 'CC' { calcCode = 'CCK';}
            when 'CO' { calcCode = 'COL';}
            when 'KM' { calcCode = 'COM';}
            when 'CD' { calcCode = 'COD';}
            when 'CG' { calcCode = 'COG';}
            when 'CK' { calcCode = 'COK';}
            when 'CR' { calcCode = 'CRI';}
            when 'HR' { calcCode = 'HRV';}
            when 'CU' { calcCode = 'CUB';}
            when 'CW' { calcCode = 'CUW';}
            when 'CY' { calcCode = 'CYP';}
            when 'CZ' { calcCode = 'CZE';}
            when 'CI' { calcCode = 'CIV';}
            when 'DK' { calcCode = 'DNK';}
            when 'DJ' { calcCode = 'DJI';}
            when 'DM' { calcCode = 'DMA';}
            when 'DO' { calcCode = 'DOM';}
            when 'EC' { calcCode = 'ECU';}
            when 'EG' { calcCode = 'EGY';}
            when 'SV' { calcCode = 'SLV';}
            when 'GQ' { calcCode = 'GNQ';}
            when 'ER' { calcCode = 'ERI';}
            when 'EE' { calcCode = 'EST';}
            when 'SZ' { calcCode = 'SWZ';}
            when 'ET' { calcCode = 'ETH';}
            when 'FK' { calcCode = 'FLK';}
            when 'FO' { calcCode = 'FRO';}
            when 'FJ' { calcCode = 'FJI';}
            when 'FI' { calcCode = 'FIN';}
            when 'FR' { calcCode = 'FRA';}
            when 'GF' { calcCode = 'GUF';}
            when 'PF' { calcCode = 'PYF';}
            when 'TF' { calcCode = 'ATF';}
            when 'GA' { calcCode = 'GAB';}
            when 'GM' { calcCode = 'GMB';}
            when 'GE' { calcCode = 'GEO';}
            when 'DE' { calcCode = 'DEU';}
            when 'GH' { calcCode = 'GHA';}
            when 'GI' { calcCode = 'GIB';}
            when 'GR' { calcCode = 'GRC';}
            when 'GL' { calcCode = 'GRL';}
            when 'GD' { calcCode = 'GRD';}
            when 'GP' { calcCode = 'GLP';}
            when 'GU' { calcCode = 'GUM';}
            when 'GT' { calcCode = 'GTM';}
            when 'GG' { calcCode = 'GGY';}
            when 'GN' { calcCode = 'GIN';}
            when 'GW' { calcCode = 'GNB';}
            when 'GY' { calcCode = 'GUY';}
            when 'HT' { calcCode = 'HTI';}
            when 'HM' { calcCode = 'HMD';}
            when 'VA' { calcCode = 'VAT';}
            when 'HN' { calcCode = 'HND';}
            when 'HK' { calcCode = 'HKG';}
            when 'HU' { calcCode = 'HUN';}
            when 'IS' { calcCode = 'ISL';}
            when 'IN' { calcCode = 'IND';}
            when 'ID' { calcCode = 'IDN';}
            when 'IR' { calcCode = 'IRN';}
            when 'IQ' { calcCode = 'IRQ';}
            when 'IE' { calcCode = 'IRL';}
            when 'IM' { calcCode = 'IMN';}
            when 'IL' { calcCode = 'ISR';}
            when 'IT' { calcCode = 'ITA';}
            when 'JM' { calcCode = 'JAM';}
            when 'JP' { calcCode = 'JPN';}
            when 'JE' { calcCode = 'JEY';}
            when 'JO' { calcCode = 'JOR';}
            when 'KZ' { calcCode = 'KAZ';}
            when 'KE' { calcCode = 'KEN';}
            when 'KI' { calcCode = 'KIR';}
            when 'KP' { calcCode = 'PRK';}
            when 'KR' { calcCode = 'KOR';}
            when 'KW' { calcCode = 'KWT';}
            when 'KG' { calcCode = 'KGZ';}
            when 'LA' { calcCode = 'LAO';}
            when 'LV' { calcCode = 'LVA';}
            when 'LB' { calcCode = 'LBN';}
            when 'LS' { calcCode = 'LSO';}
            when 'LR' { calcCode = 'LBR';}
            when 'LY' { calcCode = 'LBY';}
            when 'LI' { calcCode = 'LIE';}
            when 'LT' { calcCode = 'LTU';}
            when 'LU' { calcCode = 'LUX';}
            when 'MO' { calcCode = 'MAC';}
            when 'MG' { calcCode = 'MDG';}
            when 'MW' { calcCode = 'MWI';}
            when 'MY' { calcCode = 'MYS';}
            when 'MV' { calcCode = 'MDV';}
            when 'ML' { calcCode = 'MLI';}
            when 'MT' { calcCode = 'MLT';}
            when 'MH' { calcCode = 'MHL';}
            when 'MQ' { calcCode = 'MTQ';}
            when 'MR' { calcCode = 'MRT';}
            when 'MU' { calcCode = 'MUS';}
            when 'YT' { calcCode = 'MYT';}
            when 'MX' { calcCode = 'MEX';}
            when 'FM' { calcCode = 'FSM';}
            when 'MD' { calcCode = 'MDA';}
            when 'MC' { calcCode = 'MCO';}
            when 'MN' { calcCode = 'MNG';}
            when 'ME' { calcCode = 'MNE';}
            when 'MS' { calcCode = 'MSR';}
            when 'MA' { calcCode = 'MAR';}
            when 'MZ' { calcCode = 'MOZ';}
            when 'MM' { calcCode = 'MMR';}
            when 'NA' { calcCode = 'NAM';}
            when 'NR' { calcCode = 'NRU';}
            when 'NP' { calcCode = 'NPL';}
            when 'NL' { calcCode = 'NLD';}
            when 'NC' { calcCode = 'NCL';}
            when 'NZ' { calcCode = 'NZL';}
            when 'NI' { calcCode = 'NIC';}
            when 'NE' { calcCode = 'NER';}
            when 'NG' { calcCode = 'NGA';}
            when 'NU' { calcCode = 'NIU';}
            when 'NF' { calcCode = 'NFK';}
            when 'MP' { calcCode = 'MNP';}
            when 'NO' { calcCode = 'NOR';}
            when 'OM' { calcCode = 'OMN';}
            when 'PK' { calcCode = 'PAK';}
            when 'PW' { calcCode = 'PLW';}
            when 'PS' { calcCode = 'PSE';}
            when 'PA' { calcCode = 'PAN';}
            when 'PG' { calcCode = 'PNG';}
            when 'PY' { calcCode = 'PRY';}
            when 'PE' { calcCode = 'PER';}
            when 'PH' { calcCode = 'PHL';}
            when 'PN' { calcCode = 'PCN';}
            when 'PL' { calcCode = 'POL';}
            when 'PT' { calcCode = 'PRT';}
            when 'PR' { calcCode = 'PRI';}
            when 'QA' { calcCode = 'QAT';}
            when 'MK' { calcCode = 'MKD';}
            when 'RO' { calcCode = 'ROU';}
            when 'RU' { calcCode = 'RUS';}
            when 'RW' { calcCode = 'RWA';}
            when 'RE' { calcCode = 'REU';}
            when 'BL' { calcCode = 'BLM';}
            when 'SH' { calcCode = 'SHN';}
            when 'KN' { calcCode = 'KNA';}
            when 'LC' { calcCode = 'LCA';}
            when 'MF' { calcCode = 'MAF';}
            when 'PM' { calcCode = 'SPM';}
            when 'VC' { calcCode = 'VCT';}
            when 'WS' { calcCode = 'WSM';}
            when 'SM' { calcCode = 'SMR';}
            when 'ST' { calcCode = 'STP';}
            when 'SA' { calcCode = 'SAU';}
            when 'SN' { calcCode = 'SEN';}
            when 'RS' { calcCode = 'SRB';}
            when 'SC' { calcCode = 'SYC';}
            when 'SL' { calcCode = 'SLE';}
            when 'SG' { calcCode = 'SGP';}
            when 'SX' { calcCode = 'SXM';}
            when 'SK' { calcCode = 'SVK';}
            when 'SI' { calcCode = 'SVN';}
            when 'SB' { calcCode = 'SLB';}
            when 'SO' { calcCode = 'SOM';}
            when 'ZA' { calcCode = 'ZAF';}
            when 'GS' { calcCode = 'SGS';}
            when 'SS' { calcCode = 'SSD';}
            when 'ES' { calcCode = 'ESP';}
            when 'LK' { calcCode = 'LKA';}
            when 'SD' { calcCode = 'SDN';}
            when 'SR' { calcCode = 'SUR';}
            when 'SJ' { calcCode = 'SJM';}
            when 'SE' { calcCode = 'SWE';}
            when 'CH' { calcCode = 'CHE';}
            when 'SY' { calcCode = 'SYR';}
            when 'TW' { calcCode = 'TWN';}
            when 'TJ' { calcCode = 'TJK';}
            when 'TZ' { calcCode = 'TZA';}
            when 'TH' { calcCode = 'THA';}
            when 'TL' { calcCode = 'TLS';}
            when 'TG' { calcCode = 'TGO';}
            when 'TK' { calcCode = 'TKL';}
            when 'TO' { calcCode = 'TON';}
            when 'TT' { calcCode = 'TTO';}
            when 'TN' { calcCode = 'TUN';}
            when 'TR' { calcCode = 'TUR';}
            when 'TM' { calcCode = 'TKM';}
            when 'TC' { calcCode = 'TCA';}
            when 'TV' { calcCode = 'TUV';}
            when 'UG' { calcCode = 'UGA';}
            when 'UA' { calcCode = 'UKR';}
            when 'AE' { calcCode = 'ARE';}
            when 'GB' { calcCode = 'GBR';}
            when 'UM' { calcCode = 'UMI';}
            when 'US' { calcCode = 'USA';}
            when 'UY' { calcCode = 'URY';}
            when 'UZ' { calcCode = 'UZB';}
            when 'VU' { calcCode = 'VUT';}
            when 'VE' { calcCode = 'VEN';}
            when 'VN' { calcCode = 'VNM';}
            when 'VG' { calcCode = 'VGB';}
            when 'VI' { calcCode = 'VIR';}
            when 'WF' { calcCode = 'WLF';}
            when 'EH' { calcCode = 'ESH';}
            when 'YE' { calcCode = 'YEM';}
            when 'ZM' { calcCode = 'ZMB';}
            when 'ZW' { calcCode = 'ZWE';}
            when 'AX' { calcCode = 'ALA';}
            when else { calcCode = 'error';}
        }
        return calcCode;
    }

    public static String getTwoCharCountryCodeWithBackup(String countryCode, String backupCustFamCode, String backupFamCode) {
        backupFamCode = backupFamCode.toUpperCase().trim();
        countryCode = countryCode.toUpperCase().trim();
        String possibleCountryCode = getTwoCharCountryCode(countryCode);
        System.debug('AfterTrimCountryCode: '+countryCode);
        //Check countries if famcode might match. Both cmCustFam and cmFamCode
        if(possibleCountryCode  == 'error'){
            possibleCountryCode = getTwoCharCountryCode(backupFamCode);
        }
        if(possibleCountryCode  == 'error'){
            possibleCountryCode = getTwoCharCountryCode(backupCustFamCode);
        }
        //Check extra mapping tables due to bad ISO standard for countries
        if(possibleCountryCode  == 'error'){
            possibleCountryCode = getTwoCharCountryCodeDueToDataQualityIssues(countryCode);
            System.debug('CountryCode: '+countryCode);
            System.debug('BackupFamCode: '+backupFamCode);
            System.debug('PossibleCountryCode: '+possibleCountryCode);
        }
        //Check specific fam code to country mapping tables
        if(possibleCountryCode  == 'error'){
            possibleCountryCode = emergencyCountryMappingViaFamCode(backupFamCode);
            System.debug('Setting second emergency mapping');
            System.debug(possibleCountryCode);
        }
        return possibleCountryCode;
    }

    public static String emergencyCountryMappingViaFamCode(String famCode){
        System.debug('Backup fam: '+famCode);
        
        String calcCode = '';
        switch on famCode {
            when 'ARO' { calcCode = 'US';}
            when 'AUC' { calcCode = 'AU';}
            when 'BWA' { calcCode = 'BW';}
            when 'ZAM' { calcCode = 'ZA';}
            when 'ZWE' { calcCode = 'ZW';}
            when 'ESC' { calcCode = 'ES';}
            when 'PRC' { calcCode = 'PT';}
            when 'ZMB' { calcCode = 'ZM';}
            when 'NAM' { calcCode = 'NA';}
            when 'MZA' { calcCode = 'MZ';}
            
            when  else { calcCode = 'error';}
        }
        System.debug('Returned Backup fam: '+famCode);
        return calcCode;
    }

    public static String getTwoCharCountryCodeDueToDataQualityIssues(String countryCode) {
        String calcCode = '';
        if(countryCode.length() == 2) return countryCode;
        switch on countryCode {
            when 'ZA' { calcCode = 'ZA';}
            //Congo
            when 'CDO' { calcCode = 'CD';}
            when 'DRC' { calcCode = 'CD';}
            //
            when else { calcCode = 'error';}
        }
        return calcCode;
    }

    public static String getTwoCharCountryCode(String countryCode) {
        String calcCode = '';
        switch on countryCode {
            when 'ALB' { calcCode = 'AL';}
            when 'DZA' { calcCode = 'DZ';}
            when 'ASM' { calcCode = 'AS';}
            when 'AND' { calcCode = 'AD';}
            when 'AFG' { calcCode = 'AF';}
            when 'AGO' { calcCode = 'AO';}
            when 'AIA' { calcCode = 'AI';}
            when 'ATA' { calcCode = 'AQ';}
            when 'ATG' { calcCode = 'AG';}
            when 'ARG' { calcCode = 'AR';}
            when 'ARM' { calcCode = 'AM';}
            when 'ABW' { calcCode = 'AW';}
            when 'AUS' { calcCode = 'AU';}
            when 'AUT' { calcCode = 'AT';}
            when 'AZE' { calcCode = 'AZ';}
            when 'BHS' { calcCode = 'BS';}
            when 'BHR' { calcCode = 'BH';}
            when 'BGD' { calcCode = 'BD';}
            when 'BRB' { calcCode = 'BB';}
            when 'BLR' { calcCode = 'BY';}
            when 'BEL' { calcCode = 'BE';}
            when 'BLZ' { calcCode = 'BZ';}
            when 'BEN' { calcCode = 'BJ';}
            when 'BMU' { calcCode = 'BM';}
            when 'BTN' { calcCode = 'BT';}
            when 'BOL' { calcCode = 'BO';}
            when 'BES' { calcCode = 'BQ';}
            when 'BIH' { calcCode = 'BA';}
            when 'BWA' { calcCode = 'BW';}
            when 'BVT' { calcCode = 'BV';}
            when 'BRA' { calcCode = 'BR';}
            when 'IOT' { calcCode = 'IO';}
            when 'BRN' { calcCode = 'BN';}
            when 'BGR' { calcCode = 'BG';}
            when 'BFA' { calcCode = 'BF';}
            when 'BDI' { calcCode = 'BI';}
            when 'CPV' { calcCode = 'CV';}
            when 'KHM' { calcCode = 'KH';}
            when 'CMR' { calcCode = 'CM';}
            when 'CAN' { calcCode = 'CA';}
            when 'CYM' { calcCode = 'KY';}
            when 'CAF' { calcCode = 'CF';}
            when 'TCD' { calcCode = 'TD';}
            when 'CHL' { calcCode = 'CL';}
            when 'CHN' { calcCode = 'CN';}
            when 'CXR' { calcCode = 'CX';}
            when 'CCK' { calcCode = 'CC';}
            when 'COL' { calcCode = 'CO';}
            when 'COM' { calcCode = 'KM';}
            when 'COD' { calcCode = 'CD';}
            when 'COG' { calcCode = 'CG';}
            when 'COK' { calcCode = 'CK';}
            when 'CRI' { calcCode = 'CR';}
            when 'HRV' { calcCode = 'HR';}
            when 'CUB' { calcCode = 'CU';}
            when 'CUW' { calcCode = 'CW';}
            when 'CYP' { calcCode = 'CY';}
            when 'CZE' { calcCode = 'CZ';}
            when 'CIV' { calcCode = 'CI';}
            when 'DNK' { calcCode = 'DK';}
            when 'DJI' { calcCode = 'DJ';}
            when 'DMA' { calcCode = 'DM';}
            when 'DOM' { calcCode = 'DO';}
            when 'ECU' { calcCode = 'EC';}
            when 'EGY' { calcCode = 'EG';}
            when 'SLV' { calcCode = 'SV';}
            when 'GNQ' { calcCode = 'GQ';}
            when 'ERI' { calcCode = 'ER';}
            when 'EST' { calcCode = 'EE';}
            when 'SWZ' { calcCode = 'SZ';}
            when 'ETH' { calcCode = 'ET';}
            when 'FLK' { calcCode = 'FK';}
            when 'FRO' { calcCode = 'FO';}
            when 'FJI' { calcCode = 'FJ';}
            when 'FIN' { calcCode = 'FI';}
            when 'FRA' { calcCode = 'FR';}
            when 'GUF' { calcCode = 'GF';}
            when 'PYF' { calcCode = 'PF';}
            when 'ATF' { calcCode = 'TF';}
            when 'GAB' { calcCode = 'GA';}
            when 'GMB' { calcCode = 'GM';}
            when 'GEO' { calcCode = 'GE';}
            when 'DEU' { calcCode = 'DE';}
            when 'GHA' { calcCode = 'GH';}
            when 'GIB' { calcCode = 'GI';}
            when 'GRC' { calcCode = 'GR';}
            when 'GRL' { calcCode = 'GL';}
            when 'GRD' { calcCode = 'GD';}
            when 'GLP' { calcCode = 'GP';}
            when 'GUM' { calcCode = 'GU';}
            when 'GTM' { calcCode = 'GT';}
            when 'GGY' { calcCode = 'GG';}
            when 'GIN' { calcCode = 'GN';}
            when 'GNB' { calcCode = 'GW';}
            when 'GUY' { calcCode = 'GY';}
            when 'HTI' { calcCode = 'HT';}
            when 'HMD' { calcCode = 'HM';}
            when 'VAT' { calcCode = 'VA';}
            when 'HND' { calcCode = 'HN';}
            when 'HKG' { calcCode = 'HK';}
            when 'HUN' { calcCode = 'HU';}
            when 'ISL' { calcCode = 'IS';}
            when 'IND' { calcCode = 'IN';}
            when 'IDN' { calcCode = 'ID';}
            //Iran
            when 'IRN' { calcCode = 'IR';}
            //Bpcs Ireland
            when 'IRE' { calcCode = 'IE';}
            when 'IRQ' { calcCode = 'IQ';}
            when 'IRL' { calcCode = 'IE';}
            when 'IMN' { calcCode = 'IM';}
            when 'ISR' { calcCode = 'IL';}
            when 'ITA' { calcCode = 'IT';}
            when 'JAM' { calcCode = 'JM';}
            when 'JPN' { calcCode = 'JP';}
            when 'JEY' { calcCode = 'JE';}
            when 'JOR' { calcCode = 'JO';}
            when 'KAZ' { calcCode = 'KZ';}
            when 'KEN' { calcCode = 'KE';}
            when 'KIR' { calcCode = 'KI';}
            when 'PRK' { calcCode = 'KP';}
            when 'KOR' { calcCode = 'KR';}
            when 'KWT' { calcCode = 'KW';}
            when 'KGZ' { calcCode = 'KG';}
            when 'LAO' { calcCode = 'LA';}
            when 'LVA' { calcCode = 'LV';}
            when 'LBN' { calcCode = 'LB';}
            when 'LSO' { calcCode = 'LS';}
            when 'LBR' { calcCode = 'LR';}
            when 'LBY' { calcCode = 'LY';}
            when 'LIE' { calcCode = 'LI';}
            when 'LTU' { calcCode = 'LT';}
            when 'LUX' { calcCode = 'LU';}
            when 'MAC' { calcCode = 'MO';}
            when 'MDG' { calcCode = 'MG';}
            when 'MWI' { calcCode = 'MW';}
            when 'MYS' { calcCode = 'MY';}
            when 'MDV' { calcCode = 'MV';}
            when 'MLI' { calcCode = 'ML';}
            when 'MLT' { calcCode = 'MT';}
            when 'MHL' { calcCode = 'MH';}
            when 'MTQ' { calcCode = 'MQ';}
            when 'MRT' { calcCode = 'MR';}
            when 'MUS' { calcCode = 'MU';}
            when 'MYT' { calcCode = 'YT';}
            when 'MEX' { calcCode = 'MX';}
            when 'FSM' { calcCode = 'FM';}
            when 'MDA' { calcCode = 'MD';}
            when 'MCO' { calcCode = 'MC';}
            when 'MNG' { calcCode = 'MN';}
            when 'MNE' { calcCode = 'ME';}
            when 'MSR' { calcCode = 'MS';}
            when 'MAR' { calcCode = 'MA';}
            when 'MOZ' { calcCode = 'MZ';}
            when 'MMR' { calcCode = 'MM';}
            when 'NAM' { calcCode = 'NA';}
            when 'NRU' { calcCode = 'NR';}
            when 'NPL' { calcCode = 'NP';}
            when 'NLD' { calcCode = 'NL';}
            when 'NCL' { calcCode = 'NC';}
            when 'NZL' { calcCode = 'NZ';}
            when 'NIC' { calcCode = 'NI';}
            when 'NER' { calcCode = 'NE';}
            when 'NGA' { calcCode = 'NG';}
            when 'NIU' { calcCode = 'NU';}
            when 'NFK' { calcCode = 'NF';}
            when 'MNP' { calcCode = 'MP';}
            when 'NOR' { calcCode = 'NO';}
            when 'OMN' { calcCode = 'OM';}
            when 'PAK' { calcCode = 'PK';}
            when 'PLW' { calcCode = 'PW';}
            when 'PSE' { calcCode = 'PS';}
            when 'PAN' { calcCode = 'PA';}
            when 'PNG' { calcCode = 'PG';}
            when 'PRY' { calcCode = 'PY';}
            when 'PER' { calcCode = 'PE';}
            when 'PHL' { calcCode = 'PH';}
            when 'PCN' { calcCode = 'PN';}
            when 'POL' { calcCode = 'PL';}
            when 'PRT' { calcCode = 'PT';}
            when 'PRI' { calcCode = 'PR';}
            when 'QAT' { calcCode = 'QA';}
            when 'MKD' { calcCode = 'MK';}
            when 'ROU' { calcCode = 'RO';}
            when 'RUS' { calcCode = 'RU';}
            when 'RWA' { calcCode = 'RW';}
            when 'REU' { calcCode = 'RE';}
            when 'BLM' { calcCode = 'BL';}
            when 'SHN' { calcCode = 'SH';}
            when 'KNA' { calcCode = 'KN';}
            when 'LCA' { calcCode = 'LC';}
            when 'MAF' { calcCode = 'MF';}
            when 'SPM' { calcCode = 'PM';}
            when 'VCT' { calcCode = 'VC';}
            when 'WSM' { calcCode = 'WS';}
            when 'SMR' { calcCode = 'SM';}
            when 'STP' { calcCode = 'ST';}
            when 'SAU' { calcCode = 'SA';}
            when 'SEN' { calcCode = 'SN';}
            when 'SRB' { calcCode = 'RS';}
            when 'SYC' { calcCode = 'SC';}
            when 'SLE' { calcCode = 'SL';}
            when 'SGP' { calcCode = 'SG';}
            when 'SXM' { calcCode = 'SX';}
            when 'SVK' { calcCode = 'SK';}
            when 'SVN' { calcCode = 'SI';}
            when 'SLB' { calcCode = 'SB';}
            when 'SOM' { calcCode = 'SO';}
            when 'ZAF' { calcCode = 'ZA';}
            when 'SGS' { calcCode = 'GS';}
            when 'SSD' { calcCode = 'SS';}
            when 'ESP' { calcCode = 'ES';}
            when 'LKA' { calcCode = 'LK';}
            when 'SDN' { calcCode = 'SD';}
            when 'SUR' { calcCode = 'SR';}
            when 'SJM' { calcCode = 'SJ';}
            when 'SWE' { calcCode = 'SE';}
            when 'CHE' { calcCode = 'CH';}
            when 'SYR' { calcCode = 'SY';}
            when 'TWN' { calcCode = 'TW';}
            when 'TJK' { calcCode = 'TJ';}
            when 'TZA' { calcCode = 'TZ';}
            when 'THA' { calcCode = 'TH';}
            when 'TLS' { calcCode = 'TL';}
            when 'TGO' { calcCode = 'TG';}
            when 'TKL' { calcCode = 'TK';}
            when 'TON' { calcCode = 'TO';}
            when 'TTO' { calcCode = 'TT';}
            when 'TUN' { calcCode = 'TN';}
            when 'TUR' { calcCode = 'TR';}
            when 'TKM' { calcCode = 'TM';}
            when 'TCA' { calcCode = 'TC';}
            when 'TUV' { calcCode = 'TV';}
            when 'UGA' { calcCode = 'UG';}
            when 'UKR' { calcCode = 'UA';}
            when 'ARE' { calcCode = 'AE';}
            when 'GBR' { calcCode = 'GB';}
            when 'UMI' { calcCode = 'UM';}
            when 'USA' { calcCode = 'US';}
            when 'URY' { calcCode = 'UY';}
            when 'UZB' { calcCode = 'UZ';}
            when 'VUT' { calcCode = 'VU';}
            when 'VEN' { calcCode = 'VE';}
            when 'VNM' { calcCode = 'VN';}
            when 'VGB' { calcCode = 'VG';}
            when 'VIR' { calcCode = 'VI';}
            when 'WLF' { calcCode = 'WF';}
            when 'ESH' { calcCode = 'EH';}
            when 'YEM' { calcCode = 'YE';}
            when 'ZMB' { calcCode = 'ZM';}
            when 'ZWE' { calcCode = 'ZW';}
            when 'ALA' { calcCode = 'AX';}
            when else { calcCode = 'error';}
        }
        System.debug('Calculated country code: '+calcCode);
        return calcCode;
    }

    public static string currencyMapping(String countryCode) {
        String calcCurrency = '';
        switch on countryCode {
            when 'ZMW' {calcCurrency = 'ZMW';}
            when 'ZAR' {calcCurrency = 'ZAR';}
            when 'SEK' {calcCurrency = 'SEK';}
            when 'EUR' {calcCurrency = 'EUR';}
            when 'BWP' {calcCurrency = 'BWP';}
            when 'AUD' {calcCurrency = 'AUD';}
            when else {calcCurrency = 'USD';}
        }
        return calcCurrency;
    }

    public static string emailMapping(String emails) {
        if(emails.contains(';')){
            String oneEmail = emails.split(';')[0];
            return oneEmail;
        }
        else return emails;
    }
    public static Boolean countryWithRegionMapping(String countryCode) {
        Boolean valid = false;
        switch on countryCode {
            when 'AU' {valid = true;}
            when 'BR' {valid = true;}
            when 'CA' {valid = true;}
            when 'CN' {valid = true;}
            when 'ES' {valid = true;}
            when 'IE' {valid = true;}
            when 'IN' {valid = true;}
            when 'IT' {valid = true;}
            when 'MX' {valid = true;}
            when 'PT' {valid = true;}
            when 'US' {valid = true;}
        }
        return valid;
    }
    
    public static String stateMapping(String stateCode) {
        String calcCode = null;
        switch on stateCode {
            //Do not use. Will set state to null.
            when 'DNU' {calcCode = null;}
            when else {calcCode = stateCode;}
        }
        return calcCode;
    }

    // public static Boolean abc(String countryCode) {
    //     Boolean calcCode = false;
    //     switch on countryCode {
    //         when 'C' {calcCode = true;}
    //         when 'A' {calcCode = true;}
    //         when 'O' {calcCode = true;}
    //         when 'B' {calcCode = true;}       
    //         when 'S' {calcCode = true;}
    //         when 'J' {calcCode = true;}
    //         when 'H' {calcCode = true;}
    //         when 'L' {calcCode = true;}
    //         when 'M' {calcCode = true;}
    //         when 'P' {calcCode = true;}
    //         when 'T' {calcCode= true;}
    //         when 'V' {calcCode= true;}
    //         when 'Z' {calcCode= true;}
    //         when 'AV' {calcCode= true;}
    //         when 'VI' {calcCode = true;}
    //         when 'AB' {calcCode = true;}
    //         when 'AL' {calcCode = true;}
    //         when 'BA' {calcCode= true;}
    //         when 'BI' {calcCode= true;}
    //         when 'BU' {calcCode= true;}
    //         when 'CC' {calcCode= true;}
    //         when 'CA' {calcCode= true;}
    //         when 'CS' {calcCode= true;}
    //         when 'CR' {calcCode= true;}
    //         when 'CO' {calcCode= true;}
    //         when 'CU' {calcCode= true;}
    //         when 'SS' {calcCode= true;}
    //         when 'GI' {calcCode= true;}
    //         when 'GR' {calcCode= true;}
    //         when 'GU' {calcCode= true;}
    //         when 'HU' {calcCode= true;}
    //         when 'PM' {calcCode= true;}
    //         when 'LO' {calcCode= true;}
    //         when 'GC' {calcCode= true;}
    //         when 'LE' {calcCode= true;}
    //         when 'LU' {calcCode= true;}
    //         when 'MA' {calcCode= true;}
    //         when 'MU' {calcCode= true;}
    //         when 'NA' {calcCode= true;}
    //         when 'OR' {calcCode= true;}
    //         when 'PO' {calcCode= true;}
    //         when 'SA' {calcCode= true;}
    //         when 'TF' {calcCode= true;}
    //         when 'SG' {calcCode= true;}
    //         when 'SE' {calcCode= true;}
    //         when 'SO' {calcCode= true;}
    //         when 'TE' {calcCode= true;}
    //         when 'TO' {calcCode= true;}
    //         when 'VA' {calcCode= true;}
    //         when 'ZA' {calcCode= true;}
    //         when 'AN' {calcCode= true;}
    //         when 'AR' {calcCode= true;}
    //         when 'AS' {calcCode= true;}
    //         when 'CN' {calcCode= true;}
    //         when 'CB' {calcCode= true;}
    //         when 'CL' {calcCode= true;}
    //         when 'CM' {calcCode= true;}
    //         when 'CT' {calcCode= true;}
    //         when 'CE' {calcCode= true;}
    //         when 'EX' {calcCode= true;}
    //         when 'GA' {calcCode= true;}
    //         when 'IB' {calcCode= true;}
    //         when 'RI' {calcCode= true;}
    //         when 'MD' {calcCode= true;}
    //         when 'ML' {calcCode= true;}
    //         when 'MC' {calcCode= true;}
    //         when 'NC' {calcCode= true;}
    //         when 'PV' {calcCode= true;}
    //         when 'VC' {calcCode= true;}
    //     }
    //     return calcCode; 
    // }

    public static String paymentTermsMapping(String erpTerms,String cMfamCode) {
        //erpTerms = erpTerms.toUpperCase();
        String salesforceTerms = '';
        switch on erpTerms {
            //Spansh mapping
            when '10' {salesforceTerms = '10 DAYS';}
            when '20' {salesforceTerms = '20 DAYS';}
            when '30' {salesforceTerms = '30 DAYS';}
            when '60' {salesforceTerms = '60 DAYS';}
            when '10 DIAS DA DATA DA FACTURA' {salesforceTerms = '10 DAYS';}
            when '15 DIAS DA DATA DA FACTURA' {salesforceTerms = '15 DAYS';}
            when '20 DIAS DA DATA DA FACTURA' {salesforceTerms = '20 DAYS';}
            when '30 DIAS DA DATA DA FACTURA' {salesforceTerms = '30 DAYS';}
            when '60 DIAS DA DATA DA FACTURA' {salesforceTerms = '60 DAYS';}
            when '90 DIAS DA DATA DA FACTURA' {salesforceTerms = '90 DAYS';}
            when '60 DIAS' {salesforceTerms = '60 DAYS';}
            when '90 DIAS' {salesforceTerms = '90 DAYS';}
            when 'Net 10 days' {salesforceTerms = '10 DAYS';}
            when 'Net 15 days' {salesforceTerms = '15 DAYS';}
            when 'Net 20 days' {salesforceTerms = '20 DAYS';}
            when 'Net 25 days' {salesforceTerms = '25 DAYS';}
            when 'Net 30 days' {salesforceTerms = '30 DAYS';}
            when 'Net 60 days' {salesforceTerms = '60 DAYS';}
            when 'Net 90 days' {salesforceTerms = '90 DAYS';}
            
            //ESC & PRC Mapping-Start
            when '00' {salesforceTerms = '0 DAYS';}
            when '01' {salesforceTerms = '45 DAYS';}
            when '05' {salesforceTerms = '0 DAYS';}
            when '07' {salesforceTerms = '75 DAYS';}
            when '08' {salesforceTerms = '105 DAYS';}
            when '09' {salesforceTerms = '80 DAYS';}
            when '11' {salesforceTerms = '30 DAYS';}
            when '12' {salesforceTerms = '30 DAYS';}
            when '1Q' {salesforceTerms = '15 DAYS';}
            when '17' {salesforceTerms = '30 DAYS';}
            when '21' {salesforceTerms = '60 DAYS';}
            when '22' {salesforceTerms = '60 DAYS';}
            when '23' {salesforceTerms = '60 DAYS';}
            when '25' {salesforceTerms = '60 DAYS';}
            when '31' {salesforceTerms = '90 DAYS';}
            when '34' {salesforceTerms = '90 DAYS';}
            when '39' {salesforceTerms = '90 DAYS';}
            when '41' {salesforceTerms = '120 DAYS';}
            when '42' {salesforceTerms = '120 DAYS';}
            when '43' {salesforceTerms = '120 DAYS';}
            when '45' {salesforceTerms = '45 DAYS';}
            when '51' {salesforceTerms = '150 DAYS';}
            when '61' {salesforceTerms = '180 DAYS';}
            when '63' {salesforceTerms = '180 DAYS';}
            when '66' {salesforceTerms = '180 DAYS';}
            when '67' {salesforceTerms = '60 DAYS';}
            when '70' {salesforceTerms = '70 DAYS';}
            when '71' {salesforceTerms = '210 DAYS';}
            when '81' {salesforceTerms = '240 DAYS';}
            when '85' {salesforceTerms = '85 DAYS';}
            when '90' {salesforceTerms = '30 DAYS';}
            when '91' {salesforceTerms = '30 DAYS';}
            when '93' {salesforceTerms = '60 DAYS';}
            when '94' {salesforceTerms = '0 DAYS';}
            when '95' {salesforceTerms = '30 DAYS';}
            
            when '02' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '20 DAYS';}
                    when 'PRC' {salesforceTerms = '0 DAYS';}
                }}
            when '03' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '0 DAYS';}
                    when 'PRC' {salesforceTerms = '30 DAYS';}
                }}
            when '04' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '0 DAYS';}
                    when 'PRC' {salesforceTerms = '15 DAYS';}
                }}
            when '06' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '30 DAYS';}
                    when 'PRC' {salesforceTerms = '60 DAYS';}
                }}
            when '13' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '30 DAYS';}
                    when 'PRC' {salesforceTerms = '90 DAYS';}
                }}
            when '14' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '30 DAYS';}
                    when 'PRC' {salesforceTerms = '60 DAYS';}
                }}
            when '15' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '30 DAYS';}
                    when 'PRC' {salesforceTerms = '150 DAYS';}
                }}
            when '16' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '30 DAYS';}
                    when 'PRC' {salesforceTerms = '180 DAYS';}
                }}
            when '18' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '180 DAYS';}
                    when 'PRC' {salesforceTerms = '90 DAYS';}
                }}
            when '24' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '60 DAYS';}
                    when 'PRC' {salesforceTerms = '150 DAYS';}
                }}
            when '32' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '90 DAYS';}
                    when 'PRC' {salesforceTerms = '120 DAYS';}
                }}
            when '33' {
                switch on cMfamCode{
                    when 'ESC' {salesforceTerms = '90 DAYS';}
                    when 'PRC' {salesforceTerms = '150 DAYS';}
                }}
            //ESC & PRC Mapping-End
            
            when else {salesforceTerms = null;}
        }
        return salesforceTerms;
    }
        //ZAM, ZMB,ZWE, MZA, NAM, BWA, PRC, ESC, ARO, AUC

    public static String countryCodeToFamCode(String countryCode){
        System.debug('countryCodeToFamCode: '+countryCode);
        
        String calcCode = '';
        switch on countryCode {
            when 'AU' { calcCode = 'AUC';}
            when 'BW' { calcCode = 'BWA';}
            when 'US' { calcCode = 'ARO';}
            when 'ES' { calcCode = 'ESC';}
            when 'PT' { calcCode = 'PRC';}
            when 'ZA' { calcCode = 'ZAM';}
            when 'ZM' { calcCode = 'ZMB';}
            when 'ZW' { calcCode = 'ZWE';}
            when 'NA' { calcCode = 'NAM';}
            when 'MZ' { calcCode = 'MZA';}
            when  else { calcCode = 'error';}
        }
        return calcCode;
    }

    public static String countryCodeToCurrency(String countryCode){
        System.debug('countyCode to Currency Code: ' + countryCode);
        String currencyCode = '';
        switch on countryCode {
            when 'AU' { currencyCode = 'AUD';}
            when 'BW' { currencyCode = 'BWP';}
            when 'US' { currencyCode = 'USD';}
            when 'ES' { currencyCode = 'EUR';}
            when 'PT' { currencyCode = 'EUR';}
            when 'ZA' { currencyCode = 'ZAR';}
            when 'ZM' { currencyCode = 'ZMW';}
            when 'ZW' { currencyCode = 'USD';}
            when 'NA' { currencyCode = 'NAD';}
            when 'MZ' { currencyCode = 'MZN';}
            when 'SE' { currencyCode = 'SEK';}
            when else { currencyCode = 'USD';}
        }
        return currencyCode;
    }

    public static Boolean usePartnerMapping(String cmsalesman) {
        //erpTerms = erpTerms.toUpperCase();
        Boolean isPartner = false;
        switch on cmsalesman {
            //Spansh mapping
            when 'Dealer' {isPartner = true;}
        }
        return isPartner;
    }

    public static String getCreditStatus(String status) {
        //erpTerms = erpTerms.toUpperCase();
        String calcStatus = '';
        switch on status {
            //Blocked
            when 'S' {calcStatus = 'Not Approved';}
            when else {calcStatus = null;}
        }
        return calcStatus;
    }
    public static String getExternalState(String state1, String state2) {
        String calcStatus = '';
        switch on state1 {
            when '1' {calcStatus = 'Active';}
            when '2' {calcStatus = 'Deleted';}
            when else {calcStatus = null;}
        }
        if(calcStatus == null){
            switch on state2 {
                when 'CM' {calcStatus = 'Active';}
                when 'CZ' {calcStatus = 'Dead';}
                when else {calcStatus = null;}
            }
        }
        return calcStatus;
    }
}