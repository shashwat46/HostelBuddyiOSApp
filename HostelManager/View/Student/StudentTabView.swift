//
//  StudentDashboardView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 17/9/24.
//

import SwiftUI

struct StudentDashboardView: View {
    
    var body : some View{
       
            
            TabView{
                StudentHomeView()
                    .tabItem{
                        Label("Home", systemImage: "house")
                            
                    }
                StudentComplaintBookView()
                    .tabItem{
                        Label("Complaint Book", systemImage: "book")
                            
                    }
                StudentProfileView()
                    .tabItem{
                        Label("Profile", systemImage: "person")
                            
                    }
            }
            .accentColor(.yellow)
            .navigationBarBackButtonHidden(true)
        
    }
}


struct StudentDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        StudentDashboardView()
    }
}
