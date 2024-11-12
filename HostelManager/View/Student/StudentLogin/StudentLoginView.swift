//
//  StudentLoginView.swift
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
    
    @ObservedObject var viewModel = LoginViewModel()  // ViewModel to manage login state
    
    enum NavigationDestination: Hashable {
        case studentSignUp
        case studentDashboard
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
                    
                    // Sign-Up button
                    Button("Sign Up") {
                        navigationPath.append(NavigationDestination.studentSignUp)
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
                case .studentSignUp:
                    StudentSignUpView(navigationPath: $navigationPath)
                case .studentDashboard:
                    StudentDashboardView()
                }
            }
        }
        .onChange(of: viewModel.isLoginSuccessful) { isSuccessful in
            if isSuccessful {
                navigationPath.append(NavigationDestination.studentDashboard)
            }
        }
    }
}

struct StudentLoginView_Previews: PreviewProvider {
    static var previews: some View {
        StudentLoginView()
    }
}


