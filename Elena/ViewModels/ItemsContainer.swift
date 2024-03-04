//
//  ItemsContainer.swift
//  Elena
//
//  Created by Daniele Perrupane on 01/03/24.
//

import Foundation
import SwiftData

actor ItemsContainer {
    
    @MainActor
    static func create(shouldCreateDefaults: inout Bool) -> ModelContainer {
        
        let schema = Schema([Item.self])
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: configuration)
        if shouldCreateDefaults {
            
            let categories = CategoriesJSONDecoder.decode(from: "CategoryDefaults")
            if categories.isEmpty == false {
                categories.forEach{ item in
                    let category = Category(title: item.title)
                    container.mainContext.insert(category)
                }
            }
            
//            Category.defaults.forEach{ container.mainContext.insert($0)}
//            shouldCreateDefaults = false
        }
       
        return container
        
    }
    
}
