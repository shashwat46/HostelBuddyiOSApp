//
//  StudentProfileView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 17/9/24.
//

import SwiftUI

struct StudentProfileView: View {
    @State private var name: String = "John Doe"
    @State private var registrationNumber: String = "123456"
    @State private var email: String = "johndoe@example.com"
    @State private var phone: String = "+1234567890"
    @State private var hostelBlock: String = "Block A"
    @State private var roomNumber: String = "101"
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: HEADER
            ZStack {
                Color.yellow
                    .frame(height: 140)
                    .ignoresSafeArea()
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Profile")
                            .font(.title.bold())
                        Text("View or Edit details")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(24)
                        .bold()
                }
                .padding(.horizontal)
                .padding(.top,50)
                
            }//Header ends
            
            // MARK: CONTENT
            VStack(alignment: .leading, spacing: 16) {
                // Profile Picture and Name
                HStack(alignment: .center, spacing: 16) {
                    Image(systemName: "person.circle.fill") // Placeholder for profile picture
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.yellow)
                    
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        // Additional text or information can go here
                    }
                }
                
                
                // Profile Details
                VStack(alignment: .leading, spacing: 16) {
                    ProfileTextField(title: "Name", text: $name)
                    ProfileTextField(title: "Registration Number", text: $registrationNumber)
                    ProfileTextField(title: "Email", text: $email)
                    ProfileTextField(title: "Phone", text: $phone)
                    ProfileTextField(title: "Hostel Block", text: $hostelBlock)
                    ProfileTextField(title: "Room Number", text: $roomNumber)
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ProfileTextField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            
            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 5)
        }
    }
}

struct StudentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StudentProfileView()
    }
}

