//
//  ReminderNetworkModel.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 26/06/22.
//

import Foundation

struct ReminderRecords: Codable{
    var records: [ReminderNetworkModel]
}

struct ReminderNetworkModel: Codable {
    var id: String = ""
    var createdTime: String = ""
    var fields: ReminderNetworkModelField
}

struct ReminderNetworkModelField: Codable {
    var id: Int?
    var title: String?
    var type: String?
    var typeId: Int?
    var days: [String]?
    var time: String?
    var medicineTaken: String?
    var repeatDay: [String]?
    var status : String?
    var statusId: Int?
    var userToken: String
    var createdAt: String?
    
    func getType(typeId: Int) -> String {
        switch typeId {
        case 0:
            return "Pill"
        case 1:
            return "Tablet"
        default:
            return ""
        }
    }
    
    func getStatus(status: Int) -> String{
        switch status {
        case 0:
            return "Done"
        case 1:
            return "Not Done"
        default:
            return ""
        }
    }
}
