import Foundation
import StencilSwiftKit
import Stencil
import PathKit

public struct Generator {
    private let environment: Environment

    public init(templatesPath: [Path]) {
        var environment = stencilSwiftEnvironment()
        environment.loader = FileSystemLoader(paths: templatesPath)
        self.environment = environment
    }

    public func run(configuration: Configuration, templateName: String, outputPath: Path) throws {
        let context: [String: Any] = ["config": configuration]

        var rendered = try environment.renderTemplate(
            name: templateName,
            context: context)

        rendered = try rendered.format()

        print(rendered)

        try rendered.write(
            toFile: outputPath.string,
            atomically: true,
            encoding: .utf8)
    }
}
