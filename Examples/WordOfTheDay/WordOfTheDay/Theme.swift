//
//  Theme.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 09/10/2022.
//

import SwiftUI

struct Theme {
    typealias Context = HasFeatureTogglesProvider
    private let context: Context

    init(context: Context) {
        self.context = context
    }

    var mainColor: Color {
        Color(hex: context.featureToggles.value(.mainColor))
    }

    var accentColor: Color {
        Color(hex: context.featureToggles.value(.accentColor))
    }
}
