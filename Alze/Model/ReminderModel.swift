//
//  ReminderModel.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 04/07/22.
//

import Foundation

struct ReminderModel: Identifiable, Hashable {
    var id = UUID()
//    var image: String?
    var type: Int
    var status: Int
    var repeatArray: [Int]
    
    func getStatus(status: Int) -> String {
        switch status {
        case 0:
            return "Done"
        case 1:
            return "Not Done"
        default:
            return ""
        }
    }
    
    func getType(type: Int) -> String {
        switch type {
        case 0:
            return "Pill"
        case 1:
            return "tablet"
        default:
            return ""
        }
    }
}
