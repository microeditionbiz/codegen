//
//  Environment.swift
//  FeatureToggles
//
//  Created by Pablo Ezequiel Romero Giovannoni on 02/10/2022.
//

import Foundation

struct Environment {
    var featureToggles: FeatureTogglesProvider = FirebaseConfigurationProvider()
}

var Current = Environment()
