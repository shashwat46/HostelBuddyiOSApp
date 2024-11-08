//
//  RoleSelectionView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 17/9/24.
//

import SwiftUI

struct RoleSelectionView: View {
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                Color.yellow
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.50))
                Circle()
                    .scale(1.2)
                    .foregroundColor(.white)
                VStack{
                    Text("Who are you?")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    NavigationLink(destination: AdminLoginView()){
                        Text("Administrator")
                            .font(.title3)
                        .foregroundColor(.white)
                        .frame(width : 300, height : 50)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .bold()
                        
                        }
                        
                    NavigationLink(destination: StudentLoginView()){
                        Text("Student")
                            .font(.title3)
                        .foregroundColor(.white)
                        .frame(width : 300, height : 50)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .bold()
                        
                        }
                    
                }
                
            }
            
        }
        
    }
}

struct RoleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectionView()
    }
}
