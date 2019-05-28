//
//  ValuesReturning.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 01/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

struct ValueViewModel{
    func returnReversYears() -> [Int]{
        return returnYearsValue(reverse: true)
    }
    func returnStraightYears() -> [Int]{
        return returnYearsValue(reverse: false)
    }
    func returnCountrySource() -> [String]{
        return Country.returnAllCountries()
    }
    func returnRegionSource() -> [String]{
        return Regions.returnAllCountries()
    }
    
}
