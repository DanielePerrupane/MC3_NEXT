//
//  TodoView.swift
//  Elena
//
//  Created by Daniele Perrupane on 29/02/24.
//

import SwiftUI

struct TodoView: View {
    
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading){
            Text(item.title)
                .font(.title)
                .bold()
            Text("\(item.timeStamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                .font(.callout)
        }
    }
}

#Preview {
    TodoView(item: Item.dummy)
}
