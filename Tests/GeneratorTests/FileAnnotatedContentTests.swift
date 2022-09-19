//
//  FileAnnotatedContentTests.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 12/09/2022.
//

import XCTest

@testable import Generator

class FileAnnotatedContentTests: XCTestCase {

    func testValid() throws {
        let valid = """
        //codegen:file:begin:Generated/Pablo.md
        Name: Pablo
        City: Barcelona
        //   codegen:file:end
         // codegen:file:begin:Gaby.md
        Name: Gaby
        City: Barcelona
             // codegen:file:end
        //   codegen:file:begin:Generated/Example/Dani.md
        Name: Dani
        City: Buenos Aires
        // codegen:file:end
        """

        let result = try FileAnnotatedContent.process(content: valid)

        XCTAssertEqual(result.count, 3)

        XCTAssertEqual(result[0].path, "Generated/Pablo.md")
        XCTAssertEqual(
            result[0].content,
            """
            Name: Pablo
            City: Barcelona
            """
        )

        XCTAssertEqual(result[1].path, "Gaby.md")
        XCTAssertEqual(
            result[1].content,
            """
            Name: Gaby
            City: Barcelona
            """
        )

        XCTAssertEqual(result[2].path, "Generated/Example/Dani.md")
        XCTAssertEqual(
            result[2].content,
            """
            Name: Dani
            City: Buenos Aires
            """
        )

    }

    func testInvalidFormat() {
        let invalidFormat = """
        // codegen:file:begin:
        Name: Pablo
        City: Barcelona
        // codegen:file:begin:Generated/Gaby.md
        // codegen:file:end
        Name: Gaby
        City: Barcelona
        // codegen:file:end
        // codegen:file:begin:Generated/Dani.md
        Name: Dani
        City: Buenos Aires
        // codegen:file:end
        """

        XCTAssertThrowsError(try FileAnnotatedContent.process(content: invalidFormat)) { error in
            XCTAssertEqual(error as? FileAnnotatedContentError, FileAnnotatedContentError.invalidFormat)
        }
    }

    func testMissingEndAnnotation() {
        let missingEndAnnotation = """
        // codegen:file:begin:Generated/Pablo.md
        Name: Pablo
        City: Barcelona
        // codegen:file:begin:Generated/Gaby.md
        Name: Gaby
        City: Barcelona
        // codegen:file:end
        // codegen:file:begin:Generated/Dani.md
        Name: Dani
        City: Buenos Aires
        // codegen:file:end
        """

        XCTAssertThrowsError(try FileAnnotatedContent.process(content: missingEndAnnotation)) { error in
            XCTAssertEqual(error as? FileAnnotatedContentError, FileAnnotatedContentError.invalidFormat)
        }
    }

    func testMisplacedAnotation() {
        let misplacedAnotation = """
        // codegen:file:end
        // codegen:file:begin:Generated/Pablo.md
        Name: Pablo
        City: Barcelona
        // codegen:file:begin:Generated/Gaby.md
        Name: Gaby
        City: Barcelona
        // codegen:file:end
        // codegen:file:begin:Generated/Dani.md
        Name: Dani
        City: Buenos Aires
        // codegen:file:end
        """

        XCTAssertThrowsError(try FileAnnotatedContent.process(content: misplacedAnotation)) { error in
            XCTAssertEqual(error as? FileAnnotatedContentError, FileAnnotatedContentError.mislocatedEndAnnotation)
        }
    }

}
