//
//  GrowthView.swift
//  Elena
//
//  Created by Daniele Perrupane on 23/02/24.
//

import SwiftUI

struct GrowthView: View {
    
    let secondaryColor = Color("AccentColor")
    let backgroundColor = Color("background")
    
    let percentage: String = "0%"
    
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
                    Text(percentage)
                        .font(Font.custom("SF Pro", size: 17).weight(.semibold))
                        .foregroundColor(secondaryColor)
                        .padding(.top,30)
                }
                .padding(.bottom, 100)
                .navigationTitle("Elena")
            }
        }
    }
}



#Preview {
    GrowthView()
}
