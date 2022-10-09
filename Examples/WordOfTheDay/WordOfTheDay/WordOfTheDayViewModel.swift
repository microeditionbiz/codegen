//
//  WordOfTheDayViewModel.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 09/10/2022.
//

import SwiftUI

final class WordOfTheDayViewModel: ObservableObject {
    typealias Context = HasFeatureTogglesProvider

    let words: [String]?
    let title: String?

    @Published var word: String

    init(context: Context) {
        words = context.featureToggles.value(.words)["words"] as? [String]
        title = context.featureToggles.value(.title)
        word = "Tap Start to begin"
    }

    func refresh() {
        guard let word = words?.randomElement() else { return }
        self.word = word
    }
}
