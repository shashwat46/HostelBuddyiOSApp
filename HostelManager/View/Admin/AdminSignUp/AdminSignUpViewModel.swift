//
//  AdminSignUpViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import Foundation
import Combine

class AdminSignUpViewModel: ObservableObject {
    @Published var isSignUpSuccessful = false
    @Published var errorMessage = ""
    private var cancellables = Set<AnyCancellable>()
    
    func register(username: String, email: String, password: String, role: String) {
        let signUpData = AdminSignUpModel(username: username, email: email, password: password, role: role)
        
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/admins/register") else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(signUpData)
            request.httpBody = jsonData
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to encode data"
            }
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .tryMap { data in
                // For debugging purposes: print the raw data response
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    print("Raw Response JSON: \(json)")
                }
                return data
            }
            .decode(type: AdminSignUpResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = "Failed to sign up: \(error.localizedDescription)"
                    self?.isSignUpSuccessful = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                // Handle response logic carefully
                if !response.message.isEmpty, let admin = response.admin, let token = response.token {
                    self?.isSignUpSuccessful = true
                    self?.storeCredentials(adminToken: token, adminId: admin._id)
                } else {
                    self?.errorMessage = "Signup failed: \(response.message)"
                }
            })
            .store(in: &cancellables)
    }
    
    private func storeCredentials(adminToken: String, adminId: String) {
        UserDefaults.standard.set(adminToken, forKey: "adminAuthToken")
        UserDefaults.standard.set(adminId, forKey: "adminId")
        print("Stored credentials for Admin ID: \(adminId)") // Debugging log
    }
}

//import Foundation
//import Combine
//
//class AdminSignUpViewModel: ObservableObject {
//    @Published var isSignUpSuccessful = false
//    @Published var errorMessage = ""
//    private var cancellables = Set<AnyCancellable>()
//
//    func register(username: String, email: String, password: String, role: String) {
//        let signUpData = AdminSignUpModel(username: username, email: email, password: password, role: role)
//
//        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/admins/register") else {
//            DispatchQueue.main.async {
//                self.errorMessage = "Invalid URL"
//            }
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            let jsonData = try JSONEncoder().encode(signUpData)
//            request.httpBody = jsonData
//        } catch {
//            DispatchQueue.main.async {
//                self.errorMessage = "Failed to encode data"
//            }
//            return
//        }
//
//        URLSession.shared.dataTaskPublisher(for: request)
//            .map(\.data)
//            .decode(type: AdminSignUpResponse.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    self.errorMessage = "Failed to sign up: \(error.localizedDescription)"
//                    self.isSignUpSuccessful = false // Explicitly set to false
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] response in
//                if !response.message.isEmpty, let admin = response.admin, let token = response.token {
//                    self?.isSignUpSuccessful = true
//                    self?.storeCredentials(adminToken: token, adminId: admin._id)
//                } else {
//                    self?.errorMessage = "Signup failed: \(response.message)"
//                }
//            })
//            .store(in: &cancellables)
//    }
//
//    private func storeCredentials(adminToken: String, adminId: String) {
//        UserDefaults.standard.set(adminToken, forKey: "adminAuthToken")
//        UserDefaults.standard.set(adminId, forKey: "adminId")
//    }
//}

//import Foundation
//import Combine
//
//class AdminSignUpViewModel: ObservableObject {
//    @Published var isSignUpSuccessful = false
//    @Published var errorMessage = ""
//    private var cancellables = Set<AnyCancellable>()
//
//    func register(username: String, email: String, password: String, role: String) {
//        let signUpData = AdminSignUpModel(username: username, email: email, password: password, role: role)
//
//        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/admins/register") else {
//            self.errorMessage = "Invalid URL"
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            let jsonData = try JSONEncoder().encode(signUpData)
//            request.httpBody = jsonData
//        } catch {
//            self.errorMessage = "Failed to encode data"
//            return
//        }
//
//        URLSession.shared.dataTaskPublisher(for: request)
//            .map { $0.data }
//            .decode(type: AdminSignUpResponse.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    self.errorMessage = "Failed to sign up: \(error.localizedDescription)"
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] response in
//                if !response.message.isEmpty, let admin = response.admin, let token = response.token {
//                    self?.isSignUpSuccessful = true
//                    self?.storeCredentials(token: token, adminId: admin._id)
//                } else {
//                    self?.errorMessage = "Signup failed: \(response.message)"
//                }
//            })
//            .store(in: &cancellables)
//    }
//
//    private func storeCredentials(token: String, adminId: String) {
//        UserDefaults.standard.set(token, forKey: "adminAuthToken")
//        UserDefaults.standard.set(adminId, forKey: "adminId")
//    }
//}

