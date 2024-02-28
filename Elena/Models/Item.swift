//
//  Model.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 27/02/24.
//

import Foundation
import SwiftData

@Model
class Item {
    
    var title: String
    var timeStamp: Date
//    var isCritical: Bool
    var isCompleted: Bool
    
    //CONTROLLARE IL COMPORTAMENTO SENZA .nullify (con .nullify dava errore)
    @Relationship(inverse: \Category.items)
    var category: Category?
    
    init(title: String = "",
         timeStamp: Date = .now,
//         isCritical: Bool = false,
         isCompleted: Bool = false) {
        self.title = title
        self.timeStamp = timeStamp
//        self.isCritical = isCritical
        self.isCompleted = isCompleted
    }
    
}

extension Item {
    
    static var dummy: Item {
        .init(title: "Item 1",
              timeStamp: .now)
    }
}


