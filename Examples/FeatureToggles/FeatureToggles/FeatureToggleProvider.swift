//
//  FeatureToggleProvider.swift
//  FeatureToggles
//
//  Created by Pablo Ezequiel Romero Giovannoni on 28/09/2022.
//

import Foundation

public protocol FeatureTogglesProvider {
    func fetchFeatureToggles(_ completion: @escaping (Result<Void, Error>) -> Void)
    func value<T>(_ type: T.Type, for key: String, fallback: T) -> T
}
