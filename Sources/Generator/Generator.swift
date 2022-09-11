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

        var rendered = try environment.renderTemplate(
            name: templateFile,
            context: context)

        rendered = try rendered.format()

        if let files = try FileAnnotationsFinder.files(from: rendered), !files.isEmpty {
            try files.forEach { (path, content) in
                print("path", path)
                print("content", content)

                try content.write(
                    toFile: path,
                    atomically: true,
                    encoding: .utf8)
            }
        } else {
            print(rendered)

            try rendered.write(
                toFile: outputFile,
                atomically: true,
                encoding: .utf8)
        }
    }

    private func run(context: [String: Any], templateFile: String, outputFile: String) throws {
        var rendered = try environment.renderTemplate(
            name: templateFile,
            context: context)

        rendered = try rendered.format()

        print(rendered)

        try rendered.write(
            toFile: outputFile,
            atomically: true,
            encoding: .utf8)
    }
}
