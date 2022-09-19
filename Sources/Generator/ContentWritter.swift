//
//  ContentWritter.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 12/09/2022.
//

import Foundation

public enum ContentWritterError: Error {
    case pathExist(String)
}

public protocol ContentWritter {
    func save(content: String, at path: String, override: Bool) throws
}

public struct DefaultContentWritter: ContentWritter {
    private let fileManager: FileManager

    public init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }

    public func save(content: String, at path: String, override: Bool) throws {
        switch (fileManager.fileExists(atPath: path), override) {
        case (true, false):
            throw ContentWritterError.pathExist(path)
        case (true, true):
            break
        case (false, _):
            try fileManager.createIntermediateDirectoriesIfNeeded(path)
        }

        try content.write(
            toFile: path,
            atomically: true,
            encoding: .utf8)
    }

}
