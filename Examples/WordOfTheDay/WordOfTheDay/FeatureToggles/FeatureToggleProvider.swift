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
    func fetch(_ completion: @escaping (Result<Void, Error>) -> Void)
    func value<T>(_ featureToggle: FeatureToggle<T>) -> T
}

public extension FeatureTogglesProvider {
    func fetch() {
        fetch { _ in }
    }
}
