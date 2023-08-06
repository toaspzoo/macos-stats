//
//  ContentView.swift
//  stats
//
//  Created by toaspzoo on 02/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isOn = false
    @State private var cpuTemp = false;
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("Eloszka")
            Toggle(isOn: $isOn) {
                        Text("I'm not a robot")
            }.toggleStyle(.checkbox)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
