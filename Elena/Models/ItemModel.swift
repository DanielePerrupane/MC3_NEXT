//
//  Task2.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//

import Foundation

struct ItemModel: Identifiable{
    
    let id: String = UUID().uuidString
    let title: String
    let isCompleted: Bool
    
}
