//
//  StudentMenuView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 16/11/24.
//

import SwiftUI

struct StudentMenuView: View {
    @Binding var isShowingMenu: Bool
    @Binding var selectedTab: Int
    @State private var selectedOption: MenuOptionModel?
    @State private var showLogoutConfirmation = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            if isShowingMenu{
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {isShowingMenu.toggle()}
                
                HStack{
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 80)
                    {
                        StudentMenuHeaderView()
                        
                        VStack{
                            ForEach(MenuOptionModel.allCases){option in
                                Button(action:{
                                    selectedOption = option
                                    
                                    if option == .profile {
                                        selectedTab = 2
                                    }
                                    isShowingMenu.toggle()
                                }, label : {
                                    MenuRowView(option: option, selectedOption: $selectedOption)
                                        .padding(.bottom, 20)
                                })
                            }
                        }
                        
                        Spacer()
                        
                        HStack{
                            
                            Button {
                                showLogoutConfirmation = true
                            } label: {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .tint(.yellow)
                                
                                Text("Logout")
                                    .foregroundColor(.black)
                            }
                            .confirmationDialog("Are you sure you want to logout?", isPresented: $showLogoutConfirmation)
                            {
                                Button("Yes, Logout", role: .destructive) {
                                        logout()
                                    }
                                Button("Cancel", role: .cancel) { }
                            }
                        }
                        .font(.title2)
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    
                }
            }
        }
        .transition(.move(edge: .trailing))
        .animation(.easeOut, value: isShowingMenu)
    }
    
    private func logout() {

//            username = ""
//            password = ""
            
            // Return to root view
            presentationMode.wrappedValue.dismiss()
        }

}

struct StudentMenuView_Previews: PreviewProvider {
    static var previews: some View {
        StudentMenuView(isShowingMenu: .constant(true), selectedTab: .constant(0))
    }
}
