//
//  AdminProfileView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import SwiftUI

struct AdminProfileView: View {
    @State private var name: String = "Admin Name"
    @State private var employeeId: String = "E123456"
    @State private var email: String = "admin@example.com"
    @State private var phone: String = "+0987654321"
    @State private var department: String = "Administration"
    @State private var officeLocation: String = "Block B, Room 202"
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: HEADER
            ZStack {
                Color.yellow
                    .frame(height: 140)
                    .ignoresSafeArea()
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Admin Profile")
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
                
            } // Header ends
            
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
                    ProfileTextFieldAdmin(title: "Name", text: $name)
                    ProfileTextFieldAdmin(title: "Employee ID", text: $employeeId)
                    ProfileTextFieldAdmin(title: "Email", text: $email)
                    ProfileTextFieldAdmin(title: "Phone", text: $phone)
                    ProfileTextFieldAdmin(title: "Department", text: $department)
                    ProfileTextFieldAdmin(title: "Office Location", text: $officeLocation)
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ProfileTextFieldAdmin: View {
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

struct AdminProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AdminProfileView()
    }
}

