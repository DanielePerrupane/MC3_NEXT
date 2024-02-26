//
//  Task2.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//

import Foundation


//IMMUTABLE STRUCT
struct ItemModel: Identifiable, Codable, Equatable{
    
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
    
}
