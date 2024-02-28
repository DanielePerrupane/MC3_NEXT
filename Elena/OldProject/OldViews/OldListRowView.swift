//
//  ListRowView.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//

import SwiftUI

struct OldListRowView: View {
    
    let item: OldItemModel
    var body: some View {
        HStack {
            //Circle
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            
            //Testo
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Preview: PreviewProvider{
    static var item1 = OldItemModel(title: "First Item!", isCompleted: false)
    static var item2 = OldItemModel(title: "Second Item!", isCompleted: true)
    
    static var previews: some View{
        Group{
            OldListRowView(item: item1)
            //ListRowView(item: item2)
        }
        
    }
}
