//
//  EnvironmentValues.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 08/10/2022.
//

import Foundation
import SwiftUI

struct FeatureTogglesProviderKey: EnvironmentKey {
    static var defaultValue: FeatureTogglesProvider = FirebaseConfigurationProvider()
}

extension EnvironmentValues {
    var featureTogglesProvider: FeatureTogglesProvider {
        set { self[FeatureTogglesProviderKey.self] = newValue }
        get { self[FeatureTogglesProviderKey.self] }
    }
}
