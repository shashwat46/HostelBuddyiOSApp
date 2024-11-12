//
//  AdminLoginView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 17/9/24.
//

import SwiftUI

struct AdminLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    
    @ObservedObject var viewModel = AdminLoginViewModel() // ViewModel for admin login
    
    enum NavigationDestination: Hashable {
        case adminSignUp
        case adminDashboard
    }
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
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
                    Text("Admin Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Email ID", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongEmail))
                    
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
                        viewModel.loginAdmin(email: email, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .bold()
                    
                    // Sign-Up button for navigation to AdminSignUpView
                    Button("Sign Up") {
                        navigationPath.append(NavigationDestination.adminSignUp)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .bold()
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .adminSignUp:
                    AdminSignUpView(navigationPath: $navigationPath)
                case .adminDashboard:
                    AdminDashboardView()
                }
            }
        }
        .onChange(of: viewModel.isLoginSuccessful) { isSuccessful in
            // Only trigger navigation if login is successful
            if isSuccessful {
                navigationPath.append(NavigationDestination.adminDashboard)
            }
        }
    }
}

struct AdminLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AdminLoginView()
    }
}


//import SwiftUI
//
//struct AdminLoginView: View {
//
//    @State private var email = ""
//    @State private var password = ""
//    @State private var wrongEmail = 0
//    @State private var wrongPassword = 0
//    @State private var showingDashboard = false
//    @State private var showingSignUp = false  // State for sign-up navigation
//
//    @ObservedObject var viewModel = AdminLoginViewModel() // ViewModel for admin login
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
//                    Text("Admin Login")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
//
//                    TextField("Email ID", text: $email)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//                        .border(.red, width: CGFloat(wrongEmail))
//
//                    SecureField("Password", text: $password)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//                        .border(.red, width: CGFloat(wrongPassword))
//
//                    // Displaying error message if there's any issue
//                    if !viewModel.errorMessage.isEmpty {
//                        Text(viewModel.errorMessage)
//                            .foregroundColor(.red)
//                            .padding()
//                    }
//
//                    // Login button
//                    Button("Login") {
//                        viewModel.loginAdmin(email: email, password: password)
//                    }
//                    .foregroundColor(.white)
//                    .frame(width: 300, height: 50)
//                    .background(Color.yellow)
//                    .cornerRadius(10)
//                    .bold()
//
//                    // Sign-Up button for navigation to AdminSignUpView
//                    Button("Sign Up") {
//                        showingSignUp = true
//                    }
//                    .foregroundColor(.white)
//                    .frame(width: 300, height: 50)
//                    .background(Color.yellow)
//                    .cornerRadius(10)
//                    .bold()
//
//                    // Navigation link to the SignUp view
//                    NavigationLink(destination: AdminSignUpView(), isActive: $showingSignUp) {
//                        EmptyView()
//                    }
//
//                    // NavigationLink for Dashboard after successful login
//                    NavigationLink(destination: AdminDashboardView(), isActive: $viewModel.isLoginSuccessful) {
//                        EmptyView()
//                    }
//                }
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//struct AdminLoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminLoginView()
//    }
//}



