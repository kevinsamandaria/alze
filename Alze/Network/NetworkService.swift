//
//  NetworkService.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 26/06/22.
//

import Foundation
typealias HTTPHeaders = [String: String]
typealias Parameters = [URLQueryItem]
typealias APIResponseBlock = ((_ response: Codable?,_ isSuccess: Bool, _ error: String)->())

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}
enum TableType: String{
    case goal = "GoalTable"
    case user = "ReminderTable"
    case reminder = "UserTable"
}

protocol EndPointType{
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
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
}

protocol NetworkDelegate: AnyObject {
    func onResponse(from endPoint: EndPointType?, result: Result<Data, NetworkError>)
}
