//
//  Environment.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 08/10/2022.
//

import Foundation

final class DependencyContainer {
    let featureToggles: FeatureTogglesProvider

    init(featureToggles: FeatureTogglesProvider = FirebaseConfigurationProvider()) {
        self.featureToggles = featureToggles
    }
}

extension DependencyContainer {
    static var fake: DependencyContainer {
        .init(featureToggles: FakeFeatureTogglesProvider())
    }
}

protocol HasFeatureTogglesProvider {
    var featureToggles: FeatureTogglesProvider { get }
}

extension DependencyContainer: HasFeatureTogglesProvider { }
