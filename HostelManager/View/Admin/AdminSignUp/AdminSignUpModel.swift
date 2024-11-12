//
//  AdminSignUpModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import Foundation

struct AdminSignUpModel: Encodable {
    let username: String
    let email: String
    let password: String
    let role: String
}

struct AdminSignUpResponse: Decodable {
    let message: String
    let token: String?
    let admin: AdminData?
    
    struct AdminData: Decodable {
        let _id: String
        let username: String
        let email: String
        let role: String
        let createdAt: String
        let updatedAt: String
    }
}

