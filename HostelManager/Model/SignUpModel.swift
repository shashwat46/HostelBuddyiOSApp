//
//  SignUpModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import Foundation

struct SignUpModel: Encodable {
    let username: String
    let email: String
    let phoneNumber: String
    let roomNumber: String
    let hostelBlock: String
}

