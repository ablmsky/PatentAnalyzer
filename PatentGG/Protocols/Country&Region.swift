//
//  Country&Region.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 28/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

protocol CountryRegion{
    static func returnAllCountries()->[String]
    func compareCountryAndCode(country: CountryRegion)->String
}

