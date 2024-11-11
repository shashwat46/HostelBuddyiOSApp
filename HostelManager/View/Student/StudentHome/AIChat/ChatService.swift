import Foundation
import SwiftUI

enum ChatRole {
    case user
    case model
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID().uuidString
    var role: ChatRole
    var message: String
}

class ChatService: ObservableObject {
    private(set) var messages = [ChatMessage]()
    private(set) var loadingResponse = false
    
    // Your custom API URL
    private let apiUrl = "https://hostel-buddy.onrender/api/chat"
    
    // Function to send a message to the API and handle the response
    func sendMessage(_ message: String) {
        loadingResponse = true
        
        // Add the user's message to the list
        messages.append(.init(role: .user, message: message))
        
        // Send the message to your API
        Task {
            do {
                // Create a JSON request body
                let requestBody: [String: String] = ["message": message]
                
                // Convert the request body to JSON data
                let jsonData = try JSONEncoder().encode(requestBody)
                
                // Create the URL request
                var request = URLRequest(url: URL(string: apiUrl)!)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                // Perform the network request
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Log the raw response data for debugging purposes
                print("Response data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
                
                // Parse the response
                if let response = try? JSONDecoder().decode(APIResponse.self, from: data),
                   let reply = response.reply {
                    // Add the model's response to the messages list
                    let renderedMessage = renderHTML(reply)
                    messages.append(.init(role: .model, message: renderedMessage))
                } else {
                    // Handle errors in the response
                    messages.append(.init(role: .model, message: "Something went wrong, please try again."))
                }
            } catch {
                // Handle any network or decoding errors
                messages.append(.init(role: .model, message: "Something went wrong, please try again."))
                print("Error: \(error)")
            }
            
            // Stop loading
            loadingResponse = false
        }
    }
    
    // Function to render HTML content into a string suitable for display
    private func renderHTML(_ html: String) -> String {
        // Convert HTML into a proper string with line breaks and special characters handled
        guard let data = html.data(using: .utf8),
              let attributedString = try? NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil) else {
            return "Error rendering HTML."
        }
        
        // Return the plain text version of the HTML content
        return attributedString.string
    }
}

// Structure to decode the response from your API
struct APIResponse: Decodable {
    let reply: String?
}





//import Foundation
//import SwiftUI
//
//enum ChatRole {
//    case user
//    case model
//}
//
//struct ChatMessage: Identifiable, Equatable {
//    let id = UUID().uuidString
//    var role: ChatRole
//    var message: String
//}
//
//class ChatService: ObservableObject {
//    private(set) var messages = [ChatMessage]()
//    private(set) var loadingResponse = false
//
//    // Your custom API URL
//    private let apiUrl = "https://7cb5-182-66-218-120.ngrok-free.app/api/chat"
//
//    // Function to send a message to the API and handle the response
//    func sendMessage(_ message: String) {
//        loadingResponse = true
//
//        // Add the user's message to the list
//        messages.append(.init(role: .user, message: message))
//
//        // Send the message to your API
//        Task {
//            do {
//                // Create a JSON request body
//                let requestBody: [String: String] = ["message": message]
//
//                // Convert the request body to JSON data
//                let jsonData = try JSONEncoder().encode(requestBody)
//
//                // Create the URL request
//                var request = URLRequest(url: URL(string: apiUrl)!)
//                request.httpMethod = "POST"
//                request.httpBody = jsonData
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//                // Perform the network request
//                let (data, _) = try await URLSession.shared.data(for: request)
//
//                // Log the raw response data for debugging purposes
//                print("Response data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
//
//                // Parse the response
//                if let response = try? JSONDecoder().decode(APIResponse.self, from: data),
//                   let text = response.reply {
//                    // Add the model's response to the messages list
//                    messages.append(.init(role: .model, message: text))
//                } else {
//                    // Handle errors in the response
//                    messages.append(.init(role: .model, message: "Something went wrong, please try again."))
//                }
//            } catch {
//                // Handle any network or decoding errors
//                messages.append(.init(role: .model, message: "Something went wrong, please try again."))
//                print("Error: \(error)")
//            }
//
//            // Stop loading
//            loadingResponse = false
//        }
//    }
//}
//
//// Structure to decode the response from your API
//struct APIResponse: Decodable {
//    let reply: String?
//}
//
//
//
//
//
////import Foundation
////import SwiftUI
////
////enum ChatRole {
////    case user
////    case model
////}
////
////struct ChatMessage: Identifiable, Equatable {
////    let id = UUID().uuidString
////    var role: ChatRole
////    var message: String
////}
////
////
////class ChatService : ObservableObject {
////    private(set) var messages = [ChatMessage]()
////    private(set) var loadingResponse = false
////
////    // Your custom API URL
////    private let apiUrl = "https://7cb5-182-66-218-120.ngrok-free.app/api/chat"
////
////    func sendMessage(_ message: String) {
////        loadingResponse = true
////
////        // Add the user's message to the list
////        messages.append(.init(role: .user, message: message))
////
////        // Send the message to your API
////        Task {
////            do {
////                // Create a JSON request body
////                let requestBody: [String: Any] = ["message": message]
////
////                // Convert to JSON data
////                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
////
////                // Create the URL request
////                var request = URLRequest(url: URL(string: apiUrl)!)
////                request.httpMethod = "POST"
////                request.httpBody = jsonData
////                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////
////                // Perform the network request
////                let (data, _) = try await URLSession.shared.data(for: request)
////
////                // Parse the response
////                if let response = try? JSONDecoder().decode(APIResponse.self, from: data),
////                   let text = response.text {
////                    // Add the response to the messages list
////                    messages.append(.init(role: .model, message: text))
////                } else {
////                    // Handle errors in the response
////                    messages.append(.init(role: .model, message: "Something went wrong, please try again."))
////                }
////            }
////            catch {
////                // Handle any network or decoding errors
////                messages.append(.init(role: .model, message: "Something went wrong, please try again."))
////            }
////
////            // Stop loading
////            loadingResponse = false
////        }
////    }
////}
////
////// Structure to decode the response from your API
////struct APIResponse: Decodable {
////    let text: String?
////}
////
