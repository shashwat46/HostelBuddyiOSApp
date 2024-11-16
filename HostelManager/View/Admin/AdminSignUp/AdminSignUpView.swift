//
//  AdminSignUpView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import SwiftUI

struct AdminSignUpView: View {
    
    @StateObject private var viewModel = AdminSignUpViewModel()
    @Binding var navigationPath: NavigationPath
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var selectedRole = "admin" // Default role
    
    @State private var wrongConfirmPassword = false
    @State private var errorMessage = ""
    
    let roles = ["admin", "warden"]
    
    @State private var isSignUpSuccessful = false // State for navigation
    
    var body: some View {
 
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                Circle()
                    .scale(1.9)
                    .foregroundColor(.white.opacity(0.50))
                Circle()
                    .scale(1.6)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Admin Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Picker("Role", selection: $selectedRole) {
                        ForEach(roles, id: \.self) { role in
                            Text(role.capitalized)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .accentColor(Color.orange.opacity(0.7))
                    .bold()
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: wrongConfirmPassword ? 1 : 0)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button("Sign Up") {
                        if password == confirmPassword {
                            viewModel.register(username: username, email: email, password: password, role: selectedRole)
                        } else {
                            wrongConfirmPassword = true
                            errorMessage = "Passwords do not match!"
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .bold()
                    
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $isSignUpSuccessful) {
                AdminLoginView()
            }
        
        .onReceive(viewModel.$isSignUpSuccessful) { isSuccessful in
            if isSuccessful {
                isSignUpSuccessful = true
                navigationPath.removeLast()
            }
        }
        .onReceive(viewModel.$errorMessage) { message in
            errorMessage = message
        }
    }
}

