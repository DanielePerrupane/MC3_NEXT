//
//  Task2.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//

import Foundation


//IMMUTABLE STRUCT
struct OldItemModel: Identifiable, Codable, Equatable{
    
    let id: String
    var title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> OldItemModel {
        return OldItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}


