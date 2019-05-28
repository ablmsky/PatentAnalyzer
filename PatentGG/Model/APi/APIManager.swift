//
//  APIManager.swift
//  PatentGG
//
//  Created by Anton Ablamsky on 25/04/2019.
//  Copyright © 2019 Anton Ablamskiy. All rights reserved.
//

import Foundation

protocol FinalURLPoint {//to combine full request name
    var baseURL: String { get }
    var path: String { get }
    var request: URL? { get }
}
protocol APIManager{
    var url: URL?{ get set }
    static func getURL(country: CountryRegion) -> URL?
}
enum NetworkError: Error{
    case url
}
extension APIManager{
    static func getURL(country: CountryRegion) -> URL?{
        let urlForSession = URLCreating(country: country)
        return urlForSession.getRequest()
    }
}

