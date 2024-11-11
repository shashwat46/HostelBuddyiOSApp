//
//  StudentHomeModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import Foundation

// Announcement Struct
struct Announcement: Identifiable, Decodable {
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

//// Placeholder for Future Complaints Struct (Example)
//struct Complaint: Identifiable, Decodable {
//    let id: String
//    let description: String
//    let status: String
//    let createdAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case description, status, createdAt
//    }
//}

// StudentHomeModel to hold both Announcements and Complaints
class StudentHomeModel {
    // Announcements
    var announcements: [Announcement]
    
    // Complaints (to be populated later)
//    var complaints: [Complaint]
    
    init() {
        // Initialize with empty arrays
        self.announcements = []
//        self.complaints = []
    }
}

