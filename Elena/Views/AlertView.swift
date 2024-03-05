//
//  AlertView.swift
//  Elena
//
//  Created by Daniele Perrupane on 05/03/24.
//

import SwiftUI

struct AlertView: View{
    
    @State var showAlert: Bool = false
    var body: some View {
        Image("LaunchScreen")
            .scaleEffect()
        Text("You made it!")
            .bold()
            .font(.largeTitle)
    }
}

#Preview {
    AlertView()
}
