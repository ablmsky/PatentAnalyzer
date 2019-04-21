//
//  APIPatentManager.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 17/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

struct URLCreating: FinalURLPoint{
    var baseURL: URL
    var path: String
    var request: URLRequest
    init(country: Country){
        self.baseURL = URL(string: "https://api.worldbank.org")!
        self.path = "/v2/country/\(Country.compareCountryAndCode(country: country))/indicator/IP.PAT.RESD?format=json"
        self.request = URLRequest(url: URL(string: path, relativeTo: baseURL)!)
    }
    public func getRequest() -> URLRequest{
        return self.request
    }
}

public class APIPatentManager: APIManager {
    var url: URLRequest?
    var responseResult: [CountryObject] = []
    
    init(country: Country){
        self.url = getURL(country: country)
        self.responseResult = responseAndResult(url: url!)
        
        //var errorMessage: Error?
        
    }
}
   
