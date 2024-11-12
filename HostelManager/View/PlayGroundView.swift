//import SwiftUI
//
//struct StudentProfileView: View {
//    @StateObject private var viewModel = StudentProfileViewModel()
//
//    var body: some View {
//        VStack(spacing: 8) {
//            // MARK: HEADER
//            ZStack {
//                Color.yellow
//                    .frame(height: 160)
//                    .ignoresSafeArea()
//
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
//                .padding(.top, -50)
//            }
//            Spacer()
//
//            // MARK: CONTENT
//            if viewModel.isLoading {
//                ProgressView("Loading...")
//                    .padding()
//            } else if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .padding()
//                Spacer()
//            } else {
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 16) {
//                        // Profile Picture and Name
//                        HStack(alignment: .center, spacing: 16) {
//                            Image(systemName: "person.circle.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 80)
//                                .foregroundColor(.yellow)
//
//                            VStack(alignment: .leading) {
//                                Text(viewModel.name)
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                            }
//                        }
//
//                        // Profile Details
//                        VStack(alignment: .leading, spacing: 16) {
//                            ProfileTextField(title: "Name", text: $viewModel.name)
//                            ProfileTextField(title: "Registration Number", text: $viewModel.registrationNumber)
//                            ProfileTextField(title: "Email", text: $viewModel.email)
//                            ProfileTextField(title: "Phone", text: $viewModel.phone)
//                            ProfileTextField(title: "Hostel Block", text: $viewModel.hostelBlock)
//                            ProfileTextField(title: "Room Number", text: $viewModel.roomNumber)
//                        }
//                        .padding()
//                    }
//                    .padding()
//
//                    Button(action: {
//                        viewModel.updateUserProfile()
//                    }) {
//                        Text("Update")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .foregroundColor(.white)
//                            .background(Color.yellow)
//                            .cornerRadius(10)
//                    }
//                    .padding()
//
//                    if let successMessage = viewModel.successMessage {
//                        Text(successMessage)
//                            .foregroundColor(.green)
//                            .padding()
//                    }
//                }
//                .padding()
//            }
//        }
//        .onAppear {
//            viewModel.fetchUserProfile()
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
