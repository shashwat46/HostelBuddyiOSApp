import SwiftUI

struct StudentProfileView: View {
    @State private var name: String = ""
    @State private var registrationNumber: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var hostelBlock: String = ""
    @State private var roomNumber: String = ""
    @State private var isLoading: Bool = true
    @State private var errorMessage: String? = nil
    @State private var successMessage: String? = nil

    var body: some View {
        VStack(spacing: 0) {
            // MARK: HEADER
            ZStack {
                Color.yellow
                    .frame(height: 140)
                    .ignoresSafeArea()
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Profile")
                            .font(.title.bold())
                        Text("View or Edit details")
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
                .padding(.top, 50)
            } // Header ends

            // MARK: CONTENT
            if isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Profile Picture and Name
                        HStack(alignment: .center, spacing: 16) {
                            Image(systemName: "person.circle.fill") // Placeholder for profile picture
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .foregroundColor(.yellow)

                            VStack(alignment: .leading) {
                                Text(name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        }

                        // Profile Details
                        VStack(alignment: .leading, spacing: 16) {
                            ProfileTextField(title: "Name", text: $name)
                            ProfileTextField(title: "Registration Number", text: $registrationNumber)
                            ProfileTextField(title: "Email", text: $email)
                            ProfileTextField(title: "Phone", text: $phone)
                            ProfileTextField(title: "Hostel Block", text: $hostelBlock)
                            ProfileTextField(title: "Room Number", text: $roomNumber)
                        }
                        .padding()
                    }
                    .padding()

                    Button(action: {
                        updateUserProfile()
                    }) {
                        Text("Update")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
                    .padding()

                    if let successMessage = successMessage {
                        Text(successMessage)
                            .foregroundColor(.green)
                            .padding()
                    }
                }
                .padding()
            }
        }
        .onAppear {
            fetchUserProfile()
        }
    }

    private func fetchUserProfile() {
        guard let userId = UserDefaults.standard.string(forKey: "userId"),
              let token = UserDefaults.standard.string(forKey: "authToken"),
              let url = URL(string: "https://hostel-buddy.onrender.com/api/users/\(userId)") else {
            isLoading = false
            errorMessage = "Invalid user ID"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Replace with actual token

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error fetching profile: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received"
                }
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    DispatchQueue.main.async {
                        self.name = json["username"] as? String ?? ""
                        self.registrationNumber = json["_id"] as? String ?? ""
                        self.email = json["email"] as? String ?? ""
                        self.phone = json["phoneNumber"] as? String ?? ""
                        self.hostelBlock = json["hostelBlock"] as? String ?? ""
                        self.roomNumber = json["roomNumber"] as? String ?? ""
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Error parsing profile data"
                }
            }
        }.resume()
    }

    private func updateUserProfile() {
        guard let userId = UserDefaults.standard.string(forKey: "userId"),
              let token = UserDefaults.standard.string(forKey: "authToken"),
              let url = URL(string: "https://hostel-buddy.onrender.com/api/users/\(userId)") else {
            errorMessage = "Invalid user ID or missing token"
            return
        }

        let requestBody: [String: Any] = [
            "username": name,
            "email": email,
            "phoneNumber": phone,
            "roomNumber": roomNumber,
            "hostelBlock": hostelBlock
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody) else {
            errorMessage = "Failed to encode request body"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error updating profile: \(error.localizedDescription)"
                }
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    errorMessage = "Failed to update profile"
                }
                return
            }

            DispatchQueue.main.async {
                successMessage = "Profile updated successfully"
                // Update UserDefaults with the new name
                UserDefaults.standard.set(self.name, forKey: "username")
            }
        }.resume()
    }
}

struct ProfileTextField: View {
    var title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)

            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 5)
        }
    }
}

struct StudentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StudentProfileView()
    }
}


