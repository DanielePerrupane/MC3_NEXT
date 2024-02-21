//
//  TasksListView.swift
//  Elena
//
//  Created by Daniele Perrupane on 19/02/24.
//

import SwiftUI

struct UselessView: View {
    
    var tasks: Task
    var body: some View {
        
        NavigationStack {
            
                
        }.padding()
    }
}




#Preview {
    UselessView(tasks: Task(title: "Ciao", subtask: [SubTask(text: "description1", isCompleted: false)], isCompleted: false))
}
