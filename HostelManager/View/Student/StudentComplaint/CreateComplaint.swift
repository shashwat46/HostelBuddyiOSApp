//
//  CreateComplaint.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import SwiftUI

struct CreateComplaintSheet: View {
    @Binding var isPresented: Bool
    @State private var category = "Electrical Issues"
    @State private var description = ""
    @State private var isSubmitting = false

    let categories = ["Electrical Issues", "Mess Issues", "Furniture Issues", "Washroom Maintenance", "Harassment", "Other"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Complaint Details")) {
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    TextEditor(text: $description)
                        .frame(height: 100)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.vertical)
                        .foregroundColor(.primary)
                }
                
                Button(action: submitComplaint) {
                    if isSubmitting {
                        ProgressView()
                    } else {
                        Text("Submit Complaint")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .disabled(isSubmitting || description.isEmpty)
            }
            .navigationBarTitle("Create Complaint", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
    
    private func submitComplaint() {
        guard !category.isEmpty, !description.isEmpty else { return }
        isSubmitting = true
        
        // Fetch userId from UserDefaults
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        print(userId.isEmpty ? "empty" : userId)
        print(category)
        print(description)
        let requestBody: [String: Any] = [
            "user": userId,
            "category": category,
            "description": description
        ]
        
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/complaints/create"),
              let httpBody = try? JSONSerialization.data(withJSONObject: requestBody) else {
            isSubmitting = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isSubmitting = false
            }
            if let error = error {
                print("Error creating complaint: \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse {
                    print("Response status code: \(response.statusCode)")
                    if (200...299).contains(response.statusCode) {
                        print("Complaint created successfully")
                        DispatchQueue.main.async {
                            self.isPresented = false // Dismiss the sheet on success
                        }
                    } else {
                        print("Failed to create complaint - Status code: \(response.statusCode)")
                    }
                }
                
                if let data = data {
                    // Print the server response for debugging purposes
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response data: \(responseString)")
                    }
                }
        }.resume()
    }
}

//shashwatking2001@gmail.com
