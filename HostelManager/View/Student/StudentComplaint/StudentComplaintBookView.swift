import SwiftUI

struct StudentComplaintBookView: View {
    @StateObject private var viewModel = StudentComplaintViewModel()
    @State private var selectedComplaint: StudentComplaintModel? = nil
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
                            Text("Complaint Book")
                                .font(.title.bold())
                                .foregroundColor(.primary)
                            Text("Your complaint history")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
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
                List(viewModel.filteredComplaints, id: \.id) { complaint in
                    Button(action: {
                        selectedComplaint = complaint
                    }) {
                        HStack {
                            Text(complaint.category)
                                .font(.body)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text(complaint.status.rawValue)
                                .textCase(.uppercase)
                                .font(.body)
                                .bold()
                                .foregroundColor(statusColor(for: complaint.status))
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
                    
                    // Detail View
                    StudentComplaintDetailView(
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
            
            // Floating Action Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingCreateSheet = true
                    }) {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
                .background(Color.clear)
            }
            .sheet(isPresented: $isShowingCreateSheet) {
                CreateComplaintSheet(isPresented: $isShowingCreateSheet)
            }
        }
    }
    
    func clearSelectedComplaint() {
        selectedComplaint = nil
    }
    
    func statusColor(for status: StudentComplaintModel.Status) -> Color {
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

// Search Bar Component
struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: SearchBar

        init(parent: SearchBar) {
            self.parent = parent
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            parent.text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search complaints"
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct StudentComplaintBookView_Previews: PreviewProvider {
    static var previews: some View {
        StudentComplaintBookView()
    }
}

