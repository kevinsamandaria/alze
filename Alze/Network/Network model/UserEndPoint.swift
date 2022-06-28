//
//  UserEndPoint.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 26/06/22.
//

import Foundation

public enum UserAPI {
    case getUser(String)
    case postUser
    case patchUser(String)
    case deleteUSer(String)
}

extension UserAPI: EndPointType {
    var parameters: Parameters? {
        switch self {
        case .getUser(let token):
            return [URLQueryItem(name: "filterByFormula", value: "{token}=\"\(token)\"")]
        default:
            return nil
        }
    }
    
    var baseUrl: String {
        return "api.airtable.com"
    }
    
    var path: String {
        switch self {
        case .patchUser(let recordId), .deleteUSer(let recordId):
            return  "/v0/appLHN2xzL18TTxy7/UserTable/\(recordId)"
        default:
            return "/v0/appLHN2xzL18TTxy7/UserTable/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUser(_):
            return .get
        case .postUser:
            return .post
        case .patchUser(_):
            return .patch
        case .deleteUSer(_):
            return .delete
        }
    }
    
    var headers: HTTPHeaders? {
        switch self{
        case .postUser, .patchUser(_):
            return ["Content-Type": "application/json", "Authorization": "Bearer keyi3zJ66VmtGueDf"]
        default:
            return ["Authorization": "Bearer keyi3zJ66VmtGueDf"]

        }
    }
}
