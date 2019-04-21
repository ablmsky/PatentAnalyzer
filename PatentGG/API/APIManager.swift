
import Foundation

protocol FinalURLPoint {//to combine full request name
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}
protocol APIManager{
    var url: URLRequest? { get set }
    func getURL(country: Country) -> URLRequest
}

extension APIManager{
    func getURL(country: Country) -> URLRequest{
        let urlForSession = URLCreating(country: country)
        print(urlForSession.getRequest())
        return urlForSession.getRequest()
    }
}
extension APIManager{
    func responseAndResult(url: URLRequest)->[CountryObject]{
        var responseRes: [CountryObject] = []
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let decoder =  JSONDecoder()
                let array = try JSONSerialization.jsonObject(with: data) as? [Any] ?? []
                let rootElement = array[1]
                let rootData = try JSONSerialization.data(withJSONObject: rootElement, options: [])
                let countryObjects = try decoder.decode([CountryObject].self, from: rootData)
                responseRes = countryObjects
            } catch let error {
                print(error)
                //errorMessage = error
            }
            }.resume()
        return responseRes
    }
}


