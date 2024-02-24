//
//  ListView2.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//

import SwiftUI

struct ListView2: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var selectedTab = 1
    let secondaryAccentColor = Color("SecondAccentColor")
    let backgroundColor = Color("background")
    
    @FocusState private var isFocused: Bool
    
    
    /*
     CRUD FUNCTION
     Create
     Read
     Update
     Delete
     */
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ZStack{
                    Color(backgroundColor)
                        .ignoresSafeArea()
                    if listViewModel.items.isEmpty {
                        NoTasksView()
                            .transition(AnyTransition.opacity
                                .animation(.easeIn))
                    } else {
                            List{
                                ForEach(listViewModel.items){ item in
                                    ListRowView(item: item)
                                        
                                    //TAP GESTURE PER CHECKBOX
                                        .onTapGesture {
                                            withAnimation(.linear){
                                                listViewModel.updateItem(item: item)
                                            }
                                        }
                                }
                                //DA MODIFICARE
                                //swipe left delete
                                .onDelete(perform: listViewModel.deleteItem)
                                //press to move
                                .onMove(perform: listViewModel.moveItem)
                                //background color of the list
                                .listRowBackground(Color(backgroundColor))
                            }
                            .listStyle(PlainListStyle())
                    }
                }
                .preferredColorScheme(.light)
                .navigationTitle("Daily Tasks 📝")
                .navigationBarItems(
                    leading: EditButton().foregroundStyle(secondaryAccentColor),
                    trailing: NavigationLink("Add", destination: AddView())
                    .foregroundStyle(secondaryAccentColor))
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
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .onAppear() {
            UITabBar.appearance().backgroundColor = .white
        }
    }
        
    
    //    func deleteItem(indexSet: IndexSet) {
    //        items.remove(atOffsets: indexSet)
    //    }
    //
    //    func moveItem(from: IndexSet, to: Int) {
    //        items.move(fromOffsets: from, toOffset: to)
    //    }
    
}

struct ListView2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView2()
        }
        .preferredColorScheme(.light)
        .environmentObject(ListViewModel())
    }
}
