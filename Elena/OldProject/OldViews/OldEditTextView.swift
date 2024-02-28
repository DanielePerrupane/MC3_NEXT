//
//  AddView.swift
//  Elena
//
//  Created by Daniele Perrupane on 21/02/24.
//
import AlertToast
import SwiftUI
import Foundation

struct OldEditTextView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: OldListViewModel
    @State var textFieldText: String = ""
    
    //ALERT
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    //COLOR
    let secondaryAccentColor = Color("SecondAccentColor")
    let backgroundColor = Color("AddColor")
    
    
    
    var body: some View {
        
        ZStack {
            Color(backgroundColor)
                .ignoresSafeArea()
            ScrollView {
                
                VStack {
                    Text("Edit Text 🖋️")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Type something here...", text: $textFieldText)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .foregroundStyle(.black)
                        .background(RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                        ).overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.gray, lineWidth: 1.0))
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
        OldEditTextView()
    }
    .environmentObject(OldListViewModel())
}
