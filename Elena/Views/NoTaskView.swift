//
//  NoTaskView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 28/02/24.
//


import SwiftUI

struct NoTasksView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("ElenaColor")
    @State var showModal = false
    //let backgroundColor = Color("background")
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 10) {
                
                Text("There are no tasks yet, \ntry adding your \nfirst task with the button below ")
                    //.font(.title)
                    .fontWeight(.semibold)
                //CONCORDARE UN TESTO
                //Text("Here you can add the tasks ")
                    .padding(.bottom, 20)
                Button(action: {showModal = true},
                       label: {
                    Text("Add Something 🌼")
                    //COLORE TESTO
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                    
                    //CONCORDARE COLORE BOTTONE
                        .background(secondaryAccentColor)
                        .cornerRadius(10)
                })
                .sheet(isPresented: $showModal) {
                    CreateToDoView()
                        
                }
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(
                    color: secondaryAccentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0,
                    y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? 7 : 0)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
    
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationView {
        NoTasksView()
            .navigationTitle("Title")
    }
    
}

