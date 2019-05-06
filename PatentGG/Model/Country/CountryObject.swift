//
//  ProjectBack.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 07/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation
protocol CountryReturningProtocol{
    
}

struct Root : Decodable {
    
    let info : Info
    let countryObjects : [CountryObject]
    
    init(from decoder: Decoder) throws {
        var arrayContrainer = try decoder.unkeyedContainer()
        info = try arrayContrainer.decode(Info.self)
        countryObjects = try arrayContrainer.decode([CountryObject].self)
    }
}

struct Info : Decodable, CountryReturningProtocol {
    let page, pages, perPage: Int
    let lastupdated: String
}

struct CountryObject : Decodable, CountryReturningProtocol {
    let country: CountryInfo
    let date: String
    let value: Int?
}

struct CountryInfo : Decodable, CountryReturningProtocol { //Country names
    let id: String
    let value: String
}

struct ValuePerYear: CountryReturningProtocol{
    var value: Int
    var year: Int
    init(value: Int, year: Int){
        self.value = value
        self.year = year
    }
}


class CountryValues: CountryReturningProtocol{
    var country: String
    var valuePerYear: [ValuePerYear?] = [] //value,Year
    init(countriesData: [CountryObject]){
        self.country = countriesData[0].country.value
        self.valuePerYear = getData(countriesData: countriesData)
    }
    func getData(countriesData: [CountryObject]) -> [ValuePerYear?]{
        var valuePerYears = [ValuePerYear?](repeating: nil, count: countriesData.count)
        for i in 0..<countriesData.count{
            valuePerYears[i] = ValuePerYear(value: countriesData[i].value ?? 0, year: Int(countriesData[i].date) ?? 0)
            print(ValuePerYear(value: countriesData[i].value ?? 0, year: Int(countriesData[i].date) ?? 0))
        }
        return valuePerYears
    }
    func checkContent(elements: inout CountryValues?){
        // this function check data, and if all values(numbers) eqls to 0
        //then delete all data, and print for user on UI - That no data avaible to this country
        var flag = true
        for element in elements!.valuePerYear{
            if (element?.value == 0 || element?.year == 0){}
            else{
                flag = false
            }
        }
        if flag == true{
            elements = nil
        }
    }
}

