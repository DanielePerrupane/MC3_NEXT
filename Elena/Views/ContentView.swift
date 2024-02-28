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
    @Environment(\.modelContext) var context
    
    @Query private var items: [Item]
    
    @State private var showCreateCategory = false
    
    @State private var showCreateToDo = false
    @State private var toDoToEdit: Item?
    
    
    let color = Color("ElenaColor")
    let backgroundColor = Color("Background")
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            NavigationView{
                
                ZStack {
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    if items.isEmpty{
                        NoTasksView()
                            .transition(AnyTransition.opacity
                                .animation(.easeIn))
                    }
                    
                    else {
                        List{
                            
                            ForEach(items){ item in
                                HStack {
                                    
                                    VStack(alignment: .leading){
                                        
                                        //TITOLO
                                        Text(item.title)
                                            .font(.title)
                                            .bold()
                                        //DATE FORMAT
                                        Text("\(item.timeStamp, format: Date.FormatStyle(date: .numeric, time:.shortened))")
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
                                            context.delete(item)
                                        }
                                    } label : {
                                        Label("Delete", systemImage: "trash")
                                            .symbolVariant(.fill)
                                    }
                                    Button{
                                        toDoToEdit = item
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                            .foregroundStyle(.orange)
                                    }
                                }
                            }
                            .listRowBackground(backgroundColor)
                        }
                        .navigationTitle("To Do List 🌼")
                        .sheet(isPresented: $showCreateToDo,
                               content: {
                            NavigationStack{
                                CreateToDoView()
                            }
                            .presentationDetents([.medium])
                        })
                        .sheet(item: $toDoToEdit){
                            toDoToEdit = nil
                        } content: { item in
                            NavigationStack{
                                UpdateToDoView(item: item)
                            }
                            .presentationDetents([.medium])
                        }
                        .sheet(isPresented: $showCreateCategory,
                               content: {
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
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("New Category") {
                            showCreateCategory.toggle()
                        }
                        .presentationDetents([.medium])
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
                        .presentationDetents([.medium])
                    }
                }
               
                
            
                
                
                
                
            }
            .tabItem {
                Label("Tasks", systemImage: "list.bullet.clipboard")
                    .padding(.top,30)
            }.tag(1)
            
            GrowthView()
                .tabItem {
                    Label("Growth", systemImage: "leaf")
                }.tag(2)
        }
        
        
        
    }
}

#Preview {
    ContentView()
}
