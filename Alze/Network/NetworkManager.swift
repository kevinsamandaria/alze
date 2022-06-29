//
//  AirtableManager.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 23/06/22.
//

import Foundation
import SwiftUI
class Connectivity{
    class func isConnectToInternet() -> Bool{
        return NetworkMonitor().isConnect
    }
    
}
class NetworkManager: NSObject{
    //MARK: - Singleton
    static let shared: NetworkManager = NetworkManager()
    let apiBaseUrl = "https://api.airtable.com/v0/"
    let apiKey = "Bearer keyi3zJ66VmtGueDf"
    let apiBaseId = "appLHN2xzL18TTxy7"
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: nil)
    }()
    
    var endPoint: EndPointType?
    var networkDelegate: NetworkDelegate?
    
    func getUserData(with Table: TableType, endPoint: EndPointType, completionHandler: @escaping(UserNetworkModelField) -> Void){
        self.endPoint = endPoint
        
        // Construct a URL by assigning its parts to a URLComponents value
        var components = URLComponents()
        components.scheme = "https"
        components.host = endPoint.baseUrl
        components.path = endPoint.path
        components.queryItems = endPoint.parameters
        
        guard let url = components.url else{
            networkDelegate?.onResponse(from: nil, result: .failure(.missingUrl))
            return
        }
        
        // Create the request to url
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        
        // Set the headers to request
        if let headers = endPoint.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do{
                    let finalData = try JSONDecoder().decode(UserRecords.self, from: data)
                    guard let userData = finalData.records.first?.fields else {
                        return
                    }
                    completionHandler(userData)
                }catch(let error){
                    print("Error: \(error.localizedDescription)")
                }
            }else{
                print("No Data")
            }
        }.resume()
        
    }
    
    func registerUser(with Table: TableType, endPoint: EndPointType, data: UserNetworkModel, completionHandler: @escaping(UserNetworkModel) -> Void){
        self.endPoint = endPoint
        
        // Construct a URL by assigning its parts to a URLComponents value
        var components = URLComponents()
        components.scheme = "https"
        components.host = endPoint.baseUrl
        components.path = endPoint.path
        
        guard let url = components.url else{
            networkDelegate?.onResponse(from: nil, result: .failure(.missingUrl))
            return
        }
        
        // Create the request to url
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        // Set the headers to request
        if let headers = endPoint.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Set httpBody
        guard let httpBody = try? JSONEncoder().encode(data) else{
            print("Invalid HttpBody")
            return
        }
        
        request.httpBody = httpBody
        print("request \(request)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do{
                    let finalData = try JSONDecoder().decode(UserNetworkModel.self, from: data)
                    completionHandler(finalData)
                }catch(let error){
                    print("Error: \(error.localizedDescription)")
                }
            }else{
                print("No Data")
            }
        }.resume()
    }
    
    func getUserGoal(with Table: TableType, endPoint: EndPointType, completionHandler: @escaping([GoalNetworkModel]) -> Void){
        self.endPoint = endPoint
        
        // Construct a URL by assigning its parts to a URLComponents value
        var components = URLComponents()
        components.scheme = "https"
        components.host = endPoint.baseUrl
        components.path = endPoint.path
        components.queryItems = endPoint.parameters
        
        guard let url = components.url else{
            networkDelegate?.onResponse(from: nil, result: .failure(.missingUrl))
            return
        }
        
        // Create the request to url
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        // Set the headers to request
        if let headers = endPoint.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do{
                    let finalData = try JSONDecoder().decode(GoalRecords.self, from: data)
                    completionHandler(finalData.records)
                }catch(let error){
                    print("Error: \(error.localizedDescription)")
                }
            }else{
                print("No Data")
            }
        }.resume()
    }
    
    func postUserGoal(with Table: TableType, endPoint: EndPointType, data: GoalNetworkModel, completionHandler: @escaping(GoalNetworkModel) -> Void){
        self.endPoint = endPoint
        
        // Construct a URL by assigning its parts to a URLComponents value
        var components = URLComponents()
        components.scheme = "https"
        components.host = endPoint.baseUrl
        components.path = endPoint.path
        
        guard let url = components.url else{
            networkDelegate?.onResponse(from: nil, result: .failure(.missingUrl))
            return
        }
        
        // Create the request to url
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        // Set the headers to request
        if let headers = endPoint.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Set httpBody
        guard let httpBody = try? JSONEncoder().encode(data) else{
            print("Invalid HttpBody")
            return
        }
        
        request.httpBody = httpBody
        print("request \(request)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do{
                    let finalData = try JSONDecoder().decode(GoalNetworkModel.self, from: data)
                    completionHandler(finalData)
                }catch(let error){
                    print("Error: \(error.localizedDescription)")
                }
            }else{
                print("No Data")
            }
        }.resume()
    }
}

extension NetworkManager: URLSessionDelegate{
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
                  completionHandler(.cancel)
                  return
              }
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let endPoint = self.endPoint else {
            self.networkDelegate?.onResponse(from: nil, result: .failure(NetworkError.failed))
            return
        }
        self.networkDelegate?.onResponse(from: endPoint, result: .success(data))
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let _ = error {
            self.networkDelegate?.onResponse(from: nil, result: .failure(NetworkError.failed))
        }
    }
}
