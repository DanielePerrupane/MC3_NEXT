//
//  TabBarView.swift
//  Elena
//
//  Created by Daniele Perrupane on 23/02/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 2
    @EnvironmentObject var listViewModel: ListViewModel
    var body: some View {
        TabView(selection: $selectedTab) {
          
                GrowthView()
            
            .tabItem {
                Text("TabItem1")
                Image(systemName: "1.circle.fill")
            }.tag(1)
            
            NoTasksView()
            .tabItem {
                Text("TabItem2")
                Image(systemName: "2.circle.fill")
                
            }.tag(2)
        }
        .onAppear(){
            UITabBar.appearance().backgroundColor = .white
        }
        
    }
}


#Preview {
    TabBarView()
}
