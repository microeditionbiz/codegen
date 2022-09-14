//
//  ContentWritter.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 12/09/2022.
//

import Foundation
import PathKit

public protocol ContentWritter {
    func save(content: String, at path: Path) throws
}

public struct DefaultContentWritter: ContentWritter {

    public init() { }

    public func save(content: String, at path: Path) throws {
        try path.createIntermediateDirectoriesIfNeeded()

        try content.write(
            toFile: path.string,
            atomically: true,
            encoding: .utf8)
    }

}
