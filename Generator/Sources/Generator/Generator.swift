import Foundation
import StencilSwiftKit
import Stencil
import PathKit
import Yams

public enum GeneratorError: Error {
    case invalidYaml
}

public struct Generator {
    private let environment: Environment

    public init(templatesPath: [String]) {
        var environment = stencilSwiftEnvironment()
        environment.loader = FileSystemLoader(paths: templatesPath.map { Path.init($0) })
        self.environment = environment
    }

    public func run(inputFile: String, templateFile: String, outputFile: String) throws {
        let yamlString = try String.init(contentsOfFile: inputFile)
        let context = try Yams.load(yaml: yamlString) as? [String: Any]

        guard let context = context else {
            throw GeneratorError.invalidYaml
        }

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
