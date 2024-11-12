//
//  AdminDashboardView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import SwiftUI

struct AdminTabView: View {
    
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
            AnalyticsView()
                .tabItem {
                    Label("Profile", systemImage: "list.bullet.rectangle.portrait.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AdminDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AdminTabView()
    }
}

