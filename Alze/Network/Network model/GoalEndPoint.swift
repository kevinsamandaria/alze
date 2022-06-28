//
//  GoalEndPoint.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 28/06/22.
//

import Foundation
public enum GoalAPI {
    case getGoal(String)
    case getGoalCategory(String, Int, String)
    case postGoal
    case patchGoal(String)
    case deleteGoal(String)
}

extension GoalAPI: EndPointType {
    var parameters: Parameters? {
        switch self {
        case .getGoal(let token):
            return [URLQueryItem(name: "filterByFormula", value: "{token}=\"\(token)\"")]
        case .getGoalCategory(let token, let categoryId, let date):
            return [URLQueryItem(name: "filterByFormula", value: "AND({categoryId}=\(categoryId),{userToken}=\"\(token)\",{createdDate}=\"\(date)\")")]
        default:
            return nil
        }
    }
    
    var baseUrl: String {
        return "api.airtable.com"
    }
    
    var path: String {
        switch self {
        case .patchGoal(let recordId), .deleteGoal(let recordId):
            return  "/v0/appLHN2xzL18TTxy7/GoalTable/\(recordId)"
        default:
            return "/v0/appLHN2xzL18TTxy7/GoalTable/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getGoal(_), .getGoalCategory(_, _,_):
            return .get
        case .postGoal:
            return .post
        case .patchGoal(_):
            return .patch
        case .deleteGoal(_):
            return .delete
        }
    }
    
    var headers: HTTPHeaders? {
        switch self{
        case .postGoal, .patchGoal(_):
            return ["Content-Type": "application/json", "Authorization": "Bearer keyi3zJ66VmtGueDf"]
        default:
            return ["Authorization": "Bearer keyi3zJ66VmtGueDf"]
        }
    }
}
