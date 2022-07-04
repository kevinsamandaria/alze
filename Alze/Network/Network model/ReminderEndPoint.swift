//
//  ReminderEndPoint.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 04/07/22.
//

import Foundation

public enum ReminderAPI {
    case getReminder(String)
    case getReminderType(String, Int, String)
    case postReminder
    case patchReminder(String)
    case deleteReminder(String)
}

extension ReminderAPI: EndPointType {
    var parameters: Parameters? {
        switch self {
        case .getReminder(let token):
            return [URLQueryItem(name: "filterByFormula", value: "{token}=\"\(token)\"")]
        case .getReminderType(let token ,let typeId, let date):
            return [URLQueryItem(name: "filterByFormula", value: "AND({categoryId}=\(typeId),{userToken}=\"\(token)\",{createdDate}=\"\(date)\")")]
        default:
            return nil
        }
    }
    
    var baseUrl: String {
        return "api.airtable.com"
    }
    
    var path: String {
        switch self{
        case .patchReminder(let recordId), .deleteReminder(let recordId):
            return "/v0/appLHN2xzL18TTxy7/GoalTable/\(recordId)"
        default:
            return "/v0/appLHN2xzL18TTxy7/GoalTable/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getReminder(_), .getReminderType(_, _,_):
            return .get
        case .postReminder:
            return .post
        case .patchReminder(_):
            return .patch
        case .deleteReminder(_):
            return .delete
        }
    }
    
    var headers: HTTPHeaders? {
        switch self{
        case .postReminder, .patchReminder(_):
            return ["Content-Type": "application/json", "Authorization": "Bearer keyi3zJ66VmtGueDf"]
        default:
            return ["Authorization": "Bearer keyi3zJ66VmtGueDf"]
        }
    }
}
