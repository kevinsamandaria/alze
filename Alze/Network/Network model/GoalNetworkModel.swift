//
//  GoalNetworkModel.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 26/06/22.
//

import Foundation

class GoalNetworkModel: Codable {
    var id: String = ""
    var createdTime: String = ""
    var fields: GoalNetworkModelField = GoalNetworkModelField()
}

class GoalNetworkModelField: Codable {
    var id: Int = 0
    var title: String = ""
    var category: String = ""
    var categoryId: Int = 0
    var status: String = ""
    var statusId: Int = 0
    var repeatDay: [String] = []
    var description: String = ""
    var createdDate: String = ""
    var achiveBy: String = ""
    var userToken: String = ""
}
