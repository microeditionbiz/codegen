//
//  File.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 04/09/2022.
//

import Foundation
import Yams

public enum GeneratorInputError: Error {
    case invalidYaml
}

public protocol GeneratorInput {
    func buildContext() throws -> [String: Any]
}

// MARK: - YAML

public struct YamlInput: GeneratorInput {
    public let file: String

    public init(file: String) {
        self.file = file
    }

    public func buildContext() throws -> [String: Any] {
        let yamlString = try String.init(contentsOfFile: file)
        let context = try Yams.load(yaml: yamlString) as? [String: Any]

        guard let context = context else {
            throw GeneratorInputError.invalidYaml
        }

        return context
    }
}

public extension GeneratorInput where Self == YamlInput {
    static func yamlInput(using file: String) -> Self {
        YamlInput(file: file)
    }
}

// MARK: - JSON

//public struct YamlInput: GeneratorInput {
//    public let file: String
//
//    public init(file: String) {
//        self.file = file
//    }
//
//    public func buildContext() throws -> [String: Any] {
//        let yamlString = try String.init(contentsOfFile: file)
//        let context = try Yams.load(yaml: yamlString) as? [String: Any]
//
//        guard let context = context else {
//            throw GeneratorInputError.invalidYaml
//        }
//
//        return context
//    }
//}
//
//public extension GeneratorInput where Self == YamlInput {
//    static func yamlInput(using file: String) -> Self {
//        YamlInput(file: file)
//    }
//}

// MARK: - PList

//public struct YamlInput: GeneratorInput {
//    public let file: String
//
//    public init(file: String) {
//        self.file = file
//    }
//
//    public func buildContext() throws -> [String: Any] {
//        let yamlString = try String.init(contentsOfFile: file)
//        let context = try Yams.load(yaml: yamlString) as? [String: Any]
//
//        guard let context = context else {
//            throw GeneratorInputError.invalidYaml
//        }
//
//        return context
//    }
//}
//
//public extension GeneratorInput where Self == YamlInput {
//    static func yamlInput(using file: String) -> Self {
//        YamlInput(file: file)
//    }
//}

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
    static func dictionaryInput(using file: String) -> Self {
        DictionaryInput(file: file)
    }
}