//
//import SwiftUI
//
//struct StudentProfileView: View {
//    @State private var name: String = ""
//    @State private var registrationNumber: String = ""
//    @State private var email: String = ""
//    @State private var phone: String = ""
//    @State private var hostelBlock: String = ""
//    @State private var roomNumber: String = ""
//    @State private var isLoading: Bool = true
//    @State private var errorMessage: String? = nil
//
//    var body: some View {
//        VStack(spacing: 0) {
//            // MARK: HEADER
//            ZStack {
//                Color.yellow
//                    .frame(height: 140)
//                    .ignoresSafeArea()
//                HStack {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Your Profile")
//                            .font(.title.bold())
//                        Text("View or Edit details")
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
//                .padding(.top, 50)
//            } // Header ends
//
//            // MARK: CONTENT
//            if isLoading {
//                ProgressView("Loading...")
//                    .padding()
//            } else if let errorMessage = errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .padding()
//            } else {
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 16) {
//                        // Profile Picture and Name
//                        HStack(alignment: .center, spacing: 16) {
//                            Image(systemName: "person.circle.fill") // Placeholder for profile picture
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                                .foregroundColor(.yellow)
//
//                            VStack(alignment: .leading) {
//                                Text(name)
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                            }
//                        }
//
//                        // Profile Details
//                        VStack(alignment: .leading, spacing: 16) {
//                            ProfileTextField(title: "Name", text: $name)
//                            ProfileTextField(title: "Registration Number", text: $registrationNumber)
//                            ProfileTextField(title: "Email", text: $email)
//                            ProfileTextField(title: "Phone", text: $phone)
//                            ProfileTextField(title: "Hostel Block", text: $hostelBlock)
//                            ProfileTextField(title: "Room Number", text: $roomNumber)
//                        }
//                        .padding()
//                    }
//                    .padding()
//
//                    Button(action: {
//                                                updateUserProfile()
//                                            }) {
//                                                Text("Update")
//                                                    .frame(maxWidth: .infinity)
//                                                    .padding()
//                                                    .foregroundColor(.white)
//                                                    .background(Color.blue)
//                                                    .cornerRadius(10)
//                                            }
//                                            .padding()
//
//                                            if let successMessage = successMessage {
//                                                Text(successMessage)
//                                                    .foregroundColor(.green)
//                                                    .padding()
//                                            }
//                                        }
//                                        .padding()
//                }
//            }
//        }
//        .onAppear {
//            fetchUserProfile()
//        }
//    }
//
//    private func fetchUserProfile() {
//        guard let userId = UserDefaults.standard.string(forKey: "userId"),
//              let token = UserDefaults.standard.string(forKey: "authToken"),
//              let url = URL(string: "https://hostel-buddy.onrender.com/api/users/\(userId)") else {
//            isLoading = false
//            errorMessage = "Invalid user ID"
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Replace with actual token
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                isLoading = false
//            }
//            if let error = error {
//                DispatchQueue.main.async {
//                    errorMessage = "Error fetching profile: \(error.localizedDescription)"
//                }
//                return
//            }
//
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    errorMessage = "No data received"
//                }
//                return
//            }
//
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    DispatchQueue.main.async {
//                        self.name = json["username"] as? String ?? ""
//                        self.registrationNumber = json["_id"] as? String ?? ""
//                        self.email = json["email"] as? String ?? ""
//                        self.phone = json["phoneNumber"] as? String ?? ""
//                        self.hostelBlock = json["hostelBlock"] as? String ?? ""
//                        self.roomNumber = json["roomNumber"] as? String ?? ""
//                    }
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    errorMessage = "Error parsing profile data"
//                }
//            }
//        }.resume()
//    }
//
//    private func updateUserProfile() {
//            guard let userId = UserDefaults.standard.string(forKey: "userId"),
//                  let token = UserDefaults.standard.string(forKey: "authToken"),
//                  let url = URL(string: "https://hostel-buddy.onrender.com/api/users/\(userId)") else {
//                errorMessage = "Invalid user ID or missing token"
//                return
//            }
//
//            let requestBody: [String: Any] = [
//                "username": name,
//                "email": email,
//                "phoneNumber": phone,
//                "roomNumber": roomNumber,
//                "hostelBlock": hostelBlock
//            ]
//
//            guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody) else {
//                errorMessage = "Failed to encode request body"
//                return
//            }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "PUT"
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = httpBody
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    DispatchQueue.main.async {
//                        errorMessage = "Error updating profile: \(error.localizedDescription)"
//                    }
//                    return
//                }
//
//                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                    DispatchQueue.main.async {
//                        errorMessage = "Failed to update profile"
//                    }
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    successMessage = "Profile updated successfully"
//                    // Update UserDefaults with the new name
//                    UserDefaults.standard.set(self.name, forKey: "username")
//                }
//            }.resume()
//        }
//}
//
//struct ProfileTextField: View {
//    var title: String
//    @Binding var text: String
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(title)
//                .font(.headline)
//
//            TextField(title, text: $text)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.top, 5)
//        }
//    }
//}
//
//struct StudentProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentProfileView()
//    }
//}
//
