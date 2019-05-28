//
//  Regions.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 20/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

enum Regions:  String, CaseIterable, CountryRegion{
    
    case Europe
    case Africa
    case Asia
    case NorthAmerica
    case LatinAmerica
    static func returnAllCountries()->[String]{
        var array: [String] = []
        for value in Regions.allCases {
            array.append(String(describing: value))
        }
        return array
    }
    func compareCountryAndCode(country: CountryRegion)->String{
        switch country as! Regions{
        case .Europe: return "EU"
        case .NorthAmerica: return "XU"
        case .LatinAmerica: return "ZJ"
        case .Africa: return "ZQ"
        case .Asia: return "Z4"
        }
    }
}
