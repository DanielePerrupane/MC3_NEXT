//
//  GrowthView.swift
//  Elena
//
//  Created by Daniele Perrupane on 23/02/24.
//

import SwiftUI

struct OldGrowthView: View {
    
    let secondaryColor = Color("AccentColor")
    let backgroundColor = Color("background")
    
    let percentage: String = "0%"
    let taskNumber: String = "00/100"
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
    }
}



#Preview {
    OldGrowthView()
}
