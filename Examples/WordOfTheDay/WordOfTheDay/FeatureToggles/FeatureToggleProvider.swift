//
//  FeatureToggleProvider.swift
//  FeatureToggles
//
//  Created by Pablo Ezequiel Romero Giovannoni on 28/09/2022.
//

import Foundation


public struct FeatureToggle<T> {
    let key: String
    let fallback: () -> T

    public init(key: String, fallback: @autoclosure @escaping () -> T) {
        self.key = key
        self.fallback = fallback
    }
}

public protocol FeatureTogglesProvider {
    func fetchFeatureToggles(_ completion: @escaping (Result<Void, Error>) -> Void)
    func value<T>(_ type: T.Type, for key: String) -> T?
}

public extension FeatureTogglesProvider {
    func value<T>(_ featureToggle: FeatureToggle<T>) -> T {
        value(T.self, for: featureToggle.key) ?? featureToggle.fallback()
    }
}
