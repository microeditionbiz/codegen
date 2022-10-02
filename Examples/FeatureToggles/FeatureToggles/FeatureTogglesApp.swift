//
//  FeatureTogglesApp.swift
//  FeatureToggles
//
//  Created by Pablo Ezequiel Romero Giovannoni on 28/09/2022.
//

import SwiftUI

@main
struct FeatureTogglesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(featureToggles: Current.featureToggles)
        }
    }
}
