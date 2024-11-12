//
//  AdminComplaintViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//

import Foundation
import Combine

class AdminComplaintViewModel: ObservableObject {
    @Published var complaints: [AdminComplaintModel] = []
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchComplaints()
    }

    func fetchComplaints() {
        let urlString = "https://hostel-buddy.onrender.com/api/complaints"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [AdminComplaintModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch complaints: \(error)")
                }
            }, receiveValue: { [weak self] complaints in
                self?.complaints = complaints
            })
            .store(in: &cancellables)
    }
    
    var filteredComplaints: [AdminComplaintModel] {
        if searchText.isEmpty {
            return complaints
        } else {
            return complaints.filter { $0.description.lowercased().contains(searchText.lowercased()) || $0.category.lowercased().contains(searchText.lowercased()) || $0.user.username.lowercased().contains(searchText.lowercased()) }
        }
    }
}
