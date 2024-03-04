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
    
    //VARIABILI NUMERICHE
    
    let percentage: Double = 0.0
    // Proprietà calcolata per ottenere la prima cifra dopo la virgola
        var firstDecimal: Int {
            return Int((percentage * 10).truncatingRemainder(dividingBy: 10))
        }
    let count: Int = 0
    
    //VARIABILI DI TESTO
    let textDisplayed1: String = "You completed.."
    let textDisplayed2: String = "Your flower is at.."
    
    let selectedAsset = Image(systemName: "")
    
    var body: some View {
        
        
        
        NavigationView {
            ZStack {
                VStack {
                    Image("1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 174, height: 250)
                        .clipped()
                    Text(textDisplayed1)
                        .font(.title)
                        .foregroundColor(secondaryColor)
                        
                    Text("\(count) tasks")
                        .font(.title2)
                        .foregroundColor(secondaryColor)
                        .fontWeight(.bold)
                    
                    Text(textDisplayed2)
                        .font(.title)
                        .foregroundColor(secondaryColor)
                    
                    Text("\(firstDecimal)%")
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
