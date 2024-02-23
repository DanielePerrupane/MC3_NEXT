//
//  GrowthView.swift
//  Elena
//
//  Created by Daniele Perrupane on 23/02/24.
//

import SwiftUI

struct GrowthView: View {
    
    let secondaryColor = Color("AccentColor")
    var body: some View {
        ZStack {
            
            Color(red: 0.96, green: 0.98, blue: 0.95)
                .ignoresSafeArea()

            VStack {
                Text("Elena.")
                    .font(Font.custom("Futura", size: 34).weight(.bold))
                    .kerning(0.374)
                    .foregroundColor(secondaryColor)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Spacer()
                
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 174, height: 250)
                    .clipped()
                
                
                
                Text("10%")
                    .font(Font.custom("SF Pro", size: 17).weight(.semibold))
                    .foregroundColor(secondaryColor)
                
                Spacer()
                Spacer()

            }
            .padding(.horizontal)
        }
    }
}



#Preview {
    GrowthView()
}
