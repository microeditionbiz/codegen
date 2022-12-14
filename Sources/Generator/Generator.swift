//
//  Generator.swift
//
//
//  Created by Pablo Ezequiel Romero Giovannoni on 09/09/2022.
//

import Foundation
import StencilSwiftKit
import Stencil
import PathKit


public struct Generator {
    public static let defaultAutogenerateFilename = "autogenerated"
    private let environment: Environment
    private let contentWritter: ContentWritter

    public init(templatesPath: [String], contentWritter: ContentWritter = DefaultContentWritter.init()) {
        var environment = stencilSwiftEnvironment()
        environment.loader = FileSystemLoader(paths: templatesPath.map { Path.init($0) })
        self.environment = environment
        self.contentWritter = contentWritter
    }

    @discardableResult
    public func run(
        input: GeneratorInput,
        templateFile: String,
        output: String?,
        override: Bool
    ) throws -> [String] {
        try write(
            try generateOutput(
                from: try input.buildContext(),
                templateFile: templateFile,
                outputLocation: output),
            override: override
        )
    }

    private func generateOutput(
        from context: [String: Any],
        templateFile: String,
        outputLocation: String?
    ) throws -> [(content: String, path: String)] {
        let rendered = try environment.renderTemplate(
            name: templateFile,
            context: context
        )

        let output = try FileAnnotatedContent.process(content: rendered)

        if output.isEmpty {
            return [(rendered, outputLocation ?? Self.defaultAutogenerateFilename)]
        } else {
            let appendRootDirectory = appendRootDirectory(outputLocation)
            return output.map(appendRootDirectory)
        }
    }

    private func write(_ output: [(String, path: String)], override: Bool) throws -> [String] {
        try output.forEach { (content, path) in
            try contentWritter.save(
                content: content,
                at: path,
                override: override
            )
        }

        return output.map(\.path)
    }

}
