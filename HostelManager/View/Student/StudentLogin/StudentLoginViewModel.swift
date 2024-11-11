//
//  StudentLoginViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 11/11/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var isLoginSuccessful = false
    @Published var errorMessage = ""
    @Published var token: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func loginUser(email: String, password: String) {
        let loginData = StudentLoginRequest(email: email, password: password)
        
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/users/login") else {
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
            .map {$0.data }
            .decode(type: StudentLoginResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to login: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                // Check if token exists
                if let token = response.token {
                    self?.isLoginSuccessful = true
                    self?.token = token
                    // You can store the token securely if needed
                } else {
                    self?.errorMessage = response.message
                }
            })
            .store(in: &cancellables)
    }
}
