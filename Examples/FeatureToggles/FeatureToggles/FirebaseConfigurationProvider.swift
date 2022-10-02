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

        remoteConfig.activate()

        self.remoteConfig = remoteConfig
    }

    public func fetchFeatureToggles(_ completion: @escaping (Result<Void, Error>) -> Void) {
        remoteConfig.fetch { status, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    private func remoteConfigValue(for key: String) -> RemoteConfigValue? {
        let remoteConfigValue = RemoteConfig.remoteConfig().configValue(
            forKey: key,
            source: .remote
        )

        return remoteConfigValue.source == .remote ? remoteConfigValue : nil
    }

    public func value<T>(_ type: T.Type, for key: String, fallback: T) -> T {
        guard let remoteConfigValue = remoteConfigValue(for: key) else {
            return fallback
        }

        switch type {
        case is String.Type:
            return (remoteConfigValue.stringValue as? T) ?? fallback
        case is NSNumber.Type:
            return (remoteConfigValue.numberValue as? T) ?? fallback
        case is Bool.Type:
            return (remoteConfigValue.boolValue as? T) ?? fallback
        default:
            return (remoteConfigValue.jsonValue as? T) ?? fallback
        }
    }


}
