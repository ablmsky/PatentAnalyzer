
import Foundation
enum Country: String, CaseIterable{//kinda dictionary for each country and ISO code
    case Afghanistan
    case Albania
    case Algeria
    case AmericanSamoa
    case Andorra
    case Angola
    case AntiguaAndBarbuda
    case Argentina
    case Armenia
    case Aruba
    case Australia
    case Austria
    case Azerbaijan
    case Bahamas
    case Bahrain
    case Bangladesh
    case Barbados
    case Belarus
    case Belgium
    case Belize
    case Benin
    case Bermuda
    case Bhutan
    case Bolivia
    case BosniaandHerzegovina
    case Botswana
    case Brazil
    case BritishVirginIslands
    case Brunei
    case Bulgaria
    case BurkinaFaso
    case Burundi
    case Cambodia
    case Cameroon
    case Canada
    case CapeVerde
    case CaymanIslands
    case CentralAfricanRepublic
    case Chad
    case Chile
    case China
    case Colombia
    case Comoros
    case CostaRica
    case Croatia
    case Cuba
    case Curacao
    case Cyprus
    case CzechRepublic
    case DemocraticRepublicOfTheCongo
    case Denmark
    case Djibouti
    case Dominica
    case DominicanRepublic
    case EastTimor
    case Ecuador
    case Egypt
    case ElSalvador
    case EquatorialGuinea
    case Eritrea
    case Estonia
    case Ethiopia
    case FaroeIslands
    case Fiji
    case Finland
    case France
    case FrenchPolynesia
    case Gabon
    case Gambia
    case Georgia
    case Germany
    case Ghana
    case Gibraltar
    case Greece
    case Greenland
    case Grenada
    case Guam
    case Guatemala
    case Guinea
    case GuineaBissau
    case Guyana
    case Haiti
    case Honduras
    case HongKong
    case Hungary
    case Iceland
    case India
    case Indonesia
    case Iran
    case Iraq
    case Ireland
    case IsleofMan
    case Israel
    case Italy
    case IvoryCoast
    case Jamaica
    case Japan
    case Jordan
    case Kazakhstan
    case Kenya
    case Kiribati
    case Kosovo
    case Kuwait
    case Kyrgyzstan
    case Laos
    case Latvia
    case Lebanon
    case Lesotho
    case Liberia
    case Libya
    case Liechtenstein
    case Lithuania
    case Luxembourg
    case Macau
    case Macedonia
    case Madagascar
    case Malawi
    case Malaysia
    case Maldives
    case Mali
    case Malta
    case MarshallIslands
    case Mauritania
    case Mauritius
    case Mexico
    case Micronesia
    case Moldova
    case Monaco
    case Mongolia
    case Montenegro
    case Morocco
    case Mozambique
    case Myanmar
    case Namibia
    case Nauru
    case Nepal
    case Netherlands
    case NewCaledonia
    case NewZealand
    case Nicaragua
    case Niger
    case Nigeria
    case NorthKorea
    case NorthernMarianaIslands
    case Norway
    case Oman
    case Pakistan
    case Palau
    case Palestine
    case Panama
    case PapuaNewGuinea
    case Paraguay
    case Peru
    case Philippines
    case Poland
    case Portugal
    case PuertoRico
    case Qatar
    case RepublicOfTheCongo
    case Romania
    case Russia
    case Rwanda
    case SaintKittsandNevis
    case SaintLucia
    case SaintMartin
    case SaintVincentandtheGrenadines
    case Samoa
    case SanMarino
    case SaoTomeAndPrincipe
    case SaudiArabia
    case Senegal
    case Serbia
    case Seychelles
    case SierraLeone
    case Singapore
    case SintMaarten
    case Slovakia
    case Slovenia
    case SolomonIslands
    case Somalia
    case SouthAfrica
    case SouthKorea
    case SouthSudan
    case Spain
    case SriLanka
    case Sudan
    case Suriname
    case Swaziland
    case Sweden
    case Switzerland
    case Syria
    case Taiwan
    case Tajikistan
    case Tanzania
    case Thailand
    case Togo
    case Tonga
    case TrinidadandTobago
    case Tunisia
    case Turkey
    case Turkmenistan
    case TurksandCaicosIslands
    case Tuvalu
    case USVirginIslands
    case Uganda
    case Ukraine
    case UnitedArabEmirates
    case UnitedKingdom
    case UnitedStates
    case Uruguay
    case Uzbekistan
    case Vanuatu
    case Venezuela
    case Vietnam
    case Yemen
    case Zambia
    case Zimbabwe
    static func returnAllCountries()->[String]{
        var array: [String] = []
        for value in Country.allCases {
            array.append(String(describing: value))
        }
        return array
    }
    static func compareCountryAndCode(country: Country)->String{
        switch country{
            case .Andorra: return "AD"
            case .UnitedArabEmirates: return "AE"
            case .Afghanistan: return "AF"
            case .AntiguaAndBarbuda: return "AG"
            case .Albania: return "AL"
            case .Armenia: return "AM"
            case .Angola: return "AO"
            case .Argentina: return "AR"
            case .AmericanSamoa: return "AS"
            case .Austria: return "AT"
            case .Australia: return "AU"
            case .Aruba: return "AW"
            case .Azerbaijan: return "AZ"
            case .BosniaandHerzegovina: return "BA"
            case .Barbados: return "BB"
            case .Bangladesh: return "BD"
            case .Belgium: return "BE"
            case .BurkinaFaso: return "BF"
            case .Bulgaria: return "BG"
            case .Bahrain: return "BH"
            case .Burundi: return "BI"
            case .Benin: return "BJ"
            case .Bermuda: return "BM"
            case .Brunei: return "BN"
            case .Bolivia: return "BO"
            case .Brazil: return "BR"
            case .Bahamas: return "BS"
            case .Bhutan: return "BT"
            case .Botswana: return "BW"
            case .Belarus: return "BY"
            case .Belize: return "BZ"
            case .Canada: return "CA"
            case .DemocraticRepublicOfTheCongo: return "CD"
            case .CentralAfricanRepublic: return "CF"
            //case .Congo: return "CG"
            case .Switzerland: return "CH"
            case .IvoryCoast: return "CI"
            case .Chile: return "CL"
            case .Cameroon: return "CM"
            case .China: return "CN"
            case .Colombia: return "CO"
            case .CostaRica: return "CR"
            case .Cuba: return "CU"
            case .Curacao: return "CW"
            case .Cyprus: return "CY"
            case .CzechRepublic: return "CZ"
            case .Germany: return "DE"
            case .Djibouti: return "DJ"
            case .Denmark: return "DK"
            case .Dominica: return "DM"
            case .DominicanRepublic: return "DO"
            case .Algeria: return "DZ"
            case .Ecuador: return "EC"
            case .Estonia: return "EE"
            case .Egypt: return "EG"
            case .Eritrea: return "ER"
            case .Spain: return "ES"
            case .Ethiopia: return "ET"
            case .Finland: return "FI"
            case .Fiji: return "FJ"
            case .Micronesia: return "FM"
            case .FaroeIslands: return "FO"
            case .France: return "FR"
            case .Gabon: return "GA"
            case .UnitedKingdom: return "GB"
            case .Grenada: return "GD"
            case .Georgia: return "GE"
            case .Ghana: return "GH"
            case .Gibraltar: return "GI"
            case .Greenland: return "GL"
            case .Gambia: return "GM"
            case .Guinea: return "GN"
            case .EquatorialGuinea: return "GQ"
            case .Greece: return "GR"
            case .Guatemala: return "GT"
            case .Guam: return "GU"
            case .GuineaBissau: return "GW"
            case .Guyana: return "GY"
            case .HongKong: return "HK"
            case .Honduras: return "HN"
            case .Croatia: return "HR"
            case .Haiti: return "HT"
            case .Hungary: return "HU"
            case .Indonesia: return "ID"
            case .Ireland: return "IE"
            case .Israel: return "IL"
            case .IsleofMan: return "IM"
            case .India: return "IN"
            case .Iraq: return "IQ"
            case .Iran: return "IR"
            case .Iceland: return "IS"
            case .Italy: return "IT"
            case .Jamaica: return "JM"
            case .Jordan: return "JO"
            case .Japan: return "JP"
            case .Kenya: return "KE"
            case .Kyrgyzstan: return "KG"
            case .Cambodia: return "KH"
            case .Kiribati: return "KI"
            case .Comoros: return "KM"
            case .SaintKittsandNevis: return "KN"
            case .NorthKorea: return   "KP"
            case .SouthKorea: return "KR"
            case .Kuwait: return "KW"
            case .CaymanIslands: return "KY"
            case .Kazakhstan: return "KZ"
            case .Laos: return "LA"
            case .Lebanon: return "LB"
            case .SaintLucia: return "LC"
            case .Liechtenstein: return "LI"
            case .SriLanka: return "LK"
            case .Liberia: return "LR"
            case .Lesotho: return "LS"
            case .Lithuania: return "LT"
            case .Luxembourg: return "LU"
            case .Latvia: return "LV"
            case .Libya: return "LY"
            case .Morocco: return "MA"
            case .Monaco: return "MC"
            case .Moldova: return "MD"
            case .Montenegro: return "ME"
            case .SaintMartin: return "MF"
            case .Madagascar: return "MG"
            case .MarshallIslands: return "MH"
            case .Macedonia: return "MK"
            case .Mali: return "ML"
            case .Myanmar: return "MM"
            case .Mongolia: return "MN"
            case .Macau: return "MO"
            case .NorthernMarianaIslands: return "MP"
            case .Mauritania: return "MR"
            case .Malta: return "MT"
            case .Mauritius: return "MU"
            case .Maldives: return "MV"
            case .Malawi: return "MW"
            case .Mexico: return "MX"
            case .Malaysia: return "MY"
            case .Mozambique: return "MZ"
            case .Namibia: return "NA"
            case .NewCaledonia: return "NC"
            case .Niger: return "NE"
            case .Nigeria: return "NG"
            case .Nicaragua: return "NI"
            case .Netherlands: return "NL"
            case .Norway: return "NO"
            case .Nepal: return "NP"
            case .Nauru: return "NR"
            case .NewZealand: return "NZ"
            case .Oman: return "OM"
            case .Panama: return "PA"
            case .Peru: return "PE"
            case .FrenchPolynesia: return "PF"
            case .PapuaNewGuinea: return "PG"
            case .Philippines: return "PH"
            case .Pakistan: return "PK"
            case .Poland: return "PL"
            case .PuertoRico: return "PR"
            case .Palestine: return "PS"
            case .Portugal: return "PT"
            case .Palau: return "PW"
            case .Paraguay: return "PY"
            case .Qatar: return "QA"
            case .Romania: return "RO"
            case .Serbia: return "RS"
            case .Russia: return "RU"
            case .Rwanda: return "RW"
            case .SaudiArabia: return "SA"
            case .SolomonIslands: return "SB"
            case .Seychelles: return "SC"
            case .Sudan: return "SD"
            case .Sweden: return "SE"
            case .Singapore: return "SG"
            case .Slovenia: return "SI"
            case .Slovakia: return "SK"
            case .SierraLeone: return "SL"
            case .SanMarino: return "SM"
            case .Senegal: return "SN"
            case .Somalia: return "SO"
            case .Suriname: return "SR"
            case .SouthSudan: return "SS"
            case .SaoTomeAndPrincipe: return "ST"
            case .ElSalvador: return "SV"
            case .SintMaarten: return "SX"
            case .Syria: return "SY"
            case .TurksandCaicosIslands: return "TC"
            case .Chad: return "TD"
            case .Togo: return "TG"
            case .Thailand: return "TH"
            case .Tajikistan: return "TJ"
            case .EastTimor: return "TL"
            case .Turkmenistan: return "TM"
            case .Tunisia: return "TN"
            case .Tonga: return "TO"
            case .Turkey: return "TR"
            case .TrinidadandTobago: return "TT"
            case .Tuvalu: return "TV"
            case .Taiwan: return "TW"
            case .Tanzania: return "TZ"
            case .Ukraine: return "UA"
            case .Uganda: return "UG"
            case .UnitedStates: return "US"
            case .Uruguay: return "UY"
            case .Uzbekistan: return "UZ"
            case .SaintVincentandtheGrenadines: return "VC"
            case .Venezuela: return "VE"
            case .BritishVirginIslands: return "VG"
            case .USVirginIslands: return "VI"
            case .Vietnam: return "VN"
            case .Vanuatu: return "VU"
            case .Samoa: return "WS"
            case .Yemen: return "YE"
            case .SouthAfrica: return "ZA"
            case .Zambia: return "ZM"
            case .Zimbabwe: return "ZW"
            case .CapeVerde: return "CV"
            case .Kosovo: return "XK"
            case .RepublicOfTheCongo: return "CG"
            case .Swaziland: return "SZ"
        }
    }
}
