//
//  WordOfTheDayApp.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 08/10/2022.
//

import SwiftUI

@main
struct WordOfTheDayApp: App {
    let dependencyContainer = DependencyContainer()

    var body: some Scene {
        WindowGroup {
            WordOfTheDayView(
                theme: .init(context: dependencyContainer),
                viewModel: .init(context: dependencyContainer)
            )
        }
    }
}
