//
//  FileManager+.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 19/09/2022.
//

import Foundation

extension FileManager {
    func createIntermediateDirectoriesIfNeeded(_ path: String) throws {
        let componentsWithoutLast = path.components(separatedBy: "/").dropLast()

        guard !componentsWithoutLast.isEmpty else { return }

        let pathWithoutLastComponent = componentsWithoutLast.joined(separator: "/")

        guard !fileExists(atPath: pathWithoutLastComponent) else { return }

        try createDirectory(
            atPath: pathWithoutLastComponent,
            withIntermediateDirectories: true,
            attributes: nil
        )
    }
}
