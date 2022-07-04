//
//  ListModel.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 20/06/22.
//

import Foundation

struct GoalModel: Identifiable, Hashable {
    var id = UUID()
    var image: String?
    var category: Int
    var detail: String
    var description: String
    var status: Int
    var repeatArray : [Int]
    
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
    
    func getCategory(category: Int) -> String{
        switch category{
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
}


