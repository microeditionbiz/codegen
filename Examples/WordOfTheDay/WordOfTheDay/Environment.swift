//
//  Environment.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 08/10/2022.
//

import Foundation

struct Environment {
    var featureToggles: FeatureTogglesProvider = FirebaseConfigurationProvider()
    var fetchWOD: () -> String
}

var Current = Environment(
    featureToggles: FirebaseConfigurationProvider(),
    fetchWOD: {
        ["car", "holiday", "rain", "elephant"].randomElement()!
    })
