//
//  FileAnnotatedContentTests.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 12/09/2022.
//

import XCTest
import PathKit
@testable import Generator

class FileAnnotatedContentTests: XCTestCase {

    func testValid() throws {
        let result = try FileAnnotatedContent.process(using: FileAnnotatedContentData.valid)

        guard let result = result else {
            XCTFail()
            return
        }

        XCTAssertEqual(result.count, 3)

        XCTAssertEqual(result[0].path, Path("Generated/Pablo.md"))
        XCTAssertEqual(
            result[0].content,
            """
            Name: Pablo
            City: Barcelona
            """
        )

        XCTAssertEqual(result[1].path, Path("Gaby.md"))
        XCTAssertEqual(
            result[1].content,
            """
            Name: Gaby
            City: Barcelona
            """
        )

        XCTAssertEqual(result[2].path, Path("Generated/Example/Dani.md"))
        XCTAssertEqual(
            result[2].content,
            """
            Name: Dani
            City: Buenos Aires
            """
        )

    }

    func testInvalidFormat() {
        XCTAssertThrowsError(try FileAnnotatedContent.process(using: FileAnnotatedContentData.invalidFormat)) { error in
            XCTAssertEqual(error as? FileAnnotatedContentError, FileAnnotatedContentError.invalidFormat)
        }
    }

    func testMissingEndAnnotation() {
        XCTAssertThrowsError(try FileAnnotatedContent.process(using: FileAnnotatedContentData.missingEndAnnotation)) { error in
            XCTAssertEqual(error as? FileAnnotatedContentError, FileAnnotatedContentError.invalidFormat)
        }
    }

    func testMisplacedAnotation() {
        XCTAssertThrowsError(try FileAnnotatedContent.process(using: FileAnnotatedContentData.misplacedAnotation)) { error in
            XCTAssertEqual(error as? FileAnnotatedContentError, FileAnnotatedContentError.mislocatedEndAnnotation)
        }
    }

}
