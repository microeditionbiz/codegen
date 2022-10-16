//
//  FirebaseConfigurationProvider.swift
//  FeatureToggles
//
//  Created by Pablo Ezequiel Romero Giovannoni on 28/09/2022.
//

import Foundation
import FirebaseCore
import FirebaseRemoteConfig

public final class FirebaseConfigurationProvider: FeatureTogglesProvider {
    private let remoteConfig: RemoteConfig

    init() {
        FirebaseApp.configure()

        let remoteConfig = RemoteConfig.remoteConfig()

        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        self.remoteConfig = remoteConfig
    }

    public func fetch(_ completion: @escaping (Result<Void, Error>) -> Void) {
        remoteConfig.activate()
        remoteConfig.fetch { status, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    public func value<T>(_ featureToggle: FeatureToggle<T>) -> T {
        let key = featureToggle.key

        let remoteConfigValue = RemoteConfig.remoteConfig().configValue(
            forKey: key,
            source: .remote
        )

        guard remoteConfigValue.source == .remote else { return featureToggle.fallback() }

        let value: T?

        switch T.self {
        case is String.Type:
            value = remoteConfigValue.stringValue as? T
        case is NSNumber.Type:
            value = remoteConfigValue.numberValue as? T
        case is Bool.Type:
            value = remoteConfigValue.boolValue as? T
        default:
            value = remoteConfigValue.jsonValue as? T
        }

        return value ?? featureToggle.fallback()
    }

}
