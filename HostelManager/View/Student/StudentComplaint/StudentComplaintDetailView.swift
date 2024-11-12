//
//  StudentComplaintDetailView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 11/11/24.
//
import SwiftUI

struct StudentComplaintDetailView: View {
    let complaint: StudentComplaintModel
    
    @Binding var isShowingDetail: Bool
        let dismissHandler: (() -> Void)?

    @State private var rating: Int = 0 // State variable to store the current rating
    @State private var comments: String = "" // State variable to store comments
    @State private var otpInput: [String] = Array(repeating: "", count: 6) // OTP input array
    @StateObject private var otpViewModel = OTPActionsViewModel() // ViewModel for OTP actions

    var body: some View {
        VStack(spacing: 20) {
            // Card for Complaint Details
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(complaint.category)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(statusColor(for: complaint.status))
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingDetail = false // Dismiss the detail view
                        DispatchQueue.main.async {
                               if let parentDismissHandler = dismissHandler {
                                   parentDismissHandler()
                               }
                           }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                Text(complaint.description)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.bottom, 5)
                
                HStack {
                    Text("Date Posted: \(formattedDate(from: complaint.createdAt))")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(complaint.status.rawValue.capitalized)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(statusColor(for: complaint.status))
                        .padding(6)
                        .background(Capsule().fill(Color.yellow.opacity(0.2)))
                }
                
                // Star Rating Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rate the Resolution")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    HStack {
                        ForEach(1..<6) { star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    rating = star // Update rating based on the selected star
                                }
                        }
                    }
                }
                
                // Comments Box
                VStack(alignment: .leading, spacing: 8) {
                    Text("Add Comments")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    TextEditor(text: $comments)
                        .frame(height: 100)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                                .background(Color.white)
                                .cornerRadius(8)
                        )
                        .foregroundColor(.primary)
                }
                
                // OTP Input Section
                VStack(spacing: 10) {
                    Text("Enter OTP to Proceed")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.top, 10)
                    
                    HStack(spacing: 8) {
                        ForEach(0..<6, id: \.self) { index in
                            TextField("", text: $otpInput[index])
                                .frame(width: 40, height: 40)
                                .multilineTextAlignment(.center)
                                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                                .keyboardType(.numberPad)
                                .onChange(of: otpInput[index]) { newValue in
                                    // Restrict input to 1 character
                                    if newValue.count > 1 {
                                        otpInput[index] = String(newValue.prefix(1))
                                    }
                                }
                        }
                    }
                    
                    // Buttons
                    HStack {
                        Button(action: {
                            generateOTP()
                        }) {
                            Text("Get OTP")
                                .font(.body)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            verifyOTP()
                        }) {
                            Text("Resolved")
                                .font(.body)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            )
            .padding()
            
            Spacer()
        }
        .background(Color.yellow.opacity(0.05).edgesIgnoringSafeArea(.all))
        .navigationTitle("Complaint Details")
        .overlay(
            Group {
                if otpViewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .shadow(radius: 10)
                }
            }
        )
    }
    
    // MARK: - Private Methods
    private func generateOTP() {
        otpViewModel.generateOTP(for: complaint.id) { result in
            switch result {
            case .success(let otpId):
                print("OTP generated successfully with ID: \(otpId)")
            case .failure(let error):
                print("Error generating OTP: \(error.localizedDescription)")
            }
        }
    }
    
    private func verifyOTP() {
        guard let otpId = otpViewModel.otpId else {
            print("OTP ID not available. Please generate OTP first.")
            return
        }
        let enteredOtp = otpInput.joined()
        otpViewModel.verifyOTP(otpId: otpId, issueId: complaint.id, enteredOtp: enteredOtp) { result in
            switch result {
            case .success:
                print("Complaint marked as resolved.")
                submitFeedback()
            case .failure(let error):
                print("Error verifying OTP: \(error.localizedDescription)")
            }
        }
    }
    
    private func submitFeedback() {
        // Fetch userId from UserDefaults
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        let requestBody: [String: Any] = [
            "user": userId,
            "complaint": complaint.id,
            "rating": rating,
            "comments": comments
        ]
        
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/feedbacks"),
              let httpBody = try? JSONSerialization.data(withJSONObject: requestBody) else {
            print("Failed to create request body or URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error submitting feedback: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if (200...299).contains(response.statusCode) {
                    print("Feedback submitted successfully")
                    isShowingDetail = false
                    if let parentDismissHandler = dismissHandler {
                        parentDismissHandler()
                    }
                } else {
                    print("Failed to submit feedback - Status code: \(response.statusCode)")
                }
            }
            
            if let data = data {
                // Print the server response for debugging
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
            }
        }.resume()
    }
    
    private func statusColor(for status: StudentComplaintModel.Status) -> Color {
        switch status {
        case .resolved:
            return .green
        case .pending:
            return .red
        case .inProgress:
            return .orange
        }
    }
    
    private func formattedDate(from isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: isoDate) else { return isoDate }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_IN")
        formatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        return formatter.string(from: date)
    }
}

//struct ComplaintDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleComplaint = StudentComplaintModel(
//            id: "672e2c30b99d6891746bfea3",
//            user: StudentComplaintModel.User(
//                id: "66e977a1df0e154e2626f938",
//                username: "ishan sinha",
//                email: "sinha2ishan4@gmail.com"
//            ),
//            category: "Electrical Issues",
//            description: "The fan in my room has suddenly stopped working.",
//            status: .pending,
//            createdAt: "2024-11-08T15:20:16.533Z",
//            updatedAt: "2024-11-08T15:20:16.533Z",
//            resolvedAt: nil
//        )
//
//        StudentComplaintDetailView(complaint: sampleComplaint, isShowingDetail: .constant(true), dismissHandler: clearSelectedComplaint)
//    }
//}


