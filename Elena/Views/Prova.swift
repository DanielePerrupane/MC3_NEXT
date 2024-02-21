//
//  TaskRowView.swift
//  MC3_NEXT
//
//  Created by Daniele Perrupane on 19/02/24.
//

import SwiftUI

struct SubTaskListView: View {
    var viewModel: SubTaskViewModel
    let subtasks: [SubTask]
    
    var body: some View {
        
        NavigationStack {
            Divider()
            
            List(subtasks){ subtask in
                
                
                
            }
            .navigationTitle("Daily Tasks")
            .toolbar{
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
            
            
            
        }.padding()
    }
}


struct TaskRowView: View {
    
    @State var task: SubTask
    
    var body: some View {
        
        HStack{
            Text("\(task.text)")
                .accessibilityLabel("\(task.title)")
            Spacer()
            Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                .resizable()
                .frame(width: 30.0,height: 30.0)
                .onTapGesture {
                    task.isCompleted.toggle()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SubTaskListView(viewModel: SubTaskViewModel())
    }
}
