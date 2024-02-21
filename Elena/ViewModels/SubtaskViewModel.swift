//
//  SubtaskViewModel.swift
//  Elena
//
//  Created by Daniele Perrupane on 19/02/24.
//

import Foundation

@Observable
class SubtaskViewModel{
    var subtask = [
    
        SubTask(text: "", isCompleted: false),
        SubTask(text: "", isCompleted: false),
        SubTask(text: "", isCompleted: false),
        SubTask(text: "", isCompleted: false),
        SubTask(text: "", isCompleted: false)
    
    ]
}
