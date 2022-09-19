//
//  GeneratorTests.swift
//
//
//  Created by Pablo Ezequiel Romero Giovannoni on 07/09/2022.
//

import XCTest

@testable import Generator

final class GeneratorTests: XCTestCase {

    static let input: [String: Any] = [
        "people": [
            [
                "name": "Pablo",
                "city": "Barcelona"
            ],
            [
                "name": "Gaby",
                "city": "Barcelona"
            ],
            [
                "name": "Dani",
                "city": "Buenos Aires"
            ],
        ]
    ]

    func testGenerate() throws {
        let mockContentWritter = MockContentWritter()

        let generator = Generator(
            templatesPath: [""],
            contentWritter: mockContentWritter)

        let template = try XCTUnwrap(
            Bundle.module.path(
                forResource: "template",
                ofType: "stencil"
            )
        )

        try generator.run(
            input: .dictionaryInput(using: Self.input),
            templateFile: template,
            output: "output.md",
            override: true)

        let expectedOutput = """
        Name: Pablo
        City: Barcelona
        Name: Gaby
        City: Barcelona
        Name: Dani
        City: Buenos Aires

        """

        XCTAssertEqual(mockContentWritter.saved.count, 1)
        XCTAssertEqual(mockContentWritter.saved.first!.path, "output.md")
        XCTAssertEqual(mockContentWritter.saved.first!.content, expectedOutput)
    }

    func testGenerateWithFileAnnotation() throws {
        let mockContentWritter = MockContentWritter()

        let generator = Generator(
            templatesPath: [""],
            contentWritter: mockContentWritter)

        let template = try XCTUnwrap(
            Bundle.module.path(
                forResource: "annotated-template",
                ofType: "stencil"
            )
        )

        try generator.run(
            input: .dictionaryInput(using: Self.input),
            templateFile: template,
            output: "Output",
            override: true)

        let expectedPaths = [
            "Output/Example/Generated/Pablo.md",
            "Output/Example/Generated/Gaby.md",
            "Output/Example/Generated/Dani.md",
        ]

        let expectedOutputs = [
            """
            Name: Pablo
            City: Barcelona
            """,
            """
            Name: Gaby
            City: Barcelona
            """,
            """
            Name: Dani
            City: Buenos Aires
            """
        ]

        XCTAssertEqual(mockContentWritter.saved.count, 3)

        for (index, saved) in mockContentWritter.saved.enumerated() {
            XCTAssertEqual(saved.path, expectedPaths[index])
            XCTAssertEqual(saved.content, expectedOutputs[index])
        }
    }

}
