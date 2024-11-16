//
//  MenuRowView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 16/11/24.
//

import SwiftUI

struct MenuRowView: View {
    let option: MenuOptionModel
    @Binding var selectedOption : MenuOptionModel?
    
    private var isSelected: Bool{
        return selectedOption == option
    }
    
    var body: some View {
        HStack{
            Image(systemName : option.systemImageName)
                .imageScale(.large)
            
            Text(option.title)
                .font(.title2)
                .bold()
            
            Spacer()
        }
        .padding(.leading)
        .foregroundStyle(isSelected ? .yellow : .primary)
        .frame(height: 44)
        .background(isSelected ? .yellow.opacity(0.25): .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct MenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView(option: .notifications, selectedOption: .constant(.profile))
    }
}
