//
//  OTPActions.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import Foundation

class OTPActionsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var otpId: String?

    func generateOTP(for issueId: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            completion(.failure(NSError(domain: "User ID not found", code: 0, userInfo: nil)))
            return
        }
        
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/otps/generate") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "userId": userId,
            "issueId": issueId
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        isLoading = true
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "Invalid Data", code: 0, userInfo: nil)))
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let otpId = json["otpId"] as? String {
                        self.otpId = otpId
                        completion(.success(otpId))
                    } else {
                        completion(.failure(NSError(domain: "Invalid Response", code: 0, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    func verifyOTP(otpId: String, issueId: String, enteredOtp: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            completion(.failure(NSError(domain: "User ID not found", code: 0, userInfo: nil)))
            return
        }
        
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/otps/verify") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "otpId": otpId,
            "userId": userId,
            "issueId": issueId,
            "enteredOtp": enteredOtp
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        isLoading = true
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    completion(.failure(error))
                    return
                }

                completion(.success(()))
            }
        }

        task.resume()
    }
}

