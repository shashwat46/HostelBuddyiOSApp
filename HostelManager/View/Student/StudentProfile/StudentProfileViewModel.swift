//
//  StudentProfileViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import Foundation
import SwiftUI

class StudentProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var hostelBlock: String = ""
    @Published var roomNumber: String = ""
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var successMessage: String? = nil

    func fetchUserProfile() {
        guard let userId = UserDefaults.standard.string(forKey: "userId"),
              let token = UserDefaults.standard.string(forKey: "authToken"),
              let url = URL(string: "https://hostel-buddy.onrender.com/api/users/\(userId)") else {
            isLoading = false
            errorMessage = "Invalid user ID"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error fetching profile: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    DispatchQueue.main.async {
                        self.name = json["username"] as? String ?? ""
                        self.email = json["email"] as? String ?? ""
                        self.phone = json["phoneNumber"] as? String ?? ""
                        self.hostelBlock = json["hostelBlock"] as? String ?? ""
                        self.roomNumber = json["roomNumber"] as? String ?? ""
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error parsing profile data"
                }
            }
        }.resume()
    }

    func updateUserProfile() {
        guard let userId = UserDefaults.standard.string(forKey: "userId"),
              let token = UserDefaults.standard.string(forKey: "authToken"),
              let url = URL(string: "https://hostel-buddy.onrender.com/api/users/\(userId)") else {
            errorMessage = "Invalid user ID or missing token"
            return
        }

        let requestBody: [String: Any] = [
            "username": name,
            "email": email,
            "phoneNumber": phone,
            "roomNumber": roomNumber,
            "hostelBlock": hostelBlock
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody) else {
            errorMessage = "Failed to encode request body"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error updating profile: \(error.localizedDescription)"
                }
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to update profile"
                }
                return
            }

            DispatchQueue.main.async {
                self.successMessage = "Profile updated successfully"
                self.fetchUserProfile()
                UserDefaults.standard.set(self.name, forKey: "username")
            }
        }.resume()
    }
}

