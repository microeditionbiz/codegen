//
//  PathKit+.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 12/09/2022.
//

import Foundation
import PathKit

extension Path {
    func createIntermediateDirectoriesIfNeeded() throws {
        let componentsWithoutLast = self.components.dropLast()
        if !componentsWithoutLast.isEmpty {
            let pathWithoutLastComponent = Path(componentsWithoutLast.joined(separator: "/"))
            if !pathWithoutLastComponent.exists {
                try pathWithoutLastComponent.mkpath()
            }
        }
    }
}
