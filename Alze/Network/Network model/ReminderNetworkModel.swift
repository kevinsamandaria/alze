//
//  ReminderNetworkModel.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 26/06/22.
//

import Foundation

struct ReminderNetworkModel: Codable {
    var id: String = ""
    var createdTime: String = ""
    var fields: ReminderNetworkModelField = ReminderNetworkModelField()
}

struct ReminderNetworkModelField: Codable {
    var id: Int = 0
    var title: String = ""
    var type: String = ""
    var days: [String] = []
    var time: String = ""
    var medicineTaken: String = ""
    var repeatDay: [String] = []
    var status : String = ""
    var statusId: Int = 0
    var userToken: String = ""
    var createdAt: String = ""
}
