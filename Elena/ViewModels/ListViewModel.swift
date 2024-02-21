//
//  ListViewModel.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = []
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems = [
            
            ItemModel(title: "First Title!", isCompleted: false),
            ItemModel(title: "Second Title!", isCompleted: true),
            ItemModel(title: "Third Title!", isCompleted: false)
            
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}
