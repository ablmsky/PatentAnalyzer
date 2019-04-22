
import Foundation

protocol FinalURLPoint {//to combine full request name
    var baseURL: String { get }
    var path: String { get }
    var request: URL? { get }
}
protocol APIManager{
    var url: URL?{ get set }
    static func getURL(country: Country) -> URL?
}

extension APIManager{
    static func getURL(country: Country) -> URL?{
        let urlForSession = URLCreating(country: country)
        return urlForSession.getRequest()
    }
}
/*extension APIManager{
    func responseAndResult(url: URLRequest)->[CountryObject]{
        var responseRes: [CountryObject] = []
        URLSession.shared.dataTask(with: url)
            .resume()
        return responseRes
    }
}*/


