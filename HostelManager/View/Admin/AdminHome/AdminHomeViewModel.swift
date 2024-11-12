//
//  AdminHomeViewModel.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//
import Foundation
import Combine

class AdminHomeViewModel: ObservableObject {
    @Published var announcements: [AnnouncementAdmin] = []
    @Published var recentComplaints: [AdminComplaintModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchAnnouncements()
        fetchRecentComplaints()
    }
    
    // Fetch Announcements from API
    func fetchAnnouncements() {
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/announcements") else {
            print("Invalid Announcements URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [AnnouncementAdmin].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching announcements: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] announcements in
                self?.announcements = announcements
            })
            .store(in: &cancellables)
    }
    
    // Fetch Recent Complaints from API
    func fetchRecentComplaints() {
        guard let url = URL(string: "https://hostel-buddy.onrender.com/api/complaints") else {
            print("Invalid Complaints URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [AdminComplaintModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching recent complaints: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] complaints in
                self?.recentComplaints = Array(complaints.prefix(4)) // Only get the most recent 4 complaints
            })
            .store(in: &cancellables)
    }
}
