//
//  StudentSignUpView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import SwiftUI

struct StudentSignUpView: View {
    @StateObject private var viewModel = StudentSignUpViewModel()
    @Binding var navigationPath: NavigationPath
    @State private var username = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var roomNumber = ""
    @State private var hostelBlock = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var wrongConfirmPassword = false
    @State private var errorMessage = ""
    
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
                Text("Student Sign Up")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
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
                
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                TextField("Room Number", text: $roomNumber)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                TextField("Hostel Block", text: $hostelBlock)
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
                        viewModel.register(username: username, email: email, password: password, phoneNumber: phoneNumber, roomNumber: roomNumber, hostelBlock: hostelBlock)
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
        .onReceive(viewModel.$isSignUpSuccessful) { isSuccessful in
            if isSuccessful {
                isSignUpSuccessful = true
                navigationPath.removeLast() // Navigate back to login
            }
        }
        .onReceive(viewModel.$errorMessage) { message in
            errorMessage = message
        }
    }
}

struct StudentSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        StudentSignUpView(navigationPath: .constant(NavigationPath()))
    }
}

//import SwiftUI
//
//struct StudentSignUpView: View {
//
//    @Environment(\.presentationMode) var presentationMode
//    @StateObject private var viewModel = StudentSignUpViewModel()
//
//    @State private var username = ""
//    @State private var email = ""
//    @State private var phoneNumber = ""
//    @State private var roomNumber = ""
//    @State private var hostelBlock = ""
//    @State private var password = ""
//    @State private var confirmPassword = ""
//
//    @State private var wrongConfirmPassword = false
//    @State private var errorMessage = ""
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.yellow
//                    .ignoresSafeArea()
//                Circle()
//                    .scale(1.9)
//                    .foregroundColor(.white.opacity(0.50))
//                Circle()
//                    .scale(1.6)
//                    .foregroundColor(.white)
//
//                VStack {
//                    Text("Sign Up")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
//
//                    TextField("Username", text: $username)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//
//                    TextField("Email", text: $email)
//                        .keyboardType(.emailAddress)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//
//                    TextField("Phone Number", text: $phoneNumber)
//                        .keyboardType(.phonePad)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//
//                    TextField("Room Number", text: $roomNumber)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//
//                    TextField("Hostel Block", text: $hostelBlock)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//
//                    SecureField("Password", text: $password)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//
//                    SecureField("Confirm Password", text: $confirmPassword)
//                        .padding()
//                        .frame(width: 300, height: 50)
//                        .background(Color.black.opacity(0.05))
//                        .cornerRadius(10)
//                        .border(.red, width: wrongConfirmPassword ? 1 : 0)
//
//                    if !errorMessage.isEmpty {
//                        Text(errorMessage)
//                            .foregroundColor(.red)
//                            .padding()
//                    }
//
//                    Button("Sign Up") {
//                        if password == confirmPassword {
//                            viewModel.register(username: username, email: email, password: password, phoneNumber: phoneNumber, roomNumber: roomNumber, hostelBlock: hostelBlock)
//                        } else {
//                            wrongConfirmPassword = true
//                            errorMessage = "Passwords do not match!"
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .frame(width: 300, height: 50)
//                    .background(Color.yellow)
//                    .cornerRadius(10)
//                    .bold()
//                }
//            }
//            .navigationBarHidden(true)
//        }
//        .onReceive(viewModel.$isSignUpSuccessful) { isSuccessful in
//            if isSuccessful {
//                presentationMode.wrappedValue.dismiss() // Go back to login page
//            }
//        }
//        .onReceive(viewModel.$errorMessage) { message in
//            errorMessage = message
//        }
//    }
//}
//
//struct StudentSignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentSignUpView()
//    }
//}

