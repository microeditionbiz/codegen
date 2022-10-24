//
//  Theme.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 09/10/2022.
//

import SwiftUI

struct Theme {
    @Environment(\.featureTogglesProvider) var featureToggles: FeatureTogglesProvider

    var mainColor: Color {
        Color(hex: featureToggles.value(.mainColor))
    }

    var accentColor: Color {
        Color(hex: featureToggles.value(.accentColor))
    }
}
