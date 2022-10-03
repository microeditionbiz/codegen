//
//  ContentView.swift
//  FeatureToggles
//
//  Created by Pablo Ezequiel Romero Giovannoni on 28/09/2022.
//

import SwiftUI

struct ContentView: View {
    let featureToggles: FeatureTogglesProvider

    var body: some View {
        Text(featureToggles.value(.title))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(featureToggles: MockFeatureTogglesProvider())
    }
}
