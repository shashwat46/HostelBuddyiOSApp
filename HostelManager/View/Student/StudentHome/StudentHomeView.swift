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
            // Header Section
            ZStack {
                Color.yellow
                    .frame(height: 140)
                    .ignoresSafeArea()
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Dashboard")
                            .font(.title.bold())
                        Text("Your latest notices")
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
                    Announcements(viewModel: viewModel)
                        .padding()
                    
                    RecentComplaints()
                        .padding()
                    
                    Spacer()
                }
            }
            .padding(.top, -40)
            
            // Chat Icon
            NavigationLink(destination: ChatView(), label: {
                HStack {
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.yellow)
                        Image(systemName: "message.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding(20)
                    .shadow(radius: 8)
                }
            })
        }
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

struct StudentHomeView_Previews: PreviewProvider {
    static var previews: some View {
        StudentHomeView()
    }
}


//import SwiftUI
//
//struct StudentHomeView: View {
//
//    @StateObject var viewModel = StudentHomeViewModel()
//
//    var body: some View {
//        VStack{
//            // Header Section
//            ZStack{
//                Color.yellow
//                    .frame(height: 140)
//                    .ignoresSafeArea()
//                    HStack {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Dashboard")
//                                .font(.title.bold())
//                            Text("Your latest notices")
//                                .fontWeight(.semibold)
//                                .foregroundColor(.gray)
//                        }
//                        .padding()
//
//                        Spacer()
//
//                        Image(systemName: "line.horizontal.3")
//                            .font(.title)
//                            .foregroundColor(.gray)
//                            .padding(24)
//                            .bold()
//                    }
//                    .padding(.horizontal)
//                    .padding(.top, -50)
//
//            }
//
//            // Content Section
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack {
//
//                    Announcements(viewModel: viewModel)
//                        .padding()
//
//                    RecentComplaints()
//                        .padding()
//
//                    Spacer()
//                }
//            }
//            .padding(.top,-40)
//
//
//            //ChatIcon
//
//            NavigationLink(destination : ChatView(), label : {
//                HStack{
//                    Spacer()
//
//                    ZStack{
//                        Circle()
//                            .frame(width: 70, height : 70)
//                            .foregroundColor(.yellow)
//                        Image(systemName: "message.fill")
//                            .font(.largeTitle)
//                            .foregroundColor(.white)
//                    }
//                    .padding(20)
//                    .shadow(radius: 8)
//                }
//            })
//
//        }
//
//    }
//}
//
//
//
////struct Announcements: View {
////    var body: some View {
////        VStack{
////            // Thick upper border with title inside it
////            ZStack {
////                Color.yellow
////                    .frame(height: 50) // Thicker top edge
////
////                HStack {
////                    Text("Announcements")
////                        .font(.headline)
////                        .foregroundColor(.primary)
////                        .padding(.leading, 10)
////
////                    Spacer()
////                }
////            }
////
////                HStack{
////                    VStack(alignment: .leading, spacing: 10) {
////                        Text("• Hostel will be closed on Diwali")
////                            .padding(.top, 10)
////                        Text("• New mess timings announced")
////                        Text("• Submit your documents by Friday")
////                        Text("• Hostel inspection next week")
////
////                        Spacer()
////                    }
////                    Spacer()
////                }
////
////
////
////        }
////        .padding()
////        .background(Color.white.opacity(0.7))
////        .cornerRadius(10)
////        .shadow(radius: 10)
////    }
////}
//
//struct Announcements: View {
//    @ObservedObject var viewModel: StudentHomeViewModel
//    @State private var selectedAnnouncement: Announcement?
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Color.yellow
//                    .frame(height: 50)
//                    .cornerRadius(10)
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
//                AnnouncementDetailView(announcement: announcement)
//            }
//        }
//        .padding()
//        .background(Color.white.opacity(0.7))
//        .cornerRadius(10)
//        .shadow(radius: 10)
//        .onAppear {
//            viewModel.fetchAnnouncements()
//        }
//    }
//}
//
//// Announcement Detail View for Bottom Sheet
//struct AnnouncementDetailView: View {
//    let announcement: Announcement
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
//
//struct RecentComplaints: View {
//    var body: some View {
//        VStack{
//
//            ZStack {
//                Color.yellow
//                    .frame(height: 50)
//                    .cornerRadius(10)
//
//                HStack {
//                        Text("Recent Complaints")
//                            .font(.headline)
//                            .foregroundColor(.primary)
//                            .padding(.leading, 10)
//
//                        Spacer()
//                    }
//            }
//
//            HStack{
//                VStack(alignment: .leading, spacing : 10) {
//                    Text("• Room Cleaning")
//                        .padding(.top, 10)
//                    Text("• Washroom Cleaning")
//                    Text("• Slow wifi")
//                    Text("• Mess complaint")
//
//                    Spacer()
//                }
//                Spacer()
//            }
//
//        }
//        .padding()
//        .background(Color.white.opacity(0.7))
//        .cornerRadius(10)
//        .shadow(radius: 15)
//    }
//}
//
//
//
//struct StudentHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentHomeView()
//    }
//}
