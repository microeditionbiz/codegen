//
//  FakeFeatureTogglesProvider.swift
//  FeatureToggles
//
//  Created by Pablo Ezequiel Romero Giovannoni on 02/10/2022.
//

import Foundation

public struct FakeFeatureTogglesProvider: FeatureTogglesProvider {

    public func fetch(_ completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            completion(.success(()))
        }
    }

    public func value<T>(_ featureToggle: FeatureToggle<T>) -> T {
        featureToggle.fallback()
    }

}
