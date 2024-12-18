//
//  SignUpViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import Foundation
import Combine

class StudentSignUpViewModel: ObservableObject {
    @Published var isSignUpSuccessful = false
    @Published var errorMessage = ""
    private var cancellables = Set<AnyCancellable>()
    
    // Store token and user ID after signup
    @Published var userToken: String?
    @Published var userID: String?

    func register(username: String, email: String, password: String, phoneNumber: String, roomNumber: String, hostelBlock: String) {
        let signUpData = StudentSignUpModel(username: username, email: email, password: password, phoneNumber: phoneNumber, roomNumber: roomNumber, hostelBlock: hostelBlock)
        
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/users/register") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(signUpData)
            request.httpBody = jsonData
        } catch {
            self.errorMessage = "Failed to encode data"
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: StudentSignUpResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to sign up: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                // Check if response contains a user object and token
                if !response.message.isEmpty, let user = response.user, let token = response.token {
                    self?.isSignUpSuccessful = true
                    self?.userToken = token
                    self?.userID = user._id  // Save the user ID for future requests
                } else {
                    self?.errorMessage = "Signup failed: \(response.message)"
                }
            })
            .store(in: &cancellables)
    }
}


