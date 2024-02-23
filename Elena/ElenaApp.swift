//
//  ElenaApp.swift
//  Elena
//
//  Created by Alekseenko Artem   on 19/02/24.
//

import SwiftUI

@main
struct ElenaApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView2()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
            
        }
    }
}
