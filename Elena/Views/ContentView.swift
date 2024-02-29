//
//  ContentView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 27/02/24.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    
    
    @State private var selectedTab = 1
    
    @Environment(\.modelContext) var modelContext
    
    @Query private var items: [Item]
    
    @State private var searchQuery = ""
    @State private var showCreateCategory = false
    @State private var showCreateToDo = false
    @State private var toDoToEdit: Item?
    
    var filteredItems: [Item] {
        if searchQuery.isEmpty {
            return items
        }
        let filteredItems = items.compactMap{ item in
            let titleContainsQuery = item.title.range(of: searchQuery, options: .caseInsensitive) != nil
            
            let categoryTitleContainsQuery = item.category?.title.range(of: searchQuery, options: .caseInsensitive) != nil
            
            return (titleContainsQuery || categoryTitleContainsQuery) ? item : nil
        }
        return filteredItems
    }
    
    
    let color = Color("ElenaColor")
    let backgroundColor = Color("Background")
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            NavigationView{
                ZStack {
                    
                    //ANIMAZIONE NO TASK VIEW
                    
                    //                    if items.isEmpty{
                    //                        NoTasksView()
                    //                            .transition(AnyTransition.opacity
                    //                                .animation(.easeIn))
                    //                    }
                    //
                    //                    else {
                    List{
                        ForEach(filteredItems){ item in
                            HStack {
                                VStack(alignment: .leading){
                                    
                                    //TITOLO
                                    Text(item.title)
                                        .font(.title)
                                        .foregroundStyle(Color.accentColor)
                                        .bold()
                                    //DATE FORMAT
                                    Text("\(item.timeStamp, format: Date.FormatStyle(date: .numeric, time:.shortened))")
                                        .font(.callout)
                                    //CATEGORY
                                    if let category = item.category {
                                        Text(category.title)
                                            .foregroundStyle(Color.accentColor)
                                            .bold()
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .background(Color(backgroundColor))
                                            .cornerRadius(8)
                                        
                                    }
                                    
                                }
                                Spacer()
                                
                                //COMPLETE THE TASK
                                Button {
                                    withAnimation{
                                        item.isCompleted.toggle()
                                    }
                                } label: {
                                    Image(systemName: "checkmark")
                                        .symbolVariant(.circle.fill)
                                        .foregroundStyle(item.isCompleted ? .green : .gray)
                                        .font(.largeTitle)
                                }
                                .buttonStyle(.plain)
                            }
                            .swipeActions(){
                                //DELETE THE TASK
                                Button(role: .destructive) {
                                    withAnimation {
                                        modelContext.delete(item)
                                    }
                                } label : {
                                    Label("Delete", systemImage: "trash")
                                        .symbolVariant(.fill)
                                }
                                Button{
                                    toDoToEdit = item
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                    
                                }.tint(.accentColor)
                            }
                        }
                        //.listRowBackground(backgroundColor)
                    }
                    .navigationTitle("To Do List 🌼")
                    .searchable(text: $searchQuery, prompt: "Search for a task or a category")
                    //SEARCH VUOTA 
                    .overlay {
                        if filteredItems.isEmpty {
                            ContentUnavailableView.search
                        }
                    }
                    .sheet(isPresented: $showCreateToDo,
                           content: {
                        //CREATE TASK
                        NavigationStack{
                            CreateToDoView()
                        }
                        //.presentationDetents([.medium])
                    })
                    .sheet(item: $toDoToEdit){
                        toDoToEdit = nil
                    } content: { item in
                        //UPDATE VIEW
                        NavigationStack{
                            UpdateToDoView(item: item)
                        }
                        //.presentationDetents([.medium])
                    }
                    .sheet(isPresented: $showCreateCategory,
                           content: {
                        //CREATE CATEGORY
                        NavigationStack {
                            CreateCategoryView()
                        }
                    })
                    //            .toolbar {
                    //                ToolbarItem{
                    //                    Button(action: {
                    //                        showCreate.toggle()
                    //                    }, label: {
                    //                        Image(systemName: "plus")
                    //                            .foregroundColor(color)
                    //                            .bold()
                    //                    })
                    //                }
                    //            }
                    
                    //CHIUSURA ELSE
                    //                }
                }
                .preferredColorScheme(.light)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("New Category") {
                            showCreateCategory.toggle()
                        }
                        //.presentationDetents([.medium])
                        .foregroundColor(color)
                        .bold()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showCreateToDo.toggle()
                        }, label: {
                            Label("New ToDo", systemImage: "plus.circle.fill")
                                .foregroundColor(color)
                                .bold()
                            //                                .font(.title2)
                            //                                .padding(8)
                            //                                .background(.gray.opacity(0.1),
                            //                                            in: Capsule())
                            //                                .padding(.leading)
                            //                                .symbolVariant(.circle.fill)
                            
                        })
                        //.presentationDetents([.medium])
                    }
                }
            }
            .preferredColorScheme(.light)
            
            .tabItem {
                Label("Tasks", systemImage: "list.bullet.clipboard")
                    .padding(.top,30)
            }.tag(1)
            
            GrowthView()
                .tabItem {
                    Label("Growth", systemImage: "leaf")
                }.tag(2)
        }
        .preferredColorScheme(.light)
    }
    
}

#Preview {
    ContentView()
}
