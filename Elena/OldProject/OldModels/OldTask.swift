//
//  Task.swift
//  Elena
//
//  Created by Daniele Perrupane on 19/02/24.
//

import Foundation
import SwiftUI

struct OldTask: Identifiable {
    
    var id: UUID = UUID()
    var title: String
    var subtask: [SubTask]
    @State var isCompleted: Bool
    
}

struct SubTask: Identifiable {
    
    var id: UUID = UUID()
    var text: String
    var isCompleted: Bool
    
}


