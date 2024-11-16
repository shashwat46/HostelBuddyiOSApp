//
//  StudentDashboardView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 17/9/24.
//

import SwiftUI

struct StudentDashboardView: View {
    
    @State private var selectedTab = 0
    @State private var showMenu = false
    
    private let tabData: [Int : (title: String, subtitle : String)] =
    [0: ("Dashboard", "Your latest updates"),
     1: ("Complaint Book", "Your complaint History"),
     2: ("Your Profile", "View or edit details")
    ]
    
    var body : some View {
        ZStack {
            VStack(spacing: 0) {
                //Header
                ZStack {
                    Color.yellow
                        .ignoresSafeArea()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(tabData[selectedTab]!.title)
                                .font(.title.bold())
                            Text(tabData[selectedTab]!.subtitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        
                        Spacer()
                        
                        Button {
                            showMenu.toggle()
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .foregroundColor(.gray)
                                .padding(24)
                                .bold()
                        }

                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: 100)
                
                //Tabs
                TabView(selection : $selectedTab){
                    StudentHomeView().tag(0)
                        .tabItem{
                            Label("Home", systemImage: "house")
                                
                        }
                    StudentComplaintBookView().tag(1)
                        .tabItem{
                            Label("Complaint Book", systemImage: "book")
                                
                        }
                    StudentProfileView().tag(2)
                        .tabItem{
                            Label("Profile", systemImage: "person")
                                
                        }
                }
                .accentColor(.yellow)
                .navigationBarBackButtonHidden(true)
                
            }
            
            StudentMenuView(isShowingMenu: $showMenu)
        }
    }

}


struct StudentDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        StudentDashboardView()
    }
}
