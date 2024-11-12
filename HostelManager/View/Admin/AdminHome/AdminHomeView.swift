//
//  AdminHomeView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 18/9/24.
//


import SwiftUI

struct AdminHomeView: View {
    
    @StateObject var viewModel = AdminHomeViewModel()
    
    var body: some View {
        VStack {
            // Header Section
            ZStack {
                Color.yellow
                    .frame(height: 140)
                    .ignoresSafeArea()
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Admin Dashboard")
                            .font(.title.bold())
                        Text("Manage and oversee")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(24)
                        .bold()
                }
                .padding(.horizontal)
                .padding(.top, -50)
            }
            
            // Content Section
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    AnnouncementsAdmin(viewModel: viewModel)
                        .padding()
                    
                    RecentComplaintsAdmin(viewModel: viewModel)
                        .padding()
                    
                    Spacer()
                }
            }
            .padding(.top, -40)
        }
    }
}

// Announcements view for Admin
struct AnnouncementsAdmin: View {
    @ObservedObject var viewModel: AdminHomeViewModel
    @State private var selectedAnnouncement: AnnouncementAdmin?
    
    var body: some View {
        VStack {
            ZStack {
                Color.yellow
                    .frame(height: 50)
                
                HStack {
                    Text("Announcements")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                if viewModel.announcements.isEmpty {
                    Text("No announcements available")
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.announcements) { announcement in
                        Text("• \(announcement.title)")
                            .padding(.top, 10)
                            .onTapGesture {
                                selectedAnnouncement = announcement
                            }
                    }
                }
                Spacer()
            }
//            .sheet(item: $selectedAnnouncement) { announcement in
//                AnnouncementDetailView(announcement: announcement)
//            }
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

// Recent Complaints view for Admin
struct RecentComplaintsAdmin: View {
    @ObservedObject var viewModel: AdminHomeViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Color.yellow
                    .frame(height: 50)
                
                HStack {
                    Text("Recent Complaints")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                if viewModel.recentComplaints.isEmpty {
                    Text("No recent complaints available")
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.recentComplaints) { complaint in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("• \(complaint.category)")
                                .font(.subheadline)
                                .bold()
                            Text("\(complaint.description)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, 5)
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.white.opacity(0.7))
            .cornerRadius(10)
            .shadow(radius: 15)
        }
    }
}

//import SwiftUI
//
//struct AdminHomeView: View {
//
//    @StateObject var adminViewModel = AdminHomeViewModel()
//
//    var body: some View {
//        VStack {
//            // Header Section
//            ZStack {
//                Color.yellow
//                    .frame(height: 140)
//                    .ignoresSafeArea()
//                HStack {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Admin Dashboard")
//                            .font(.title.bold())
//                        Text("Manage and oversee")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.gray)
//                    }
//                    .padding()
//
//                    Spacer()
//
//                    Image(systemName: "line.horizontal.3")
//                        .font(.title)
//                        .foregroundColor(.gray)
//                        .padding(24)
//                        .bold()
//                }
//                .padding(.horizontal)
//                .padding(.top, -50)
//            }
//
//            // Content Section
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack {
//                    AnnouncementsAdmin(viewModel: adminViewModel)
//                        .padding()
//
//                    SystemStatusView()
//                        .padding()
//
//                    Spacer()
//                }
//            }
//            .padding(.top, -40)
//        }
//        .onAppear {
//            adminViewModel.fetchAnnouncements() // Fetch announcements when the view appears
//        }
//    }
//}
//
//// Announcements view for Admin
//struct AnnouncementsAdmin: View {
//    @ObservedObject var viewModel: AdminHomeViewModel
//    @State private var selectedAnnouncement: AnnouncementAdmin?
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Color.yellow
//                    .frame(height: 50)
//
//                HStack {
//                    Text("Announcements")
//                        .font(.headline)
//                        .foregroundColor(.primary)
//                        .padding(.leading, 10)
//
//                    Spacer()
//                }
//            }
//
//            VStack(alignment: .leading, spacing: 10) {
//                if viewModel.announcements.isEmpty {
//                    Text("No announcements available")
//                        .foregroundColor(.gray)
//                } else {
//                    ForEach(viewModel.announcements) { announcement in
//                        Text("• \(announcement.title)")
//                            .padding(.top, 10)
//                            .onTapGesture {
//                                selectedAnnouncement = announcement
//                            }
//                    }
//                }
//                Spacer()
//            }
//            .sheet(item: $selectedAnnouncement) { announcement in
//                AnnouncementDetailViewAdmin(announcement: announcement)
//            }
//        }
//        .padding()
//        .background(Color.white.opacity(0.7))
//        .cornerRadius(10)
//        .shadow(radius: 10)
//    }
//}
//
//// Announcement Detail View for Bottom Sheet
//struct AnnouncementDetailViewAdmin: View {
//    let announcement: AnnouncementAdmin
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(announcement.title)
//                .font(.largeTitle)
//                .padding(.bottom, 10)
//
//            Text(announcement.content)
//                .font(.body)
//                .padding(.bottom, 20)
//
//            Text("Posted on: \(announcement.createdAt)")
//                .font(.caption)
//                .foregroundColor(.gray)
//
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//struct SystemStatusView: View {
//    var body: some View {
//        VStack {
//            ZStack {
//                Color.yellow
//                    .frame(height: 50)
//
//                HStack {
//                    Text("System Status")
//                        .font(.headline)
//                        .foregroundColor(.primary)
//                        .padding(.leading, 10)
//
//                    Spacer()
//                }
//            }
//
//            VStack(alignment: .leading, spacing: 10) {
//                Text("• All systems operational")
//                    .padding(.top, 10)
//                Text("• No active outages")
//                Text("• Regular maintenance scheduled")
//
//                Spacer()
//            }
//            .padding()
//            .background(Color.white.opacity(0.7))
//            .cornerRadius(10)
//            .shadow(radius: 15)
//        }
//    }
//}
//
//
//struct AdminHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminHomeView()
//    }
//}

