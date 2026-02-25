//
//  ContentView.swift
//  CAPI2.0
//
//  Created by Brandon Aubrey on 2/12/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }
            RandomView()
                .tabItem {
                    Label("Random", systemImage: "person.fill")
                }
            FactsView()
                .tabItem {
                    Label("Facts", systemImage: "person.fill")
                }
        }
    }
}


#Preview {
    ContentView()
}
