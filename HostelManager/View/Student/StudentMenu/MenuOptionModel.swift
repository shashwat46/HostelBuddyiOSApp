//
//  MenuOptionModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 16/11/24.
//

import Foundation

enum MenuOptionModel : Int, CaseIterable {
    case profile
    case notifications
    case help
    
    var title: String{
        switch self{
        case .profile:
            return "Profile"
            
        case .notifications:
            return "Notifications"
            
        case .help:
            return "Help"
        }
    }
    
    var systemImageName: String{
        switch self{
        case .profile:
            return "person"
        case .notifications:
            return "bell"
        case .help:
            return "questionmark.circle"
            
        }
    }
}

extension MenuOptionModel: Identifiable{
    var id: Int {return self.rawValue}
}
