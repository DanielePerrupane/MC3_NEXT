//
//  CreateView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 27/02/24.
//

import SwiftUI

struct CreateToDoView: View {
    
    let color = Color("ElenaColor")
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var item = Item()
    
    var body: some View {
        List {
            TextField("Type something here", text: $item.title)
            DatePicker("Choose a date", selection: $item.timeStamp)
            //Toggle("Important?", isOn: $item.isCritical)
            Button("Create".uppercased()){
                
                withAnimation{
                    context.insert(item)
                }
                dismiss()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .font(.headline)
            .background(color)
            .cornerRadius(10.0)
        }
        .navigationTitle("Add a task 🖋️")
    }
}

//#Preview {
//    CreateToDoView()
//        .modelContainer(for: Item.self)
//}
