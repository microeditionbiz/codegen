//
//  GeneratorInput.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 04/09/2022.
//

import Foundation
import Yams

public protocol GeneratorInput {
    func buildContext() throws -> [String: Any]
}

public func generatorInput(url: URL) throws -> GeneratorInput {
    let pathExtension = url.pathExtension
    guard !pathExtension.isEmpty else {
        throw GeneratorError.missingExtension(url)
    }

    switch pathExtension {
    case "yml": return .yamlInput(using: url)
    case "json": return .jsonInput(using: url)
    case "plist": return .plistInput(using: url)
    default: throw GeneratorError.unsupportedExtension(pathExtension)
    }
}

// MARK: - YAML

public struct YAMLInput: GeneratorInput {
    public let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func buildContext() throws -> [String: Any] {
        let data = try Data(contentsOf: url)
        let context = try Parser(yaml: data).singleRoot()?.any as? [String: Any]

        guard let context = context else {
            throw GeneratorError.invalidInputFileContent
        }

        return context
    }
}

public extension GeneratorInput where Self == YAMLInput {
    static func yamlInput(using url: URL) -> Self {
        YAMLInput(url: url)
    }
}

// MARK: - JSON

public struct JSONInput: GeneratorInput {
    public let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func buildContext() throws -> [String: Any] {
        let data = try Data(contentsOf: url)
        let context = try JSONSerialization.jsonObject(with: data)

        guard let context = context as? [String: Any] else {
            throw GeneratorError.invalidInputFileContent
        }

        return context
    }
}

public extension GeneratorInput where Self == JSONInput {
    static func jsonInput(using url: URL) -> Self {
        JSONInput(url: url)
    }
}

// MARK: - PList

public struct PLISTInput: GeneratorInput {
    public let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func buildContext() throws -> [String: Any] {
        let data = try Data(contentsOf: url)
        let context = try PropertyListSerialization.propertyList(
            from: data,
            format: nil)

        guard let context = context as? [String: Any] else {
            throw GeneratorError.invalidInputFileContent
        }

        return context
    }
}

public extension GeneratorInput where Self == PLISTInput {
    static func plistInput(using url: URL) -> Self {
        PLISTInput(url: url)
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
