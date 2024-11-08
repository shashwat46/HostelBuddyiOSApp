//
//  AdminLoginView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 17/9/24.
//

import SwiftUI

struct AdminLoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingDashboard = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.yellow
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.50))
                Circle()
                    .scale(1.2)
                    .foregroundColor(.white)
                
                VStack{
                    Text("Hostel Buddy")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Official Email ID", text : $username)
                        .padding()
                        .frame(width: 300, height : 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text : $password)
                        .padding()
                        .frame(width: 300, height : 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(wrongPassword))
                    
                    NavigationLink(destination: AdminDashboardView(), isActive: $showingDashboard) {
                        Button("Login") {
                            showingDashboard = true
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .bold()
                    }
//                    Button("Login"){
//
//                    }
//                    .foregroundColor(.white)
//                    .frame(width: 300, height: 50)
//                    .background(Color.yellow)
//                    .cornerRadius(10)
//                    .bold()
                    
                    
                }
            }
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AdminLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AdminLoginView()
    }
}



