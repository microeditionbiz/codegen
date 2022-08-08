//
//  main.swift
//  File-Input-Codegenerator
//
//  Created by Pablo Ezequiel Romero Giovannoni on 08/08/2022.
//

import Foundation
import ArgumentParser

struct Generate: ParsableCommand {
//    It's a bool flag
    @Flag(help: "Include a counter with each repetition.")
    var includeCounter = false

//    Passed as --count or -c in any order
    @Option(name: .shortAndLong, help: "The number of times to repeat 'phrase'.")
    var count: Int?

//    Passed without arguments
    @Argument(help: "The phrase to repeat.")
    var phrase: String

    mutating func run() throws {
        let repeatCount = count ?? 2

        for i in 1...repeatCount {
            if includeCounter {
                print("\(i): \(phrase)")
            } else {
                print(phrase)
            }
        }
    }
}

Generate.main()
