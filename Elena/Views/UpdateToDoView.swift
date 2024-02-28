//
//  UpdateToDoView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 27/02/24.
//

import SwiftUI
import SwiftData

class OriginalToDo {
    var title: String
    var timeStamp: Date
    
    init(title: String, timeStamp: Date) {
        self.title = title
        self.timeStamp = timeStamp
        
    }
}

struct UpdateToDoView: View {
    
    let color = Color("ElenaColor")
    
    @Environment(\.dismiss) var dismiss
    
    @Query private var categories: [Category]
    
    @State var selectedCategory: Category?
    
    @Bindable var item: Item
    
    var body: some View {
        List{
            Section("Task Title"){
                TextField("Type something here", text: $item.title)
            }
            Section("Date"){
                DatePicker("Choose a Date",
                           selection: $item.timeStamp)
            }
            
            Section("Select A Category") {
                
                if categories.isEmpty {
                    
                    ContentUnavailableView("No Categories", systemImage: "archivebox")
                        .foregroundColor(Color.accentColor)
                    
                } else {
                    Picker("", selection: $selectedCategory) {
                        
                        ForEach(categories){ category in
                            Text(category.title)
                                .tag(category as Category?)
                        }
                        Text("None")
                            .tag(nil as Category?)
                    }
                    .labelsHidden()
                    .pickerStyle(.inline)
                }
                
            }
            Section{
                Button("Update".uppercased()){
                    item.category = selectedCategory
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
        .navigationTitle("Update Task")
        .onAppear(perform: {
            selectedCategory = item.category
        })
    }
}

//#Preview {
//    UpdateToDoView(item: <#Item#>)
//}
