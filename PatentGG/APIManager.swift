
import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([NSAttributedString.Key:AnyObject]?, HTTPURLResponse?, Error?)-> Void

protocol JSONDecodable{
    init?(JSON: [NSAttributedString.Key: AnyObject])
}

protocol FinalURLPoint {//to combine full request name
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

enum APIResult<T> {//result of the wotk with API
    case Success(T)
    case Failure(Error)
}

protocol APIManager{
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
}


extension APIManager {//this one, for checking all the possible errors,answer,etc.
    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask{
        let dataTask = session.dataTask(with: request) { (data, response, error) in
        guard let HTTPResponse = response as? HTTPURLResponse else {
            let userInfo = [
                NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
            ]
            let error = NSError(domain: WDBNetworkingErrorDomain, code: 100, userInfo: userInfo)
            completionHandler(nil, nil, error)
            return
        }
        if data == nil {
            if let error = error {
                completionHandler(nil, HTTPResponse, error)
            }
        } else {
            switch HTTPResponse.statusCode {
            case 200:
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [NSAttributedString.Key: AnyObject]
                    completionHandler(json, HTTPResponse, nil)
                }catch let error as NSError{
                    completionHandler(nil, HTTPResponse, error)
                }
            default:
                print("We have got response status \(HTTPResponse.statusCode)")
            }
          }
        }
        return dataTask
    }
    
    func fetch<T: Decodable>(request: URLRequest, parse: @escaping ([NSAttributedString.Key:AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void){// function of deserializing JSON,lol
        let dataTask = JSONTaskWith(request: request) { (json, response, error ) in
            guard let json = json else{
                if let error = error {
                    completionHandler(.Failure(error))
                }
                return
            }
            if let value = parse(json) {
                completionHandler(.Success(value))
            } else {
                let error = NSError(domain: WDBNetworkingErrorDomain, code: 200, userInfo: nil)
                completionHandler(.Failure(error))
            }
        }
        dataTask.resume()
    }
}

