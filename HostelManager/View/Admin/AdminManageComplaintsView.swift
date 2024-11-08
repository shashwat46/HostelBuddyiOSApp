import SwiftUI

struct AdminManageComplaintsView: View {
    
    @State private var searchText: String = ""
    @State private var complaints: [AdminComplaint] = [
        AdminComplaint(title: "Complaint 1", status: .resolved),
        AdminComplaint(title: "Complaint 2", status: .pending),
        AdminComplaint(title: "Complaint 3", status: .inProgress),
        AdminComplaint(title: "Complaint 4", status: .resolved)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: HEADER
            ZStack {
                Color.yellow
                    .frame(height: 150)
                    .ignoresSafeArea()
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Manage Complaints")
                            .font(.title.bold())
                        Text("Oversee Complaints")
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
                
            }// Header ends
            
            // MARK: CONTENT
            
            // Search Box
            AdminSearchBar(text: $searchText)
                .padding(.top, -30)
            
            // Complaints List
            List(filteredComplaints, id: \.title) { complaint in
                HStack {
                    Text(complaint.title)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(complaint.status.rawValue)
                        .font(.body)
                        .foregroundColor(statusColor(for: complaint.status))
                    
                    // Status Update Button
                    Button(action: {
                        // Add action to update the status
                        updateComplaintStatus(complaint: complaint)
                    }) {
                        Text("Update")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    var filteredComplaints: [AdminComplaint] {
        if searchText.isEmpty {
            return complaints
        } else {
            return complaints.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func statusColor(for status: AdminComplaint.Status) -> Color {
        switch status {
        case .resolved:
            return .green
        case .pending:
            return .red
        case .inProgress:
            return .orange
        }
    }
    
    func updateComplaintStatus(complaint: AdminComplaint) {
        // Logic to update the complaint status
        // For example, navigate to a detail view or show an action sheet
        print("Updating status for complaint: \(complaint.title)")
    }
}

// Search Bar Component
struct AdminSearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: AdminSearchBar

        init(parent: AdminSearchBar) {
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

// Complaint Model for Admin
struct AdminComplaint {
    let title: String
    let status: Status
    
    enum Status: String {
        case resolved = "Resolved"
        case pending = "Pending"
        case inProgress = "In Progress"
    }
}

struct AdminManageComplaintsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminManageComplaintsView()
    }
}

