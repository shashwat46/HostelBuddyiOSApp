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
            .map { String(data: $0, encoding: .utf8) ?? "Failed to load content." }
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

