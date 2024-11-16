import SwiftUI

struct AdminManageComplaintsView: View {
    @StateObject private var viewModel = AdminComplaintViewModel()
    @State private var selectedComplaint: AdminComplaintModel? = nil
    @State private var isShowingDetail = false
    @State private var isShowingCreateSheet = false
    @State private var needsRefresh = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: HEADER
                ZStack {
                    Color.yellow
                        .frame(height: 160)
                        .ignoresSafeArea()
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Admin Complaint Book")
                                .font(.title.bold())
                                .foregroundColor(.primary)
                            Text("All complaints")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .padding(.bottom)
                        }
                        .padding()
                        
                        Spacer()
                        
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.secondary)
                            .padding(24)
                            .bold()
                    }
                    .padding(.horizontal)
                    .padding(.top, -50)
                }
                
                // MARK: CONTENT
                // Search Box
                SearchBar(text: $viewModel.searchText)
                    .padding(.top, -30)
                
                // Complaints List
                List(viewModel.filteredComplaints, id: \.id) { Admincomplaint in
                    Button(action: {
                        selectedComplaint = Admincomplaint
                    }) {
                        VStack(alignment: .leading) {
                            Text(Admincomplaint.category)
                                .font(.body)
                                .foregroundColor(.primary)
                            Text(Admincomplaint.user.username)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.bottom, 2)
                            
                            HStack {
                                Spacer()
                                Text(Admincomplaint.status.rawValue)
                                    .textCase(.uppercase)
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(statusColor(for: Admincomplaint.status))
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    if needsRefresh {
                        viewModel.fetchComplaints()
                        needsRefresh = false
                    }
                }
            }
            
            // Overlay Detail View
            if let complaint = selectedComplaint {
                ZStack {
                    // Blur Background
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            selectedComplaint = nil
                            isShowingDetail = false
                        }
                    
                    // Detail View (Assuming a similar detail view is available)
                    AdminComplaintDetailView(
                        complaint: complaint,
                        isShowingDetail: $isShowingDetail,
                        dismissHandler: clearSelectedComplaint
                    )
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: isShowingDetail)
            }
            
            // Floating Action Button (Optional for Admin if required)
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        isShowingCreateSheet = true
//                    }) {
//                        Image(systemName: "square.and.pencil")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .padding()
//                            .background(Color.yellow)
//                            .foregroundColor(.white)
//                            .clipShape(Circle())
//                            .shadow(radius: 5)
//                    }
//                    .padding()
//                }
//                .background(Color.clear)
//            }
//            .sheet(isPresented: $isShowingCreateSheet) {
//                CreateComplaintSheet(isPresented: $isShowingCreateSheet)
//            }
        }
    }
    
    func clearSelectedComplaint() {
        selectedComplaint = nil
    }
    
    func statusColor(for status: AdminComplaintModel.Status) -> Color {
        switch status {
        case .resolved:
            return .green
        case .pending:
            return .red
        case .inProgress:
            return .orange
        }
    }
}

struct AdminComplaintBookView_Previews: PreviewProvider {
    static var previews: some View {
        AdminManageComplaintsView()
    }
}


