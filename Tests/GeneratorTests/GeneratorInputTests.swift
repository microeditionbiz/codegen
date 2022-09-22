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
        let path = try XCTUnwrap(
            Bundle.module.path(
                forResource: "input-test",
                ofType: "yml"
            )
        )

        let input = try generatorInput(from: path)
        XCTAssertNotNil(input as? YAMLInput)

        let context = try input.buildContext()
        evaluateContext(context)
    }

    func testJSONInput() throws {
        let path = try XCTUnwrap(
            Bundle.module.path(
                forResource: "input-test",
                ofType: "json"
            )
        )

        let input = try generatorInput(from: path)
        XCTAssertNotNil(input as? JSONInput)

        let context = try input.buildContext()
        evaluateContext(context)
    }

    func testPLISTInput() throws {
        let path = try XCTUnwrap(
            Bundle.module.path(
                forResource: "input-test",
                ofType: "plist"
            )
        )

        let input = try generatorInput(from: path)
        XCTAssertNotNil(input as? PLISTInput)

        let context = try input.buildContext()
        evaluateContext(context)
    }

    func testDictionaryInput() throws {
        let string = "{\"list\": [\"first item\", \"second item\"], \"dictionary\": {\"keyString\": \"valueA\", \"keyBool\": true, \"keyNumber\": 12 }}"

        let input = try generatorInput(from: string)
        XCTAssertNotNil(input as? DictionaryInput)

        let context = try input.buildContext()
        evaluateContext(context)
    }

    private func evaluateContext(_ context: [String: Any]) {
        XCTAssertEqual(context.count, 2)
        XCTAssertEqual(context["list"] as? [String], ["first item", "second item"])
        XCTAssertEqual(context["dictionary"] as? [String: AnyHashable], ["keyString": "valueA", "keyBool": true, "keyNumber": 12])
    }

}
