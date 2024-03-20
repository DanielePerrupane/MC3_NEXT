//
//  CreateView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 27/02/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CreateToDoView: View {
    
    let color = Color("ButtonColor")
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query private var categories: [Category]
    
    @State var item = Item()
    @State var selectedCategory: Category?
    
    @State var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        List {
            Section("Task Title"){
                TextField("Title", text: $item.title)
            }
            Section("Date") {
                DatePicker("Choose a date", selection: $item.timeStamp)
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
        .navigationTitle("Add a task 🖋️")
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
        .task(id: selectedPhoto){
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                item.image = data
            }
        }
    }
}

private extension CreateToDoView{
    func save() {
        modelContext.insert(item)
        item.category = selectedCategory
        selectedCategory?.items?.append(item)
    }
}

//#Preview {
//    CreateToDoView()
//        .modelContainer(for: Item.self)
//}
