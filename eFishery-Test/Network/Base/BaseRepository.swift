//
//  BaseRepository.swift
//  eFishery-Test
//
//  Created by ACI 2 on 24/10/22.
//

import Foundation
import SwiftUI

protocol ApiConfig {
    var baseUrl: String { get }
    var path: String { get }
    var parameter: [String: Any] { get }
    var header: [String: String] { get }
    var method: HttpMethod { get }
    var body: [[String: Any]] { get }
}
enum HttpMethod: String {
    case post  = "POST"
    case get   = "GET"
    case del   = "DELETE"
    case put   = "PUT"
    case patch = "PATCH"
}
extension ApiConfig {
    var uuid: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    var timestamp: String {
        return "\(Int64(Date().timeIntervalSince1970 * 1000))"
    }
    var transmissionDate: String {
        let date = Date()
        let calendar = Calendar.current
        let years = calendar.component(.year, from: date)
        let mounth = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return "\(years)-\(mounth)-\(day) 00:00:00.000+07:00"
    }
}
class BaseRepository {
    func urlRequestr<T: Codable>(route: ApiConfig, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var completeUrl = route.baseUrl + route.path
        var urlRequest = URLRequest(url: URL(string: completeUrl)!, timeoutInterval: 60)
        urlRequest.allHTTPHeaderFields = route.header
        urlRequest.httpMethod = route.method.rawValue
        if route.method == .get {
            completeUrl += stringToHttpParameters(dict: route.parameter)
            urlRequest.url = URL(string: completeUrl)!
        } else {
            //if route.header.values.contains(ContentType.urlEncoded) {
            //urlRequest.httpBody = getPostEncodedString(params: route.body).data(using: .utf8)
            //} else {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: route.body, options: .prettyPrinted)
            //}
        }
        
        
        //#if DEVELOPMENT
        print("--> ------------------------------- START -----------------------------------------")
        print("--> Accessing URL: \(completeUrl)")
        print("--> Header: \(route.header)")
        print("--> Method: \(route.method.rawValue)")
        print("--> Body: \(route.method != .get ? route.body: [])")
        print("--> --------------------------------- END -----------------------------------------")
        //#endif

        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let errr = error {
                    if errr.localizedDescription.contains("connection") {
                        //#if DEVELOPMENT
                        print("--> (Error) - \(completeUrl), Error nill network connection.")
                        //#endif
                        completion(.failure(.badConnection))
                    } else {
                        //#if DEVELOPMENT
                        print("--> (Error) - \(completeUrl), Error nill description \(errr.localizedDescription).")
                        //#endif
                        completion(.failure(.badError))
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    guard let dta = data else {
                        //#if DEVELOPMENT
                        print("--> (Error) - \(completeUrl)(\(response.statusCode)) - Data Response nill.")
                        //#endif
                        completion(.failure(.badData))
                        return
                    }
                    
                    let statsCode = !(200...299).contains(response.statusCode)
                    //#if DEVELOPMENT
                    print("-->\(statsCode ? " (Error) - ": " ")Response Http Code: \(route.baseUrl + route.path)(\(response.statusCode))")
                    print("-->\(statsCode ? " (Error) - ": " ")Response Http Data: \(String(data: dta, encoding: .utf8)!)")
                    //#endif
                    
                    if statsCode {
                        completion(.failure(.badStatusCode))
                        return
                    } else {
                        if let dt = dta.decodeTo(T.self) {
                            //#if DEVELOPMENT
                            print("--> ~Decode Success~")
                            //#endif
                            completion(.success(dt))
                        } else {
                            //#if DEVELOPMENT
                            print("--> (Error) ~Decode Failed!~")
                            //#endif
                            completion(.failure(.decodeFail))
                            return
                        }
                    }
                } else {
                    //#if DEVELOPMENT
                    print("--> (Error) - \(completeUrl) - (HTTPURLResponse error!)")
                    //#endif
                    completion(.failure(.badURL))
                }
            }
        }
        .resume()
    }
    private func getPostEncodedString(params: [String:Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    private func stringToHttpParameters(dict: Dictionary<String, Any>) -> String {
        if dict.isEmpty {
            return ""
        }
        
        var parametersString = ""
        for (ky, vale) in dict {
            parametersString = parametersString + "\(ky)=\(vale)&"
        }
        parametersString.remove(at: parametersString.index(before: parametersString.endIndex))
        //parametersString = parametersString.substring(to: parametersString.index(before: parametersString.endIndex))
        return "?" + parametersString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

enum NetworkError: Error {
    case badURL
    case badConnection
    case badError
    case badData
    case badStatusCode
    case decodeFail
}
