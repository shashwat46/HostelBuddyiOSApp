//
//  AdminHomeViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 19/9/24.
//

import Foundation
import Combine

class AdminHomeViewModel: ObservableObject {
    @Published var announcements: [AnnouncementAdmin] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        print("AdminHomeViewModel initialized")
        fetchAnnouncements() // Call fetch when the ViewModel is initialized
    }
    
    // Fetch Announcements for Admin from the API
    func fetchAnnouncements() {
        print("Fetching admin announcements...")
        
        guard let url = URL(string: "https://d77f-2401-4900-4dd8-ec45-ebe0-dbdb-652d-b597.ngrok-free.app/api/admin/announcements") else {
            print("Invalid URL")
            return
        }
        
        // Using dataTaskPublisher to fetch announcements
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .handleEvents(receiveOutput: { _ in
                print("Data received from the network")
            })
            .decode(type: [AnnouncementAdmin].self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { decodedData in
                print("Decoded Data: \(decodedData)")
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching admin announcements: \(error.localizedDescription)")
                case .finished:
                    print("Finished fetching admin announcements")
                }
            }, receiveValue: { [weak self] announcements in
                self?.announcements = announcements
                print("Admin Announcements successfully updated: \(announcements.count) items")
            })
            .store(in: &cancellables)
    }
}

