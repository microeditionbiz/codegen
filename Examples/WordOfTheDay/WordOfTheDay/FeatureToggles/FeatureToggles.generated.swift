//
//  FeatureToggles.generated.swift
//  FeatureToggles
//
//  Generated by codegen. Don't change this file manually.
//  Run `sh WordOfTheDay/WordOfTheDay/FeatureToggles/generate.sh` to regenerate it.
//

import Foundation

public typealias JSON = [String: Any]

public extension FeatureToggle where T == String {
    /// Current accent color.
    static let accentColor: FeatureToggle = .init(key: "accentColor", fallback: "FFFFFF")

    /// Current main color.
    static let mainColor: FeatureToggle = .init(key: "mainColor", fallback: "685634")

    /// Text presented as main title.
    static let title: FeatureToggle = .init(key: "title", fallback: "Word of the day!")
}

public extension FeatureToggle where T == JSON {
    /// Possible words to be presented.
    static let words: FeatureToggle = .init(key: "words", fallback: ["words": ["Car", "Holiday", "Rain", "Elephant"]])
}

