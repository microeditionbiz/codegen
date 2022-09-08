//
//  GeneratorInputTests.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 07/09/2022.
//

import Foundation
import XCTest
@testable import Generator

class GeneratorInputTests: XCTestCase {

    func testYAMLInput() throws {
        let url = try XCTUnwrap(
            Bundle.module.url(
                forResource: "input-test",
                withExtension: "yml"
            )
        )

        let input = try generatorInput(url: url)
        XCTAssertNotNil(input as? YAMLInput)

        let context = try input.buildContext()
        evaluateContext(context)
    }

    func testJSONInput() throws {
        let url = try XCTUnwrap(
            Bundle.module.url(
                forResource: "input-test",
                withExtension: "json"
            )
        )

        let input = try generatorInput(url: url)
        XCTAssertNotNil(input as? JSONInput)

        let context = try input.buildContext()
        evaluateContext(context)
    }

    func testPLISTInput() throws {
        let url = try XCTUnwrap(
            Bundle.module.url(
                forResource: "input-test",
                withExtension: "plist"
            )
        )

        let input = try generatorInput(url: url)
        XCTAssertNotNil(input as? PLISTInput)

        let context = try input.buildContext()
        evaluateContext(context)
    }

    func testDictionaryInput() throws {
        let input: GeneratorInput = .dictionaryInput(using: [
            "list": ["first item", "second item"],
            "dictionary": ["keyString": "valueA", "keyBool": true, "keyNumber": 12]
        ])

        let context = try input.buildContext()
        evaluateContext(context)
    }

    private func evaluateContext(_ context: [String: Any]) {
        XCTAssertEqual(context.count, 2)
        XCTAssertEqual(context["list"] as? [String], ["first item", "second item"])
        XCTAssertEqual(context["dictionary"] as? [String: AnyHashable], ["keyString": "valueA", "keyBool": true, "keyNumber": 12])
    }

}
