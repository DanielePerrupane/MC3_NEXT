//
//  ListView2.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//

import SwiftUI

struct ListView2: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    let secondaryAccentColor = Color("SecondAccentColor")
    let backgroundColor = Color("background")
    
    //    @State var items: [ItemModel] = [
    //
    //        ItemModel(title: "First Title!", isCompleted: false),
    //        ItemModel(title: "Second Title!", isCompleted: true),
    //        ItemModel(title: "Third Title!", isCompleted: false)
    //
    //    ]
    
    /*
     CRUD FUNCTION
     Create
     Read
     Update
     Delete
     */
    
    var body: some View {
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
                            //TAP GESTURE
                                .onTapGesture {
                                    withAnimation(.linear){
                                        listViewModel.updateItem(item: item)
                                    }
                                }
                                
                            
                        }
                        .onDelete(perform: listViewModel.deleteItem)
                        .onMove(perform: listViewModel.moveItem)
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
