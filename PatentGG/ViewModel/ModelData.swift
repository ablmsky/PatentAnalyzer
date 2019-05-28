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
        var inputObject: CountryRegion
        inputObject = Country(rawValue: self.inputValue!) ?? Regions (rawValue: self.inputValue!)!
        countriesResponedResult.url = APIPatentManager.getURL(country: inputObject)
        
        
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
    var inputValuesInt: [Int]//here is years to select
    var countryData: CountryValues?
    
    
    init(requestSource: SetRequest, years: [Int]){
        
        self.countryData = CountryValues(countriesData: requestSource.makeRequest())
        
        self.countryData?.checkContent(elements: &self.countryData)
        self.inputValuesInt = years
        
        if (self.countryData != nil){
            selectionByYears()
        }
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
    func selectionByYears(){
        var array: [ValuePerYear] = []
        if (self.inputValuesInt[0]>self.inputValuesInt[1]){
            let temp = self.inputValuesInt[0]
            self.inputValuesInt[0] = self.inputValuesInt[1]
            self.inputValuesInt[1] = temp
        }
        for i in 0..<self.countryData!.valuePerYear.count{
            if (self.countryData!.valuePerYear[i]!.year >= self.inputValuesInt[0] && self.countryData!.valuePerYear[i]!.year <= self.inputValuesInt[1]){
                array.append(ValuePerYear(value: self.countryData!.valuePerYear[i]!.value, year: self.countryData!.valuePerYear[i]!.year))
            }
        }
        self.countryData!.valuePerYear = array
    }
    func allToString()->String{//function to convert data for TextField
        //TODO check optional values
        var stringToReturn: String
        stringToReturn = String(self.countryData?.country ?? "Sorry!\n no available data for this country\n on this period :(")
        stringToReturn.append("\n")
        if (countryData != nil){
            for element in self.countryData!.valuePerYear.reversed(){
                stringToReturn.append(contentsOf: "Year: \(element?.year ?? 0)  -  Number of Patent: \(element?.value ?? 0)\n")
            }
        }
        return stringToReturn
    }
}
