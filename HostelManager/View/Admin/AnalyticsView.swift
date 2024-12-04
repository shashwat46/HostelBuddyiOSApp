//
//  AnalyticsView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//


import SwiftUI
import WebKit
import Combine

struct AnalyticsView: View {
    @StateObject private var viewModel = AnalyticsViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Analytics...")
                    .padding()
            } else if let htmlContent = viewModel.htmlContent {
                WebView(htmlContent: htmlContent)
                    .padding()
            } else {
                Text("Failed to load analytics data.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchAnalytics()
        }
        .navigationTitle("Analytics")
        .navigationBarTitleDisplayMode(.inline)
    }
}

class AnalyticsViewModel: ObservableObject {
    @Published var htmlContent: String? = nil
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()
    
    func fetchAnalytics() {
        isLoading = true
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/complaints/gemini-analytics") else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .map { data -> String in
                guard let rawContent = try? JSONDecoder().decode([String: String].self, from: data)["analytics"] else {
                    return "<p>Failed to load analytics data.</p>"
                }
                // Add HTML formatting and styling
                return """
                <!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <style>
                        body {
                            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
                            line-height: 1.6;
                            padding: 20px;
                            background-color: #f9f9f9;
                            color: #333;
                        }
                        h1, h2, h3 {
                            color: #222;
                            margin-bottom: 10px;
                        }
                        ul {
                            margin: 10px 0;
                            padding-left: 20px;
                        }
                        li {
                            margin-bottom: 5px;
                        }
                        strong {
                            color: #444;
                        }
                        .highlight {
                            color: #d9534f;
                            font-weight: bold;
                        }
                        .recommendation {
                            background-color: #f1f1f1;
                            padding: 10px;
                            border-left: 4px solid #4caf50;
                            margin-bottom: 10px;
                        }
                    </style>
                </head>
                <body>
                    \(rawContent)
                </body>
                </html>
                """
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching analytics data: \(error.localizedDescription)")
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: { [weak self] content in
                self?.htmlContent = content
            })
            .store(in: &cancellables)
    }
}

struct WebView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}


//import SwiftUI
//import WebKit
//import Combine
//
//struct AnalyticsView: View {
//    @StateObject private var viewModel = AnalyticsViewModel()
//
//    var body: some View {
//        VStack {
//            if viewModel.isLoading {
//                ProgressView("Loading Analytics...")
//                    .padding()
//            } else if let htmlContent = viewModel.htmlContent {
//                WebView(htmlContent: htmlContent)
//                    .padding()
//            } else {
//                Text("Failed to load analytics data.")
//                    .foregroundColor(.red)
//                    .padding()
//            }
//        }
//        .onAppear {
//            viewModel.fetchAnalytics()
//        }
//        .navigationTitle("Analytics")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
//class AnalyticsViewModel: ObservableObject {
//    @Published var htmlContent: String? = nil
//    @Published var isLoading = false
//    private var cancellables = Set<AnyCancellable>()
//
//    func fetchAnalytics() {
//        isLoading = true
//        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/complaints/gemini-analytics") else {
//            print("Invalid URL")
//            isLoading = false
//            return
//        }
//
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .map { String(data: $0, encoding: .utf8) ?? "Failed to load content." }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print("Error fetching analytics data: \(error.localizedDescription)")
//                case .finished:
//                    break
//                }
//                self.isLoading = false
//            }, receiveValue: { [weak self] content in
//                self?.htmlContent = content
//            })
//            .store(in: &cancellables)
//    }
//}
//
//struct WebView: UIViewRepresentable {
//    let htmlContent: String
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.loadHTMLString(htmlContent, baseURL: nil)
//    }
//}
//
