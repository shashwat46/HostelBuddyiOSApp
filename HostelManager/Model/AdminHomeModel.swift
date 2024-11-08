
//
//  AdminHomeModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 19/9/24.
//

import Foundation

// AnnouncementAdmin Struct
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

// AdminHomeModel to hold Announcements for Admin
class AdminHomeModel {
    var announcements: [AnnouncementAdmin]
    
    init() {
        self.announcements = []
    }
}

