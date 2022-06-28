//
//  GoalNetworkModel.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 26/06/22.
//


import Foundation

struct UserRecords: Codable{
    var records: [UserNetworkModel]
}
struct UserNetworkModel: Codable {
    var id: String?
    var createdTime: String?
    var fields: UserNetworkModelField
    
}

struct UserNetworkModelField: Codable {
    var id: Int?
    var fullname: String
    var email: String
    var token: String
    var created: String?
}

struct AppleCredential: Codable{
    var id_token : String
    
}

