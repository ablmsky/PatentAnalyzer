//
//  ProjectBack.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 07/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation
struct CountryObject{//Country features data
    //var country: CountryInfo
    var date: Int
    var value: Int?
}
struct Object{//final composite object
    var country: CountryObject
    var data: CountryInfo
}
/*"country": {
    "id": "SS",
    "value": "South Sudan"
},
"countryiso3code": "SSD",
"date": "2018",
"value": null,*/

struct CountryInfo{//Country names
    var id: String
    var value: String
}

extension CountryInfo: JSONDecodable{
    init?(JSON: [NSAttributedString.Key : AnyObject]){
        guard let id = JSON[NSAttributedString.Key("id")] as? String,
            let value = JSON[NSAttributedString.Key("value")] as? String else{
                return nil
        }
        self.id = id
        self.value = value
    }
}
extension CountryObject: JSONDecodable{
    init?(JSON: [NSAttributedString.Key : AnyObject]) {
        guard let date = JSON[NSAttributedString.Key("date")] as? Int,
            let value = JSON[NSAttributedString.Key("value")] as? Int? else{
                return nil
        }
        self.date = date
        self.value = value
    }
}
    
//struct Object{
    /*enum CodingKeys: String, CodingKey, Decodable {
        //case country
        case countryiso3code
        case date
        case value
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        countryiso3code = try container.decode(String.self, forKey: .countryiso3code)
        date = try container.decode(Int.self, forKey: .date)
        value = try container.decode(Int.self, forKey: .value)
    }*/


func getValuesFromJson(){
    let address = chosingCountry(country: .Russia)
}
func chosingCountry(country: Country) -> String{
    let iso = Country.compareCountryAndCode(country: country)
    let apiAddress = "https://api.worldbank.org/v2/country/"
    let apiAddressGetterInfo = "/indicator/IP.PAT.RESD?format=json"
    return apiAddress+iso+apiAddressGetterInfo
}

