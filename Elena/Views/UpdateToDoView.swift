//
//  UpdateToDoView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 27/02/24.
//

import SwiftUI
import SwiftData
import PhotosUI


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
    let buttonColor = Color("ButtonColor")
    
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query private var categories: [Category]
    
    @State var selectedCategory: Category?
    @State var selectedPhoto: PhotosPickerItem?
    
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
        }
        .navigationTitle("Update Task")
        .toolbar{
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel"){
                    dismiss()
                }.bold()
            }
            
            ToolbarItem(placement: .primaryAction){
                Button("Done"){
                    save()
                    dismiss()
                    
                }.bold()
                
            }
        }
        .onAppear(perform: {
            selectedCategory = item.category
        })
        
    }
}

private extension UpdateToDoView{
    func save() {
        modelContext.insert(item)
        item.category = selectedCategory
        selectedCategory?.items?.append(item)
    }
}

//#Preview {
//    UpdateToDoView(item: <#Item#>)
//}
