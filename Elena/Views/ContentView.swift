//
//  ContentView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 27/02/24.
//

import SwiftUI
import SwiftData
import Foundation
import AlertKit




//CAMBIAMENTO #4
//opzioni menu a tendina
enum SortOption: String, CaseIterable {
    case title
    case date
    case category
    case uncompleted
}

//estensione menu a tendina con immagini
extension SortOption {
    
    var systemImage: String {
        switch self {
        case .title:
            "textformat.size.larger"
        case .date:
            "calendar"
        case .category:
            "folder"
        case .uncompleted:
            "checkmark.circle.fill"
        }
    }
}

struct ContentView: View {
    
    
    
    //COLORI
    let secondaryColor = Color("ElenaColor")
    let backgroundColor = Color("Background")
    //VARIABILI NUMERICHE
    @State private var percentage: Int = UserDefaults.standard.integer(forKey: "percentage_key")
    //VARIABILE INCREMENTALE
    @State private var count: Int = UserDefaults.standard.integer(forKey: "count_key")
    //VARIABILI DI TESTO
    let textDisplayed1: String = "You completed.."
    let textDisplayed2: String = "Your flower is at.."
    //VARIABILE PER TABVIEW
    @State private var selectedTab = 1
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var searchQuery = ""
    @State private var showCreateCategory = false
    @State private var showCreateToDo = false
    @State private var toDoToEdit: Item?
    //ALERT
    @State var showAlert: Bool = false
    //CAMBIAMENTO #4
    @State private var selectedSortOption = SortOption.allCases.first!
    
