//
//  ProjectBack.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 07/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

struct Root : Decodable {
    
    let info : Info
    let countryObjects : [CountryObject]
    
    init(from decoder: Decoder) throws {
        var arrayContrainer = try decoder.unkeyedContainer()
        info = try arrayContrainer.decode(Info.self)
        countryObjects = try arrayContrainer.decode([CountryObject].self)
    }
}

struct Info : Decodable {
    let page, pages, perPage: Int
    let lastupdated: String
}

struct CountryObject : Decodable {
    let country: CountryInfo
    let date: String
    let value: Int?
}

struct CountryInfo : Decodable { //Country names
    let id: String
    let value: String
}


