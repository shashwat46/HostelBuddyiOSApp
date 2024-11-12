//
//  AdminHomeModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import Foundation

// Announcement Struct for Admin
struct AnnouncementAdmin: Identifiable, Decodable {
    let id: String
    let title: String
    let content: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, content, createdAt, updatedAt
    }
}


// User Struct for Complaints
struct AdminUserModel: Decodable {
    let id: String
    let username: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, email
    }
}
