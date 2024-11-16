//
//  StudentHomeView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 17/9/24.
//

import SwiftUI

struct StudentHomeView: View {
    
    @StateObject var viewModel = StudentHomeViewModel()
    
    var body: some View {
        VStack {
            // Content Section
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Announcements(viewModel: viewModel)
                        .padding()
                    
                    RecentComplaints()
                        .padding()
                    
                    Spacer()
                }
            }
            
        }
        .overlay(
            ChatIcon().padding(20),
            alignment: .bottomTrailing)
    }
}

struct Announcements: View {
    @ObservedObject var viewModel: StudentHomeViewModel
    @State private var selectedAnnouncement: Announcement?
    
    var body: some View {
        VStack(alignment : .leading) {
            ZStack {
                Color.yellow
                    .frame(height: 50)
                    .cornerRadius(10)
                
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
                        HStack{
                            Text("•")
                                .foregroundColor(.primary)
                            Text("\(announcement.title)")
                                .padding(.top, 5)
                                .underline()
                                .onTapGesture {
                                    selectedAnnouncement = announcement
                                }
                        }
                    }
                }
                Spacer()
            }
            .sheet(item: $selectedAnnouncement) { announcement in
                AnnouncementDetailView(announcement: announcement)
            }
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(10)
        .shadow(radius: 10)
        .onAppear {
            viewModel.fetchAnnouncements()
        }
    }
}

struct AnnouncementDetailView: View {
    let announcement: Announcement
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack {
                Color.yellow
                    .frame(height: 50)
                    .cornerRadius(10)
                
                HStack {
                    Text(announcement.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.black.opacity(0.6))
                        .padding(30)
                    Spacer()
                }
            }

            
            Text(announcement.content)
                .font(.headline)
                .padding(20)
            

            Text("Posted on: \(announcement.createdAt)")
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
    }
}

struct RecentComplaints: View {
    var body: some View {
        VStack {
            ZStack {
                Color.yellow
                    .frame(height: 50)
                    .cornerRadius(10)
                
                HStack {
                    Text("Recent Complaints")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading, 10)
                    Spacer()
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("• Room Cleaning")
                        .padding(.top, 10)
                    Text("• Washroom Cleaning")
                    Text("• Slow wifi")
                    Text("• Mess complaint")
                    Spacer()
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(10)
        .shadow(radius: 15)
    }
}

struct ChatIcon : View {
    var body : some View {
        // Chat Icon
        NavigationLink(destination: ChatView(), label: {
                ZStack {
                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.yellow)
                    Image(systemName: "message.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .shadow(radius: 8)
        })
    }
}

struct StudentHomeView_Previews: PreviewProvider {
    static var previews: some View {
        StudentHomeView()
    }
}
