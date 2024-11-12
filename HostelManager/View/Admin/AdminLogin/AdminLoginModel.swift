//
//  AdminLoginModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import Foundation

struct AdminLoginRequest: Codable {
    let email: String
    let password: String
}

struct AdminLoginResponse: Codable {
    let message: String
    let token: String?
    let adminId: String?
}

