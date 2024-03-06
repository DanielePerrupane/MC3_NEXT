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
            
//            Section {
//                
//                
//                if let imageData = item.image,
//                   let uiImage = UIImage(data: imageData) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(maxWidth: .infinity,maxHeight: 300)
//                }
//                
//                PhotosPicker(selection: $selectedPhoto,
//                             matching: .images,
//                             photoLibrary: .shared()) {
//                    Label("Add Image", systemImage: "photo")
//                }
//                
//                if item.image != nil {
//                    
//                    Button(role: .destructive) {
//                        withAnimation{
//                            selectedPhoto = nil
//                            item.image = nil
//                        }
//                        
//                    } label : {
//                        Label("Remove Image", systemImage: "trash")
//                            .foregroundStyle(.red)
//                    }
//                    
//                }
//            }
            
            Section{
                Button("Update".uppercased()){
                    item.category = selectedCategory
                    dismiss()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .font(.headline)
                .background(buttonColor)
                .cornerRadius(10.0)
            }
            
        }
        .navigationTitle("Update Task")
        .onAppear(perform: {
            selectedCategory = item.category
        })
        .task(id: selectedPhoto){
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                item.image = data
            }
        }
    }
}

//#Preview {
//    UpdateToDoView(item: <#Item#>)
//}
