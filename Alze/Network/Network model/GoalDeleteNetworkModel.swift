//
//  GoalDeleteNetworkModel.swift
//  Alze
//
//  Created by Ridho Saputra on 04/07/22.
//

import Foundation

struct GoalDeleteRecords: Codable{
    var records: [GoalDeleteNetworkModel]
}

struct GoalDeleteNetworkModel: Codable {
    var id: String?
    var deleted: Bool?    
}
