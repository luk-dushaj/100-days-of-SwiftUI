//
//  ContentView.swift
//  Navigation
//
//  Created by user on 6/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var path = [Int]()
    
    var body: some View {
    
        NavigationStack(path: $path) {
            VStack {
                
            }
            .navigationDestination (for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
}

#Preview {
    ContentView()
}
