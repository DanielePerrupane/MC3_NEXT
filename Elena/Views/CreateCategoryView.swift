//
//  CreateCategoryView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 27/02/24.
//

import SwiftUI
import SwiftData

@Model
class Category {
    
    @Attribute(.unique)
    var title: String
    
    var items: [Item]?
        
    init(title: String = "") {
        self.title = title
    }
}

extension Category {
    
    static var defaults: [Category] {
        [
        .init(title: "Health❤️"),
        .init(title: "Fitness🏋️‍♂️"),
        .init(title: "Family🏠"),
        .init(title: "Work🧑‍💻"),
        .init(title: "Personal💆‍♂️"),
        ]
    }
    
}

struct CreateCategoryView: View {
    
    let color = Color("ElenaColor")
    let buttonColor = Color("ButtonColor")
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @Query private var categories: [Category]
    
    var body: some View {
        List {
            Section("Category Title") {
                TextField("Enter title here",
                          text: $title)
                Button("Add Category".uppercased()) {
                    withAnimation{
                        let category = Category(title: title)
                        modelContext.insert(category)
                        category.items = []
                    }
                    
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .font(.headline)
                .background(buttonColor)
                .cornerRadius(10.0)
                .disabled(title.isEmpty)
            }
            
            
            Section("Categories") {
                if categories.isEmpty {
                    
                    ContentUnavailableView("No Categories", systemImage: "archivebox")
                        .foregroundColor(Color.accentColor)
                    
                } else {
                    ForEach(categories){ category in
                        Text(category.title)
                            .swipeActions{
                                Button(role: .destructive){
                                    withAnimation{
                                        modelContext.delete(category)
                                    }
                                } label : {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                }
            }
                        
        }
        .navigationTitle("Add Category")
        .toolbar {
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
                //.foregroundColor(color)
                .bold()
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        CreateCategoryView()
            .modelContainer(for: Item.self)
    }
}
