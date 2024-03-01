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
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()    
        }
        .modelContainer(ItemsContainer.create(shouldCreateDefaults: &isFirstTimeLaunch))
    }
}

