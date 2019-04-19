//
//  ProjectBack.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 07/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation
struct CountryObject: Decodable{//Country features data
    var country: CountryInfo?
    var date: String?
    var value: Int?
    private enum RawValues: String, Decodable{
        case date = "date"
        case value = "value"
    }
}


struct CountryInfo: Decodable{//Country names
    var id: String?
    var value: String?
    private enum RawValues: String, Decodable{
        case id = "id"
        case value = "value"
    }
}

func getValuesFromJson(){
    let address = chosingCountry(country: .Russia)
}
func chosingCountry(country: Country) -> String{
    let iso = Country.compareCountryAndCode(country: country)
    let apiAddress = "https://api.worldbank.org/v2/country/"
    let apiAddressGetterInfo = "/indicator/IP.PAT.RESD?format=json"
    return apiAddress+iso+apiAddressGetterInfo
}

