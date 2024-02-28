//
//  Tasks_viewModel.swift
//  MC3_NEXT
//
//  Created by Daniele Perrupane on 19/02/24.
//

import Foundation
import Observation

@Observable
class OldTaskViewModel {
    
    var tasks = [
        
        OldTask(title: "Selfcare1", subtask: [SubTask(text: "bevi un bicchiere d'acqua", isCompleted: false),SubTask(text: "scrivi una lettera", isCompleted: false), SubTask(text: "mangia un frutto", isCompleted: false),SubTask(text: "abbraccia un tuo caro", isCompleted: false),SubTask(text: "fai una passeggiata", isCompleted: false)], isCompleted: false),
        OldTask(title: "Selfcare2", subtask: [SubTask(text: "de1", isCompleted: false),SubTask(text: "don2", isCompleted: false), SubTask(text: "description3", isCompleted: false),SubTask(text: "description4", isCompleted: false),SubTask(text: "description5", isCompleted: false)], isCompleted: false),
        OldTask(title: "Selfcare3", subtask: [SubTask(text: "description1", isCompleted: false),SubTask(text: "description2", isCompleted: false), SubTask(text: "description3", isCompleted: false),SubTask(text: "description4", isCompleted: false),SubTask(text: "description5", isCompleted: false)], isCompleted: false),
        OldTask(title: "Selfcare4", subtask: [SubTask(text: "description1", isCompleted: false),SubTask(text: "description2", isCompleted: false), SubTask(text: "description3", isCompleted: false),SubTask(text: "description4", isCompleted: false),SubTask(text: "description5", isCompleted: false)], isCompleted: false),
        OldTask(title: "Selfcare5", subtask: [SubTask(text: "description1", isCompleted: false),SubTask(text: "description2", isCompleted: false), SubTask(text: "description3", isCompleted: false),SubTask(text: "description4", isCompleted: false),SubTask(text: "description5", isCompleted: false)], isCompleted: false),
        ]
    
}

@Observable
class SubtaskViewModel{
    var subtask = [
    
        SubTask(text: "des", isCompleted: false),
        SubTask(text: "description2", isCompleted: false),
        SubTask(text: "description3", isCompleted: false),
        SubTask(text: "description4", isCompleted: false),
        SubTask(text: "description5", isCompleted: false)
    
    ]
}
