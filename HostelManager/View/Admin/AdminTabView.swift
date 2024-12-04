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
                .accentColor(.yellow)
            AdminManageComplaintsView()
                .tabItem {
                    Label("Manage Complaints", systemImage: "exclamationmark.triangle")
                }
                .tint(.red)
            AnalyticsView()
                .tabItem {
                    Label("Analytics", systemImage: "chart.line.uptrend.xyaxis")
                }
                .tint(.yellow)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AdminDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AdminTabView()
    }
}

