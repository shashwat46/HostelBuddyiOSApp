//
//  StudentComplaintModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 11/11/24.
//

import Foundation

struct StudentComplaintModel: Identifiable, Codable {
    let id: String
    let user: User
    let category: String
    let description: String
    let status: Status
    let createdAt: String
    let updatedAt: String
    let resolvedAt: String?
    
    struct User: Codable {
        let id: String
        let username: String
        let email: String
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case username
            case email
        }
    }
    
    enum Status: String, Codable {
        case resolved = "resolved"
        case pending = "pending"
        case inProgress = "in progress"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user
        case category
        case description
        case status
        case createdAt
        case updatedAt
        case resolvedAt
    }
}

