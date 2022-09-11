//
//  main.swift
//  File-Input-Codegenerator
//
//  Created by Pablo Ezequiel Romero Giovannoni on 08/08/2022.
//

import Foundation
import ArgumentParser
import Generator

//$ <command> -i sentence.yml -t templates/template.stencil -o Autogenerated.swift
struct Codegen: ParsableCommand {
    // Passed as --input or -i in any order
    @Option(name: .shortAndLong, help: "The input file path used as Context. It has to include a yml, json or plist extension.")
    var input: String

    // Passed as --template or -t in any order
    @Option(name: .shortAndLong, help: "The Stencil template file path.")
    var template: String

    // Passed as --output or -o in any order
    @Option(name: .shortAndLong, help: "The output autogenerated file path.")
    var output: String

    mutating func run() throws {
        let generatorInput = try generatorInput(url: URL(fileURLWithPath: input))

        let generator = Generator(templatesPath: [""])

        do {
            try generator.run(
                input: generatorInput,
                templateFile: template,
                outputFile: output
            )
        } catch {
            print("Error running generator:", error)
        }
    }
}

Codegen.main()