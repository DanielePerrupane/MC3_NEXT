//
//  ElenaApp.swift
//  Elena
//
//  Created by Daniele Perrupane on 28/02/24.
//

import SwiftUI
import SwiftData

@main
struct Elena: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
            
            //            .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}

