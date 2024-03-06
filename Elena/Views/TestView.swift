//
//  TestView.swift
//  Elena
//
//  Created by Daniele Perrupane on 05/03/24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        TabView{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            tabItem {
                Text("1")
                Image(systemName: "plus.circle.fill")
            }.tag(1)
            tabItem {
                Text("2")
                Image(systemName: "plus.circle.fill")
            }.tag(2)
            tabItem {
                Text("3")
                Image(systemName: "plus.circle.fill")
            }.tag(3)
            tabItem {
                Text("4")
                Image(systemName: "plus.circle.fill")
            }.tag(4)
                
        }
        
    }
}

#Preview {
    TestView()
}
