//
//  ContentView.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 08/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State var currentWord: String?

    var body: some View {
        VStack {
            Text("Tap Start to begin")
                .padding()
            Button("Start") { }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
