//
//  GrowthView.swift
//  ToDoListPlayground
//
//  Created by Daniele Perrupane on 28/02/24.
//

import SwiftUI

struct GrowthView: View {
    
    let secondaryColor = Color("ElenaColor")
    let backgroundColor = Color("Background")
    
    let percentage: String = "0%"
    let taskNumber: String = "0/50"
    let textDisplayed1: String = "You completed.."
    let textDisplayed2: String = "Your flower is at.."
    
    let selectedAsset = Image(systemName: "")
    
    var body: some View {
        
        
        
        NavigationView {
            ZStack {
                Color(backgroundColor)
                    .ignoresSafeArea()
                VStack {
                    Image("1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 174, height: 250)
                        .clipped()
                    Text(textDisplayed1)
                        .font(.title)
                        .foregroundColor(secondaryColor)
                        
                    Text(taskNumber)
                        .font(.title2)
                        .foregroundColor(secondaryColor)
                        .fontWeight(.bold)
                    
                    Text(textDisplayed2)
                        .font(.title)
                        .foregroundColor(secondaryColor)
                    
                    Text(percentage)
                        .font(.title2)
                        .foregroundColor(secondaryColor)
                        .fontWeight(.bold)
//                        .padding(.top,30)
                }
                .padding(.bottom, 100)
                .navigationTitle("Elena")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    GrowthView()
}
