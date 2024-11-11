//
//  StudentLoginModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 11/11/24.
//

import Foundation

struct StudentLoginRequest: Codable {
    let email: String
    let password: String
}


struct StudentLoginResponse: Codable {
    let message: String
    let token: String?
}
