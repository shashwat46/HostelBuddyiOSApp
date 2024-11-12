//
//  AdminLoginViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import Foundation
import Combine

class AdminLoginViewModel: ObservableObject {

    @Published var isLoginSuccessful = false
    @Published var errorMessage = ""

    private var cancellables = Set<AnyCancellable>()

    func loginAdmin(email: String, password: String) {
        let loginData = AdminLoginRequest(email: email, password: password)

        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/admins/login") else {
            self.errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(loginData)
            request.httpBody = jsonData
        } catch {
            self.errorMessage = "Failed to encode data"
            return
        }

        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: AdminLoginResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to login: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                if let token = response.token, let adminId = response.adminId {
                    self?.isLoginSuccessful = true
                    self?.storeCredentials(token: token, adminId: adminId)
                } else {
                    self?.errorMessage = response.message
                }
            })
            .store(in: &cancellables)
    }
    
    private func storeCredentials(token: String, adminId: String){
        UserDefaults.standard.set(token, forKey: "adminAuthToken")
        UserDefaults.standard.set(adminId, forKey: "adminId")
    }
}

