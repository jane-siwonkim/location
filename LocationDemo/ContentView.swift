//
//  ContentView.swift
//  LocationDemo
//
//  Created by Siwon Kim on 12/29/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var location: LocationManager = LocationManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
