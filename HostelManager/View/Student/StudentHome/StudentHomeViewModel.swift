//
//  StudentHomeViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//

import Foundation
import Combine

class StudentHomeViewModel: ObservableObject {
    @Published var announcements: [Announcement] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchAnnouncements() // Fetch announcements when the ViewModel is initialized
    }
    
    // Fetch Announcements from the API
    func fetchAnnouncements() {
        print("Fetching announcements...")
        
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/announcements") else {
            print("Invalid URL")
            return
        }
        
        // Using dataTaskPublisher to fetch announcements
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .handleEvents(receiveOutput: { _ in
                print("Data received from the network")
            })
            .decode(type: [Announcement].self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { decodedData in
                print("Decoded Data: \(decodedData)")
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching announcements: \(error.localizedDescription)")
                case .finished:
                    print("Finished fetching announcements")
                }
            }, receiveValue: { [weak self] announcements in
                self?.announcements = announcements
                print("Announcements successfully updated: \(announcements.count) items")
            })
            .store(in: &cancellables)
    }
}



