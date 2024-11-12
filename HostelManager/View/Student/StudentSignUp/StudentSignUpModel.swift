//
//  SignUpModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import Foundation

struct StudentSignUpModel: Encodable {
    let username: String
    let email: String
    let password : String
    let phoneNumber: String
    let roomNumber: String
    let hostelBlock: String
}

struct StudentSignUpResponse: Decodable {
    let message: String
    let token: String?
    let user: UserData?
    
    struct UserData: Decodable {
            let _id: String
            let username: String
            let email: String
            let phoneNumber: String
            let roomNumber: String
            let hostelBlock: String
            let createdAt: String
            let updatedAt: String
        }
}
