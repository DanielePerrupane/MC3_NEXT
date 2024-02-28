//
//  ListViewModel.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//

import Foundation

class OldListViewModel: ObservableObject {
    
    @Published var items: [OldItemModel] = [] {
        didSet{
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        
        guard 
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([OldItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
        
    }
    
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
        
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = OldItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func editText(title: String){
        
    }
 
    func updateItem(item: OldItemModel){
        
        if let index = items.firstIndex(where: { $0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
        
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    
}
