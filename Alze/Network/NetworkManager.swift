//
//  AirtableManager.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 23/06/22.
//

import Foundation

typealias HTTPHeaders = [String: String]
//class Connectivity{
//    class func isConnectToInternet() -> Bool{
//        var status: Bool = false
//        let monitor = NWPathMonitor()
//        let queue = DispatchQueue(label: "InternetConnectionMonitor")
//
//        monitor.pathUpdateHandler = { pathUpdateHandler in
//            if pathUpdateHandler.status == .satisfied{
//                status = true
//            }else{
//                status = false
//
//            }
//        }
//        monitor.start(queue: queue)
//        monitor.cancel()
//        print(status)
//        return status
//    }
//
//}
enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
enum Table: String{
    case goal = "Goal"
    case user = "Reminder"
    case reminder = "User"
}

enum NetworkError:String,Error{
    case missingUrl = "URL is missing"
        case decodingFailed = "Decoding failed"
        case authenticationError = "You need to be authenticated first or you not in Academy"
        case badRequest = "Bad request"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
        case userExist = "User already exist"
        case expiredToken = "Expired Token"
//    enum RequestError{
//        case invalidRequest(URLRequest)
//    }
}

class NetworkManager: NSObject{
    //MARK: - Singleton
    static let shared: NetworkManager = NetworkManager()
    let apiKey = "Bearer keyi3zJ66VmtGueDf"
    let apiBaseId = "appLHN2xzL18TTxy7"
}
