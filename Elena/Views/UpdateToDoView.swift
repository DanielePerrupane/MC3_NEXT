//
//  UpdateToDoView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 27/02/24.
//

import SwiftUI
import SwiftData

struct UpdateToDoView: View {
    
    let color = Color("ElenaColor")
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var item: Item
    
    var body: some View {
        List{
            TextField("Type something here", text: $item.title)
            DatePicker("Choose a Date",
                       selection: $item.timeStamp)
            Button("Update".uppercased()){
                dismiss()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .font(.headline)
            .background(color)
            .cornerRadius(10.0)
        }
    }
}

//#Preview {
//    UpdateToDoView(item: <#Item#>)
//}
