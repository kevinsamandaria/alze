//
//  GoalNetworkModel.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 26/06/22.
//

import Foundation
import SwiftUI

struct GoalRecords: Codable{
    var records: [GoalNetworkModel]
}

struct GoalNetworkModel: Codable {
    var id: String?
    var createdTime: String?
    var fields: GoalNetworkModelField
    
}

struct GoalNetworkModelField: Codable {
    var id: Int?
    var title: String?
    var category: String?
    var categoryId: Int?
    var status: String?
    var statusId: Int?
    var description: String?
    var createdDate: String?
    var notes: String?
    var achiveBy: String?
    var achiveById: Int?
    var userToken: String
    
    func getCategory(categoryId: Int) -> String{
        switch categoryId{
        case 0:
            return "Mobility"
        case 1:
            return "Cognition"
        case 2:
            return "Personal Care"
        case 3:
            return "Explore new Activity"
        default:
            return ""
        }
    }
    
    func getImage(categoryId: Int) -> String{
        switch categoryId{
        case 0:
            return "figure.walk"
        case 1:
            return "brain.head.profile"
        case 2:
            return "bed.double.fill"
        case 3:
            return "magnifyingglass"
        default:
            return ""
        }
    }
    
    func getStatus(status: Int) -> String{
        switch status{
        case 0:
            return "No achievement yet"
        case 1:
            return "Independent"
        case 2:
            return "With Assistance"
        default:
            return ""
        }
    }
}

