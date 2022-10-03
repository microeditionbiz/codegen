//
//  MockFeatureTogglesProvider.swift
//  FeatureToggles
//
//  Created by Pablo Ezequiel Romero Giovannoni on 02/10/2022.
//

import Foundation

public struct MockFeatureTogglesProvider: FeatureTogglesProvider {

    public func fetchFeatureToggles(_ completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            completion(.success(()))
        }
    }

    public func value<T>(_ type: T.Type, for key: String) -> T? { nil }

}
