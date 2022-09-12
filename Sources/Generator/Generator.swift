import Foundation
import StencilSwiftKit
import Stencil
import PathKit


public struct Generator {
    private let environment: Environment

    public init(templatesPath: [String]) {
        var environment = stencilSwiftEnvironment()
        environment.loader = FileSystemLoader(paths: templatesPath.map { Path.init($0) })
        self.environment = environment
    }

    public func run(input: GeneratorInput, templateFile: String, outputFile: String) throws {
        let context = try input.buildContext()
        try run(context: context, templateFile: templateFile, outputFile: outputFile)
    }

    private func run(context: [String: Any], templateFile: String, outputFile: String) throws {
        var rendered = try environment.renderTemplate(
            name: templateFile,
            context: context)

        rendered = try rendered.format()

        if let files = try FileAnnotatedContent.process(using: rendered), !files.isEmpty {
            try files.forEach(save)
        } else {
            try save(content: rendered, at: Path(outputFile))
        }
    }

    private func save(content: String, at path: Path) throws {
        print("path", path)
        print("content", content)

        try path.createIntermediateDirectoriesIfNeeded()

        try content.write(
            toFile: path.string,
            atomically: true,
            encoding: .utf8)
    }

}
