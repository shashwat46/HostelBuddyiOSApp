//
//  StudentMenuHeaderView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 16/11/24.
//

import SwiftUI

struct StudentMenuHeaderView: View {
    var body: some View {
        HStack{
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6)
            {
                Text("Shashwat Singh")
                    .font(.subheadline)
                
                Text("Shashwat@gmail.com")
                    .font(.footnote)
                    .tint(.gray)
            }
        }
    }
}

struct StudentMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StudentMenuHeaderView()
    }
}
