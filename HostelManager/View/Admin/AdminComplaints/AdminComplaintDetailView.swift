//
//  AdminComplaintsDetailView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 12/11/24.
//


import SwiftUI

struct AdminComplaintDetailView: View {
    let complaint: AdminComplaintModel
    @Binding var isShowingDetail: Bool
    let dismissHandler: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 20) {
            // Main Card
            VStack(alignment: .leading, spacing: 10) {
                // Header with dismiss button
                HStack {
                    Text(complaint.category)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(statusColor(for: complaint.status))
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingDetail = false
                        DispatchQueue.main.async {
                            if let parentDismissHandler = dismissHandler {
                                parentDismissHandler()
                            }
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                // User Details Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Student Details")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Name: \(complaint.user.username)")
                            .font(.subheadline)
                        Text("Email: \(complaint.user.email)")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                // Complaint Description
                Text(complaint.description)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.vertical, 5)
                
                // Dates Section
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date Posted: \(formattedDate(from: complaint.createdAt))")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    if complaint.status == .inProgress {
                        Text("Last Updated: \(formattedDate(from: complaint.updatedAt))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    
                    if let resolvedDate = complaint.resolvedAt {
                        Text("Resolved On: \(formattedDate(from: resolvedDate))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Status
                HStack {
                    Spacer()
                    Text(complaint.status.rawValue.capitalized)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(statusColor(for: complaint.status))
                        .padding(6)
                        .background(Capsule().fill(Color.yellow.opacity(0.2)))
                }
                
                // Action Buttons
                HStack(spacing: 15) {
                    Button(action: {
                        // Mark as seen action to be implemented
                    }) {
                        Text("Mark Issue as Seen")
                            .font(.body)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(complaint.status == .resolved)
                    .opacity(complaint.status == .resolved ? 0.6 : 1)
                    
                    Button(action: {
                        // Generate OTP action to be implemented
                    }) {
                        Text("Generate OTP")
                            .font(.body)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
                    .disabled(complaint.status == .resolved)
                    .opacity(complaint.status == .resolved ? 0.6 : 1)
                }
                .padding(.top)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            )
            .padding()
            
            Spacer()
        }
        .background(Color.yellow.opacity(0.05).edgesIgnoringSafeArea(.all))
        .navigationTitle("Complaint Details")
    }
    
    // MARK: - Helper Functions
    private func statusColor(for status: AdminComplaintModel.Status) -> Color {
        switch status {
        case .resolved:
            return .green
        case .pending:
            return .red
        case .inProgress:
            return .orange
        }
    }
    
    private func formattedDate(from isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: isoDate) else { return isoDate }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_IN")
        formatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        return formatter.string(from: date)
    }
}
