//
//  StudentMenuView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 16/11/24.
//

import SwiftUI

struct StudentMenuView: View {
    @Binding var isShowingMenu: Bool
    
    var body: some View {
        ZStack{
            if isShowingMenu{
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {isShowingMenu.toggle()}
                
                HStack{
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 32) {
                        StudentMenuHeaderView()
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    
                }
            }
        }
    }
}

struct StudentMenuView_Previews: PreviewProvider {
    static var previews: some View {
        StudentMenuView(isShowingMenu: .constant(true))
    }
}
