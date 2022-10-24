//
//  WordOfTheDayViewModel.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 09/10/2022.
//

import SwiftUI

final class WordOfTheDayViewModel: ObservableObject {
    @Environment(\.featureTogglesProvider)
    private var featureToggles: FeatureTogglesProvider

    private var words: [String]? {
        featureToggles.value(.words)["words"] as? [String]
    }

    var title: String? {
        featureToggles.value(.title)
    }

    @Published var word: String = "Tap Start to begin"

    func refresh() {
        self.word = words?.randomElement() ?? "No words to show"
    }
}
