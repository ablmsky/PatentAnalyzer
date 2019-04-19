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
}

final class APIPatentManager: APIManager{
    let sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    let apiKey: String
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String){
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    convenience init(apiKey: String){
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }//somebulshit one after :(
    func fetchCountries(country: Country, completionHandler: @escaping (APIResult<CountryObject>)-> Void){
        let request = URLCreating(country: country).request
        /*fetch(request: request, parse: { (json) -> CountryInfo? in
            if let countryData = json[NSAttributedString.Key("country")] as? [NSAttributedString.Key : AnyObject]{//maybe bug here with array type
                //code from stack
                let decoder =  JSONDecoder()
                let array = try JSONSerialization.jsonObject(with: data) as? [Any] ?? []
                let rootElement = array[1]
                let rootData = try JSONSerialization.data(withJSONObject: rootElement, options: [])
                let countryObjects = try decoder.decode([CountryObject].self, from: rootData)
                //
                return CountryInfo(JSON: countryData)
            } else{
                return nil
            }
        }, completionHandler: completionHandler)*/
    }
}

/*let urlString = chosingCountry(country: .Russia)
//var objects = [Object?]()
print(urlString)
//"https://api.worldbank.org/v2/country/SS/indicator/IP.PAT.RESD?format=json"
/*Alamofire.request(url, method: .get).validate().responseJSON {
 response in
 switch response.result {
 case .success(let value):
 //let json = JSON(value)
 //print(value)
 let json = JSON(value)
 print(json["page"])
 case .failure(let error):
 print(error)
 }
 }*/
guard let url = URL(string: urlString) else {return}

URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let data = data else { return }
    guard error == nil else { return }
    
    do{
        //let dataAsString = String(data: data, encoding: .utf8)
        //try print(dataAsString)
        //try print(JSONDecoder().decode(Object.self, from: data))
        
        let objects = try JSONDecoder().decode(JsonData.self, from: data)
        //let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        //print(json)
        print(objects)
    } catch let error {
        print(error)
    }
    
    }.resume()
// Do any additional setup after loading the view, typically from a nib.
*/






