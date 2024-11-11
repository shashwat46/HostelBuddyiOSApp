import SwiftUI

struct StudentComplaintBookView: View {
    
    @State private var searchText: String = ""
    @State private var complaints: [Complaint] = [
        Complaint(title: "Complaint 1", status: .resolved),
        Complaint(title: "Complaint 2", status: .pending),
        Complaint(title: "Complaint 3", status: .inProgress),
        Complaint(title: "Complaint 4", status: .resolved)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: HEADER
            ZStack {
                Color.yellow
                    .frame(height: 140)
                    .ignoresSafeArea()
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Complaint Book")
                            .font(.title.bold())
                        Text("Your complaint history")
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
                
            }//Header ends
            
            //MARK: CONTENT
            
            // Search Box
            SearchBar(text: $searchText)
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
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    var filteredComplaints: [Complaint] {
        if searchText.isEmpty {
            return complaints
        } else {
            return complaints.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func statusColor(for status: Complaint.Status) -> Color {
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
// Complaint Model
struct Complaint {
    let title: String
    let status: Status
    
    enum Status: String {
        case resolved = "Resolved"
        case pending = "Pending"
        case inProgress = "In Progress"
    }
}

struct StudentComplaintBookView_Previews: PreviewProvider {
    static var previews: some View {
        StudentComplaintBookView()
    }
}


