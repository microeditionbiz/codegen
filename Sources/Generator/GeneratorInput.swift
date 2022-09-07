//
//  File.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 04/09/2022.
//

import Foundation
import Yams

public enum GeneratorInputError: Error {
    case invalidInputFile
    case invalidPath(String)
}

public protocol GeneratorInput {
    func buildContext() throws -> [String: Any]
}

// MARK: - YAML

public struct YAMLInput: GeneratorInput {
    public let file: String

    public init(file: String) {
        self.file = file
    }

    public func buildContext() throws -> [String: Any] {
        let yamlString = try String.init(contentsOfFile: file)
        let context = try Yams.load(yaml: yamlString) as? [String: Any]

        guard let context = context else {
            throw GeneratorInputError.invalidInputFile
        }

        return context
    }
}

public extension GeneratorInput where Self == YAMLInput {
    static func yamlInput(using file: String) -> Self {
        YAMLInput(file: file)
    }
}

// MARK: - JSON

public struct JSONInput: GeneratorInput {
    public let file: String

    public init(file: String) {
        self.file = file
    }

    public func buildContext() throws -> [String: Any] {
        let data = try Data(contentsOf: URL(fileURLWithPath: file))
        let context = try JSONSerialization.jsonObject(with: data)

        guard let context = context as? [String: Any] else {
            throw GeneratorInputError.invalidInputFile
        }

        return context
    }
}

public extension GeneratorInput where Self == JSONInput {
    static func jsonInput(using file: String) -> Self {
        JSONInput(file: file)
    }
}

// MARK: - PList

public struct PLISTInput: GeneratorInput {
    public let file: String

    public init(file: String) {
        self.file = file
    }

    public func buildContext() throws -> [String: Any] {
        let data = try Data(contentsOf: URL(fileURLWithPath: file))
        let context = try PropertyListSerialization.propertyList(
            from: data,
            format: nil)

        guard let context = context as? [String: Any] else {
            throw GeneratorInputError.invalidInputFile
        }

        return context
    }
}

public extension GeneratorInput where Self == PLISTInput {
    static func plistInput(using file: String) -> Self {
        PLISTInput(file: file)
    }
}

// MARK: - Dictionary

public struct DictionaryInput: GeneratorInput {
    public let dictionary: [String: Any]

    public init(dictionary: [String: Any]) {
        self.dictionary = dictionary
    }

    public func buildContext() throws -> [String: Any] {
        dictionary
    }
}

public extension GeneratorInput where Self == DictionaryInput {
    static func dictionaryInput(using dictionary: [String: Any]) -> Self {
        DictionaryInput(dictionary: dictionary)
    }
}
