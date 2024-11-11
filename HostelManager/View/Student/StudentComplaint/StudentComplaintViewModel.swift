//
//  StudentComplaintViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 11/11/24.
//

import Foundation
import Combine

class StudentComplaintViewModel: ObservableObject {
    @Published var complaints: [StudentComplaintModel] = []
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchComplaints()
    }

    func fetchComplaints() {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            print("User ID not found in UserDefaults.")
            return
        }
        
        let urlString = "https://hostel-buddy.onrender.com/api/complaints/user/\(userId)/history"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [StudentComplaintModel].self, decoder: JSONDecoder())
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
    
    var filteredComplaints: [StudentComplaintModel] {
        if searchText.isEmpty {
            return complaints
        } else {
            return complaints.filter { $0.description.lowercased().contains(searchText.lowercased()) || $0.category.lowercased().contains(searchText.lowercased()) }
        }
    }
}