    //Filtro per title e category
    var filteredItems: [Item] {
        
        if searchQuery.isEmpty {
            return items.sort(on: selectedSortOption)
            
        }
        let filteredItems = items.compactMap{ item in
            let titleContainsQuery = item.title.range(of: searchQuery, options: .caseInsensitive) != nil
            
            let categoryTitleContainsQuery = item.category?.title.range(of: searchQuery, options: .caseInsensitive) != nil
            
            return (titleContainsQuery || categoryTitleContainsQuery) ? item : nil
        }
        return filteredItems.sort(on: selectedSortOption)
    }
    //AppMainColor
    let color = Color("ElenaColor")
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            NavigationView{
                ZStack {
                    List{
                        ForEach(filteredItems){ item in
                            HStack {
                                //VISUALIZZAZIONE ELEMENTI LISTA
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
                                        
                                        if percentage < 100  {
                                            count += 1
                                            percentage += 10
                                            saveCountAndPercentage()
                                        } else if percentage == 100{
                                            showAlert = true
                                            count = 0
                                            percentage = 0
                                            saveCountAndPercentage()
                                        }
                                    }
                                }
                                
                            label: {
                                Image(systemName: "checkmark")
                                    .symbolVariant(.circle.fill)
                                    .foregroundStyle(item.isCompleted ? .green : .gray)
                                    .font(.largeTitle)
                            }
                            .buttonStyle(.plain)
                            .sheet(isPresented: $showAlert,
                                   content: {
                                NavigationStack{
                                    AlertView()
                                }
                            })
                            }
                            //SWIPE ACTIONS: DELETE AND EDIT
                            .swipeActions(){
                                //DELETE
                                Button(role: .destructive) {
                                    withAnimation {
                                        modelContext.delete(item)
                                    }
                                } label : {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                                //EDIT
                                Button{
                                    toDoToEdit = item
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                    
                                }.tint(.accentColor)
                            }
                        }
                    }
                    .navigationTitle("To Do List 🌼")
                    //SEARCH BAR
                    .animation(.easeIn, value: filteredItems)
                    .searchable(text: $searchQuery, prompt: "Search for a task or a category")
                    
                    //TASKVIEW VUOTA
                    .overlay {
                        if items.isEmpty {
                            NoTasksView()
                                .transition(AnyTransition.opacity.animation(.easeIn))
                        }
                        //SEARCHVIEW VUOTA
                        else if filteredItems.isEmpty{
                            ContentUnavailableView.search
                        }
                    }
                    //MODALE UPDATE VIEW
                    .sheet(item: $toDoToEdit){
                        toDoToEdit = nil
                    } content: { editItem in
                        NavigationStack{
                            UpdateToDoView(item: editItem)
                            //.interactiveDismissDisabled()
                        }
                    }
                    //MODALE CREATE CATEGORY
                    .sheet(isPresented: $showCreateCategory,
                           content: {
                        NavigationStack {
                            CreateCategoryView()
                        }
                    })
                    //MODALE CREATE TASK
                    .sheet(isPresented: $showCreateToDo,
                           content: {
                        NavigationStack{
                            CreateToDoView()
                        }
                    })
                }
                .preferredColorScheme(.light)
                .toolbar {
                    //ELLIPSIS DX
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        //MENU A TENDINA IN ALTO A DX
                        Menu {
                            Picker("", selection: $selectedSortOption) {
                                ForEach(SortOption.allCases,
                                        id: \.rawValue) { option in
                                    Label(option.rawValue.capitalized,
                                          systemImage: option.systemImage)
                                    .tag(option)
                                }
                            }
                            .labelsHidden()
                            
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .symbolVariant(.circle)
                        }
                        
                    }
                    //ADD CATEGORY SX
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            showCreateCategory.toggle()
                        }, label: {
                            Image(systemName: "folder.badge.plus")
                        })
                        
                        .foregroundColor(color)
                        //.bold()
                    }
                    
                }
                //PLUS IN THE BOTTOM OF THE SCREEN
                .safeAreaInset(edge: .bottom,
                               alignment: .center) {
                    Button(action: {
                        showCreateToDo.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .symbolRenderingMode(.palette)
                            .bold()
                            .font(.largeTitle)
                            .padding(8)
                            .foregroundStyle(Color.white, color)
                    })
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
            .preferredColorScheme(.light)
            //TAB ITEM #1
            .tabItem {
                Label("Tasks", systemImage: "list.bullet.clipboard")
                    .padding(.top,30)
            }.tag(1)
            //GROWVIEW
            NavigationView {
                ZStack {
                    VStack {
                        Image("\(percentage)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 180, height: 250)
                            .clipped()
                        Text(textDisplayed1)
                            .font(.title)
                            .foregroundColor(secondaryColor)
                        
                        //TASK COMPLETATE
                        Text("\(count) tasks")
                            .font(.title2)
                            .foregroundColor(secondaryColor)
                            .fontWeight(.bold)
                        
                        Text(textDisplayed2)
                            .font(.title)
                            .foregroundColor(secondaryColor)
                        
                        //PERCENTUALE TASK
                        Text("\(percentage)%")
                            .font(.title2)
                            .foregroundColor(secondaryColor)
                            .fontWeight(.bold)
                        //                        .padding(.top,30)
                    }
                    .padding(.bottom, 100)
                    .navigationTitle("Elena")
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Growth", systemImage: "leaf")
            }.tag(2)
        
        }
        
        
        .preferredColorScheme(.light)
    }
    
    
    
    private func delete(item: Item) {
        
        withAnimation{
            modelContext.delete(item)
        }
        
    }
    //SAVE USER-DEFAULTS DATA
    func saveCountAndPercentage() {
        
        if let encodedData = try? JSONEncoder().encode(count) {
            UserDefaults.standard.set(count, forKey: "count_key")
            
        }
        UserDefaults.standard.set(percentage, forKey: "percentage_key")
        
    }
    //LOAD USER-DEFAULTS DATA
    func loadCountAndPercentage() {
        count = UserDefaults.standard.integer(forKey: "count_key")
        percentage = UserDefaults.standard.integer(forKey: "percentage_key")
    }
}
//CAMBIAMENTO #4
private extension [Item] {
    
    func sort(on option: SortOption) -> [Item] {
        
        switch option {
        case .title:
            self.sorted(by: { $0.title < $1.title })
        case .date:
            self.sorted(by: { $0.timeStamp < $1.timeStamp })
        case .category:
            self.sorted(by: {
                guard let firstItemTitle = $0.category?.title,
                      let secondItemTitle = $1.category?.title else { return false }
                return firstItemTitle < secondItemTitle
            })
        case .uncompleted:
            self.sorted(by: { $0.isCompleted != $1.isCompleted })
        }
        
        
    }
    
}



#Preview {
    ContentView()
}
