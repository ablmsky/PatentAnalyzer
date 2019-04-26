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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let root = try decoder.decode(Root.self, from: data)
                    object = root.countryObjects
                    print(object)
                } catch { print(error) }
            })
            semaphore.signal()
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return object
    }
}

