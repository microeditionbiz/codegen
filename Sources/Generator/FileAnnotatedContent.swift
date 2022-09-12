//
//  AnnotationsFinder.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 09/09/2022.
//

import Foundation
import PathKit

public enum FileAnnotatedContentError: Error {
    case invalidFileAnnotationFormat
    case mislocatedEndAnnotation
    case amountOfBeginEndAnnotationsDontMatch
}

public struct FileAnnotatedContent {
    public typealias Result = (content: String, path: Path)

    public static let mainTag = "codegen"
    public static let fileTag = "file"
    public static let beginTag = "begin"
    public static let endTag = "end"

    public static func process(using string: String) throws -> [Result]? {
        let beginMatches = try string.matches(
            pattern: "^\\s*//\\s*\(Self.mainTag):\(Self.fileTag):\(Self.beginTag):(.+)\\s*$"
        )

        let endMatches = try string.matches(
            pattern: "^\\s*//\\s*\(Self.mainTag):\(Self.fileTag):\(Self.endTag)\\s*$"
        )

        guard beginMatches.count == endMatches.count else {
            throw FileAnnotatedContentError.amountOfBeginEndAnnotationsDontMatch
        }

        let matches = zip(beginMatches, endMatches)

        var result: [Result] = []

        for (beginMatch, endMatch) in matches {
            guard beginMatch.numberOfRanges == 2, endMatch.numberOfRanges == 1 else {
                throw FileAnnotatedContentError.invalidFileAnnotationFormat
            }

            let beginRange = beginMatch.range(at: 0)
            let beginLocation = beginRange.location + beginRange.length
            let endRange = endMatch.range(at: 0)

            guard endRange.location >= beginLocation else {
                throw FileAnnotatedContentError.mislocatedEndAnnotation
            }

            let content = String(
                string.substring(
                    in: .init(
                        location: beginLocation,
                        length: endRange.location - beginLocation
                    )
                )
                .trimmingCharacters(in: .newlines)
            )

            let pathRange = beginMatch.range(at: 1)
            let path = Path(String(string.substring(in: pathRange)))

            result.append((content, path))
        }

        return result.isEmpty ? nil : result
    }

    private static func processResult(_ result: NSTextCheckingResult, from string: String) {
        print("range", result.range)
        print("numberOfRanges", result.numberOfRanges)

        for n in 0..<result.numberOfRanges {
            let range = result.range(at: n)
            print("substringWithRange", string.substring(in: range))
        }
    }

}
