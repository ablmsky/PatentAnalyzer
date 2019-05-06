//
//  ModelData.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 30/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation
//ViewModel for ViewController class
struct SetRequest{
    var inputValue: String? //value which get info about "country" to request
    var outputValue: String? // value for some label/etc. to change in view
    init(variable: String){
        self.inputValue = variable
        self.outputValue = variable
    }
    mutating func setInput(variable: String) {
        self.inputValue = variable
    }
    func getOutput()->String{
        return self.outputValue ?? ""
    }
    func makeRequest()->[CountryObject]{
        let countriesResponedResult = APIPatentManager()
        countriesResponedResult.url = APIPatentManager.getURL(country: Country(rawValue: inputValue!)!)
        do{
            countriesResponedResult.responseResult = try countriesResponedResult.dataAndResponse(url: countriesResponedResult.url)
        } catch let error{
            print(error)
        }
        return countriesResponedResult.responseResult
    }
}


class DataFromRequest: ViewModelModelData{
    var inputValue: String?//value which get info about "country" to request
    var outputValue: String?// value for some label/etc. to change in view
    var inputValuesInt: [Int]
    var countryData: CountryValues?
    init(requestSource: SetRequest, years: [Int]){
        self.countryData = CountryValues(countriesData: requestSource.makeRequest())
        self.countryData?.checkContent(elements: &self.countryData)
        self.inputValuesInt = years
    }
    
    func setInput(variable: String){
        self.inputValue = variable
    }
    
    func getOutput()->String{
        self.outputValue = String(describing: countryData?.valuePerYear)
        return self.outputValue ?? ""
    }
    func returnData() -> CountryReturningProtocol? {
        return self.countryData
    }
}
