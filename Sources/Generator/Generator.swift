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
    private let environment: Environment
    private let contentWritter: ContentWritter

    public init(templatesPath: [String], contentWritter: ContentWritter = DefaultContentWritter.init()) {
        var environment = stencilSwiftEnvironment()
        environment.loader = FileSystemLoader(paths: templatesPath.map { Path.init($0) })
        self.environment = environment
        self.contentWritter = contentWritter
    }

    @discardableResult
    public func run(input: GeneratorInput, templateFile: String, output: String) throws -> [String] {
        try run(
            context: try input.buildContext(),
            templateFile: templateFile,
            output: output
        )
    }

    private func run(context: [String: Any], templateFile: String, output: String) throws -> [String] {
        let rendered = try environment.renderTemplate(
            name: templateFile,
            context: context
        )

//        rendered = try rendered.format()

        if let files = try FileAnnotatedContent.process(using: rendered), !files.isEmpty {
            let filesWithOutputPath = files
                .map { ($0.content, Path(output) + $0.path) }
            try filesWithOutputPath.forEach(contentWritter.save)
            return filesWithOutputPath.map(\.1.string)
        } else {
            try contentWritter.save(content: rendered, at: Path(output))
            return [output]
        }
    }

}
