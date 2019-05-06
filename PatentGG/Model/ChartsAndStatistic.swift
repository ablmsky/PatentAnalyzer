//
//  GraphicsAndStatistic.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 20/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

public func returnYearsValue(reverse: Bool) -> [Int]{
    let array = Array(1980...2017)
        if !reverse{
            return array
        }
        else{
            return array.reversed()
        }
}


/*extension ChartsCast{
    public func checkContent(array: inout [String]){
        var flag = true
        for value in array{
            if value == ""{}
            else{
                flag = false
            }
        }
        if flag == false{
            array = []
        }
        print (array)
    }
}
public func convertToArray(countryData: [CountryObject])->([Int?],[String?]){
 var arrayOfValues: [Int] = []
 var yearsForValues: [String] = []
 for i in 0..<countryData.count{
 arrayOfValues[i] = countryData[i].value ?? 0
 yearsForValues[i] = countryData[i].date
 checkContent(array: &arrayOfValues)
 checkContent(array: &yearsForValues)
 }
 return (arrayOfValues,yearsForValues)
 }*/
