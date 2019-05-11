//
//  ViewModelDataProtocol.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 06/05/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

protocol ViewModelModelData{
    var inputValue: String? { get set }
    var outputValue: String? { get }
    var inputValuesInt: [Int] { get set }
    var countryData: CountryValues? { get set }
    func setInput(variable: String)
    func getOutput()->String // function to update some properties (label.text or smthng)
    func returnData() -> CountryReturningProtocol?
}

