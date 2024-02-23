//
//  AddView.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    let secondaryAccentColor = Color("SecondAccentColor")
    let backgroundColor = Color("background")
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        
        ZStack {
            Color(backgroundColor)
                .ignoresSafeArea()
            ScrollView {
                
                VStack {
                    
                    TextField("Type something here...", text: $textFieldText)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888, opacity: 0.429))
                        .cornerRadius(10.0)
                    Button(action: saveButtonPressed, label: {
                        //SAVE BUTTON
                        Text("Save".uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(secondaryAccentColor)
                            .cornerRadius(10.0)
                    })   
                }
                .padding()
            }
            .navigationTitle("Add a Task 🖋️")
        .alert(isPresented: $showAlert, content: getAlert)
        }
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool{
        if textFieldText.count < 3 {
            alertTitle = "Your new task must be at least 3 characters long! 😱"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert{
        return Alert(title: Text(alertTitle))
    }
}

#Preview {
    NavigationView {
        AddView()
    }
    .environmentObject(ListViewModel())
}
