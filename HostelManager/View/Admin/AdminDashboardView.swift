//
//  AdminDashboardView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import SwiftUI

struct AdminDashboardView: View {
    
    var body: some View {
        
        TabView {
            AdminHomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            AdminManageComplaintsView()
                .tabItem {
                    Label("Manage Complaints", systemImage: "exclamationmark.triangle")
                }
            AdminProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AdminDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AdminDashboardView()
    }
}

