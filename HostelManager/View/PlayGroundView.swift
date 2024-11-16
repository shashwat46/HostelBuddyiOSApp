//import SwiftUI
//
//
//struct TabTest: View {
//    
//    @State private var selectedTab = 0
//    var body : some View {
//        VStack(spacing: 0) {
//            //Header
//            ZStack {
//                Color.yellow
//                    .ignoresSafeArea()
//                
//                HStack {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Dashboard")
//                            .font(.title.bold())
//                        Text("Your latest notices")
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
//            }
//            .frame(maxHeight: 100)
//            
//            //Tabs
//            TabView{
//                StudentHomeView()
//                    .tabItem{
//                        Label("Home", systemImage: "house")
//                            
//                    }
//                StudentComplaintBookView()
//                    .tabItem{
//                        Label("Complaint Book", systemImage: "book")
//                            
//                    }
//                StudentProfileView()
//                    .tabItem{
//                        Label("Profile", systemImage: "person")
//                            
//                    }
//            }
//            .accentColor(.yellow)
//            .navigationBarBackButtonHidden(true)
//        }
//    }
//}
//
//struct MenuTestPreviews : PreviewProvider {
//    static var previews: some View{
//        TabTest()
//    }
//}
//
