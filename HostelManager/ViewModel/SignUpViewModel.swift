//
//  SignUpViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var isSignUpSuccessful = false
    @Published var errorMessage = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func register(username: String, email: String, phoneNumber: String, roomNumber: String, hostelBlock: String) {
        let signUpData = SignUpModel(username: username, email: email, phoneNumber: phoneNumber, roomNumber: roomNumber, hostelBlock: hostelBlock)
        
        guard let url = URL(string: "https://d77f-2401-4900-4dd8-ec45-ebe0-dbdb-652d-b597.ngrok-free.app/api/users/register") else {
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
            .decode(type: SignUpResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to sign up: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                if response.success {
                    self?.isSignUpSuccessful = true
                } else {
                    self?.errorMessage = response.message
                }
            })
            .store(in: &cancellables)
    }
}

struct SignUpResponse: Decodable {
    let success: Bool
    let message: String
}

