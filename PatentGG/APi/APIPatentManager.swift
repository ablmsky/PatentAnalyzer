//
//  APIPatentManager.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 17/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//
import Foundation

struct URLCreating: FinalURLPoint{
    var baseURL: String
    var path: String
    var request: URL?
    init(country: Country){
        self.baseURL = "https://api.worldbank.org"
        self.path = "/v2/country/\(Country.compareCountryAndCode(country: country))/indicator/IP.PAT.RESD?format=json"
        self.request = URL(string: baseURL+path)
    }
    public func getRequest() -> URL?{
        return self.request
    }
}
enum NetworkError: Error{
    case url
}

public class APIPatentManager: APIManager {
    var url: URL?
    var responseResult: [CountryObject]
    static func getURL(country: Country) -> URL?{
        let urlForSession = URLCreating(country: country)
        return urlForSession.getRequest()
    }
    init(){
        self.url = URL.init(string: "something")
        self.responseResult = []
    }
}
extension ViewController{
    func dataAndResponse(url: URL?) throws -> [CountryObject] {
        var object: [CountryObject] = []
        guard let urlString = url else { throw NetworkError.url }
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: urlString){ (data, response, error) in
            DispatchQueue.main.async(execute: {
                guard let data = data else { return }
                guard error == nil else { return }
                do {
                    let decoder =  JSONDecoder()
                    let array = try JSONSerialization.jsonObject(with: data) as? [Any] ?? []
                    let rootElement = array[1]
                    let rootData = try JSONSerialization.data(withJSONObject: rootElement, options: [])
                    let countryObjects = try decoder.decode([CountryObject].self, from: rootData)
                     object = countryObjects
                    print(countryObjects)//only after returning nil, there will be smthng
                } catch let error {
                    print(error)
                }
            })
            semaphore.signal()
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return object
    }
}

