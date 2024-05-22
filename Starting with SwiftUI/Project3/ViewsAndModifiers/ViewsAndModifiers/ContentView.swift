//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by user on 5/20/24.
//

import SwiftUI

struct LargeBlueTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueTitleStyle() -> some View {
        modifier(LargeBlueTitleModifier())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello World!")
            .largeBlueTitleStyle()
    }
}

#Preview {
    ContentView()
}
