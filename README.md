# Hostel Maintenance App

## Overview
The **Hostel Maintenance App** is an iOS mobile application designed to streamline hostel management by addressing issues like complaint tracking, issue resolution, and communication between students and administrators. Built using SwiftUI and the MVVM architecture, the app provides separate interfaces for students and admins, offering features such as a complaint book, announcements, analytics, and more. This project aims to improve the efficiency of hostel maintenance and foster a better living environment for students.

## Features

### User (Student) Features:
- **Login/Signup System**: Students can register and securely log in to access their personalized dashboard.
- **Dashboard**: Displays announcements, recent complaints, and quick access links to essential features.
- **Complaint Book**: Allows users to submit, view, and track the status of their complaints.
- **Chatbox**: Facilitates communication between students and administrators.
- **Announcements**: Students can view detailed announcements made by the hostel management.

### Admin Features:
- **Login System**: Secure access for administrators to manage hostel operations.
- **Complaint Management**: View and update the status of student complaints.
- **Announcement Management**: Post and manage announcements for students.
- **Analytics Dashboard**:
  - Common issues reported by students.
  - Recurring problems for targeted solutions.
  - Average resolution time for complaints.
  - Recommendations to improve resolution processes.

## Technologies Used

### Mobile App:
- **SwiftUI**: Used for building a responsive and intuitive user interface.
- **MVVM Architecture**: Ensures a clean separation of concerns and maintainable code.
- **State Management**:
  - **@Published**, **@AppStorage**, and **@StateObject**: Efficiently manage the app's state and user preferences.
  - **Async/Await**: Enhances app loading times and data processing for a smoother user experience.

### Backend:
- **Express.js**: Provides the server-side logic for APIs.
- **MongoDB**: Used for storing user credentials, complaints, announcements, and analytics data.
- **Backend Repository**: [Hostel-Buddy Backend](https://github.com/ishan0224/Hostel-Buddy.git)

### APIs:
- **Custom APIs**: Enable functionalities like user authentication, complaint submissions, and analytics retrieval.

### Tools:
- **Postman**: For API testing and integration.
- **Canva**: Used to design the app's visuals for presentations.

## How to Run the Project

### Mobile App:
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/hostel-maintenance-app.git
   ```
2. Open the project in Xcode.
3. Ensure you have the latest iOS SDK installed.
4. Build and run the app on a simulator or connected device.

### Backend:
1. Clone the backend repository:
   ```bash
   git clone https://github.com/ishan0224/Hostel-Buddy.git
   ```
2. Navigate to the backend directory:
   ```bash
   cd Hostel-Buddy
   ```
3. Install dependencies:
   ```bash
   npm install
   ```
4. Start the server:
   ```bash
   npm start
   ```

## Contribution Guidelines
We welcome contributions to improve the app! Please follow these steps:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes with descriptive messages.
4. Submit a pull request.

## Future Scope
- **Advanced Analytics**: Use machine learning for predictive analytics.
- **Multi-language Support**: Cater to a broader audience with language options.
- **Cross-platform Compatibility**: Expand accessibility by developing an Android version.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.

---

We hope this app improves the day-to-day functioning of hostel maintenance and enhances the student experience. Happy coding!

