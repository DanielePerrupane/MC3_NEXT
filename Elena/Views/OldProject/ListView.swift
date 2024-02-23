//
//  ListView.swift
//  Elena
//
//  Created by Daniele Perrupane on 19/02/24.
//

import SwiftUI


struct ListView: View {
        var task: Task
        var viewModel = TaskViewModel()
        var viewSubModel = SubtaskViewModel()
        @State var subtask: SubTask
    
    
    
    var body: some View {
        NavigationView {
            
            
            
            
            
            
            
                        List{
                            ForEach(viewModel.tasks) { task in
                                Section() {
                                    DisclosureGroup("\(task.title)") {
                                        ForEach(task.subtask) { subtask in
                                            HStack {
                                                //AGGIUNGERE IL TAP DELLA CHECKBOX
                                                Image(systemName: "checkmark.circle")
                                                    .resizable()
                                                    .frame(width: 30.0,height: 30.0)
                                                Text("\(subtask.text)")
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        //.listStyle(PlainListStyle())
                        .navigationTitle("Daily Tasks 📝")
                        .navigationBarItems(
                            leading: EditButton(),
                            trailing: NavigationLink("Add", destination: AddView()))
                    }
        }
    }
    
    
    #Preview {
            ListView(task: Task(title: "selfcare", subtask: [SubTask(text: "", isCompleted: false)], isCompleted: false), subtask: SubTask(text: "titolo subtask", isCompleted: false))
    }
