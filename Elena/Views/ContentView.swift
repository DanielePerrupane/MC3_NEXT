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
import SwiftUIImageViewer
import WebKit

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

//struct ProgressBar: View {
//
//    @Binding var progress: Float
//    var color: Color = Color.green
//    var body: some View {
//        ZStack {
//            Circle()
//                .stroke(lineWidth: 15)
//                .opacity(0.20)
//                .foregroundColor(Color.green)
//
//            Circle()
//                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0 )))
//                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
//                .foregroundColor(color)
//                .rotationEffect(Angle(degrees: 270))
//                .animation(.easeInOut, value:2.0)
//        }
//    }
//
//}

struct ContentView: View {
    
    @State private var showGrowView = false
    
    //PROGRESS-CIRCLE-BAR
    //@State var progressValue: Float = 0.0
    //COLORI
    let secondaryColor = Color("ElenaColor")
    let backgroundColor = Color("BackgroundCategory")
    let buttonColor = Color("ButtonColor")
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
    
    //IMAGE VIEWER
    @State private var isImageViewerPresented = false
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
    
    var body: some View {
        
        //        TabView(selection: $selectedTab) {
        NavigationView{
            ZStack {
                List{
                    //SECTION PREVIEW
                    Section {
                        HStack {
                            VStack(alignment: .leading) {
                                
                                Text(textDisplayed1)
                                //.font(.title)
                                    .foregroundColor(secondaryColor)
                                
                                //TASK COMPLETATE
                                Text("\(count) tasks")
                                //.font(.title2)
                                    .foregroundColor(secondaryColor)
                                    .bold()
                                
                                Text(textDisplayed2)
                                //.font(.title)
                                    .foregroundColor(secondaryColor)
                                
                                //PERCENTUALE TASK
                                Text("\(percentage)%")
                                //.font(.title2)
                                    .foregroundColor(secondaryColor)
                                    .bold()
                            }
                            
                        
                            
                            Button{
                                showGrowView = true
                            }
                        label: {
                            
                            Image("\(percentage)")
                                .resizable()
                                .frame(maxWidth: 100, maxHeight: 120)
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            //Image(systemName: "arrow.up.left.and.arrow.down.right")
                        }
                            
                        .safeAreaInset(edge: .bottom,
                                       alignment: .trailing) {
                            Image(systemName: "arrow.up.left.and.arrow.down.right")
                                .foregroundStyle(secondaryColor)
                            
                        }
                        .sheet(isPresented: $showGrowView,
                               content: {
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
                                        
                                        Button(action: {
                                            percentage = 0
                                            count = 0
                                            
                                            //progressValue = 0
                                            saveCountAndPercentage()
                                        }, label : {
                                            //                                Circle()
                                            //                                    .frame(width: 50, height: 50, alignment: .center)
                                            //                                    .foregroundStyle(buttonColor)
                                            //                                    .overlay(content: {
                                            Image(systemName: "arrow.clockwise.circle.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .shadow(
                                                    color: Color(.gray).opacity(0.7), radius: 10)
                                                .symbolRenderingMode(.palette)
                                                .font(.largeTitle)
                                            //.padding()
                                                .foregroundStyle(Color.white, buttonColor)
                                            //                                            .font(.largeTitle)
                                            //                                            .bold()
                                            //.frame(width: 30, height: 25)
                                            
                                            //                                    })
                                        })
                                        //.padding()
                                        //.foregroundColor(.white)
                                        //.frame(maxWidth: 500)
                                        //.frame(width: 300, height: 55)
                                        //.font(.headline)
                                        //.cornerRadius(10.0)
                                    }
                                    .padding(.bottom, 100)
                                    .navigationTitle("Elena")
                                }
                            }
                            
                        })
                            //                                ProgressBar(progress: self.$progressValue)
                            //                                    .frame(width: 70, height: 70)
                            //                                    .padding()
                        }
                    }
                    
                    ForEach(filteredItems){ item in
                        VStack{
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
                                //                                COMPLETE THE TASK
                                Button {
                                    withAnimation {
                                        
                                        if percentage != 0 && item.isCompleted == true{
                                            item.isCompleted.toggle()
                                            count -= 1
                                            percentage -= 15
                                            //self.progressValue -= 0.15
                                            saveCountAndPercentage()
                                        } else if percentage < 100 || item.isCompleted == false {
                                            
                                            item.isCompleted.toggle()
                                            count += 1
                                            percentage += 15
                                            //self.progressValue += 0.15
                                            saveCountAndPercentage()
                                            
                                        }
                                        
                                        
                                    }

                                    if percentage == 105 {
                                        count = 0
                                        percentage = 0
                                        //progressValue = 0
                                        saveCountAndPercentage()
                                        showAlert.toggle()
                                    }
                                }
                                
                            label: {
                                Image(systemName: "checkmark")
                                    .symbolVariant(.circle.fill)
                                    .foregroundStyle(item.isCompleted ? .green : .gray)
                                    .font(.largeTitle)
                                
                            }
                            .buttonStyle(.plain)
                                //MODALE 100%
                            .sheet(isPresented: $showAlert,
                                   content: {
                                NavigationStack{
                                    AlertView()
                                    
                                }
                            })
                            }
                            
                            if let selectedPhotoData = item.image,
                               let uiImage = UIImage(data: selectedPhotoData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .onTapGesture{
                                        isImageViewerPresented = true
                                    }
                                    .fullScreenCover(isPresented: $isImageViewerPresented) {
                                        SwiftUIImageViewer(image: Image(uiImage: uiImage))
                                            .overlay(alignment: .topTrailing) {
                                                Button {
                                                    isImageViewerPresented = false
                                                } label : {
                                                    Image(systemName: "xmark.circle.fill")
                                                        .font(.headline)
                                                }
                                                //.buttonStyle(.bordered)
                                                //.clipShape(Circle())
                                                .tint(buttonColor)
                                                .padding()
                                            }
                                    }
                            }
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
                                
                            }.tint(buttonColor)
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
                        ContentUnavailableView {
                            Image("NoTask")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .scaledToFit()
                        } description: {
                            Text("New tasks you create will appear here.")
                        }
                        
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
            //.preferredColorScheme(.light)
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
                    
                    .foregroundColor(secondaryColor)
                    //.bold()
                }
                
            }
            //PLUS IN THE BOTTOM OF THE SCREEN
            .safeAreaInset(edge: .bottom,
                           alignment: .trailing) {
                Button(action: {
                    showCreateToDo.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .shadow(
                            color: Color(.gray).opacity(0.7), radius: 10)
                        .symbolRenderingMode(.palette)
                        .bold()
                        .font(.largeTitle)
                        .padding()
                        .foregroundStyle(Color.white, buttonColor)
                })
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        //.preferredColorScheme(.light)
        //TAB ITEM #1
        //            .tabItem {
        //                Label("Tasks", systemImage: "list.bullet.clipboard")
        //                    .padding(.top,30)
        //            }.tag(1)
        //            //GROWTHVIEW
        //            NavigationView {
        //                ZStack {
        //                    VStack {
        //                        Image("\(percentage)")
        //                            .resizable()
        //                            .aspectRatio(contentMode: .fill)
        //                            .frame(width: 180, height: 250)
        //                            .clipped()
        //                        Text(textDisplayed1)
        //                            .font(.title)
        //                            .foregroundColor(secondaryColor)
        //
        //                        //TASK COMPLETATE
        //                        Text("\(count) tasks")
        //                            .font(.title2)
        //                            .foregroundColor(secondaryColor)
        //                            .fontWeight(.bold)
        //
        //                        Text(textDisplayed2)
        //                            .font(.title)
        //                            .foregroundColor(secondaryColor)
        //
        //                        //PERCENTUALE TASK
        //                        Text("\(percentage)%")
        //                            .font(.title2)
        //                            .foregroundColor(secondaryColor)
        //                            .fontWeight(.bold)
        //
        //
        //                        Button(action: {
        //                            percentage = 0
        //                            count = 0
        //                            progressValue = 0
        //                            saveCountAndPercentage()
        //                        }, label : {
        //                            //                                Circle()
        //                            //                                    .frame(width: 50, height: 50, alignment: .center)
        //                            //                                    .foregroundStyle(buttonColor)
        //                            //                                    .overlay(content: {
        //                            Image(systemName: "arrow.clockwise.circle.fill")
        //                                .resizable()
        //                                .frame(width: 50, height: 50)
        //                                .shadow(
        //                                    color: Color(.gray).opacity(0.7), radius: 10)
        //                                .symbolRenderingMode(.palette)
        //                            //.bold()
        //                                .font(.largeTitle)
        //                                .padding()
        //                                .foregroundStyle(Color.white, buttonColor)
        //                            //                                            .font(.largeTitle)
        //                            //                                            .bold()
        //                            //.frame(width: 30, height: 25)
        //
        //                            //                                    })
        //
        //
        //
        //                        })
        //                        .foregroundColor(.white)
        //                        //.frame(maxWidth: 500)
        //                        //.frame(width: 300, height: 55)
        //                        //.font(.headline)
        //
        //                        .cornerRadius(10.0)
        //
        //                    }
        //                    .padding(.bottom, 100)
        //                    .navigationTitle("Elena")
        //                }
        //            }
        //            .navigationViewStyle(StackNavigationViewStyle())
        //            .tabItem {
        //                Label("Growth", systemImage: "leaf")
        //            }.tag(2)
        
        //        }.tabViewStyle(DefaultTabViewStyle())
        
        
        //.preferredColorScheme(.light)
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
