//
//  AdminLoginView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 17/9/24.
//

import SwiftUI

struct StudentLoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingDashboard = false
    @State private var showingSignUp = false
    
    @ObservedObject var viewModel = LoginViewModel()  // ViewModel to manage login state
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.50))
                Circle()
                    .scale(1.2)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Hostel Buddy")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("VIT Email ID", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    // Displaying error message if there's any issue
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    // Login button
                    Button("Login") {
                        viewModel.loginUser(email: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .bold()
                    
                    // Navigation to sign-up
                    Button("Sign Up") {
                        showingSignUp = true
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .bold()
                    
                    // Navigation link to the SignUp view
                    NavigationLink(destination: StudentSignUpView(), isActive: $showingSignUp) {
                        EmptyView()
                    }
                    
                    // NavigationLink for Dashboard after successful login
                    NavigationLink(destination: StudentDashboardView(), isActive: $viewModel.isLoginSuccessful) {
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct StudentLoginView_Previews: PreviewProvider {
    static var previews: some View {
        StudentLoginView()
    }
}


//import SwiftUI
//
//struct StudentLoginView: View {
//
//    @State private var username = ""
//    @State private var password = ""
//    @State private var wrongUsername = 0
//    @State private var wrongPassword = 0
//    @State private var showingDashboard = false
//    @State private var showingSignUp = false
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.yellow
//                    .ignoresSafeArea()
//                Circle()
//                    .scale(1.7)
//                    .foregroundColor(.white.opacity(0.50))
//                Circle()
//                    .scale(1.2)
//                    .foregroundColor(.white)
//
//                VStack {
//                    Text("Hostel Buddy")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
//
//                    TextField("VIT Email ID", text: $username)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//                        .border(.red, width: CGFloat(wrongUsername))
//
//                    SecureField("Password", text: $password)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//                        .border(.red, width: CGFloat(wrongPassword))
//
//                    NavigationLink(destination: StudentDashboardView(), isActive: $showingDashboard) {
//                        Button("Login") {
//                            showingDashboard = true
//                        }
//                        .foregroundColor(.white)
//                        .frame(width: 300, height: 50)
//                        .background(Color.yellow)
//                        .cornerRadius(10)
//                        .bold()
//                    }
//
//                    Button("Sign Up") {
//                        showingSignUp = true
//                    }
//                    .foregroundColor(.white)
//                    .frame(width: 300, height: 50)
//                    .background(Color.yellow)
//                    .cornerRadius(10)
//                    .bold()
//
//                    NavigationLink(destination: StudentSignUpView(), isActive: $showingSignUp) {
//                        EmptyView() // This is necessary to work with NavigationLink
//                    }
//
//                }
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//struct StudentLoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentLoginView()
//    }
//}
