//
//  Regions.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 20/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

enum Regions: String, CaseIterable{
    case Europe
    case NorthAmerica
    case SouthAmerica
    case Africa
    case Asia
    case Oceania
    static func returnAllRegions()->[String]{
        var array: [String] = []
        for value in Regions.allCases {
            array.append(String(describing: value))
        }
        return array
    }
}
