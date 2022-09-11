//
//  AnnotationsFinder.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 09/09/2022.
//

import Foundation
import PathKit

public struct FileAnnotationsFinder {
    public typealias Result = (path: String, content: String)

    public static let mainTag = "codegen"
    public static let fileTag = "file"
    public static let beginTag = "begin"
    public static let endTag = "end"

    public static func files(from string: String) throws -> [Result]? {
        let beginMatches = try string.matches(
            pattern: "^\\s*//\\s*\(Self.mainTag):\(Self.fileTag):\(Self.beginTag):(.+)\\s*$"
        )

        let endMatches = try string.matches(
            pattern: "^\\s*//\\s*\(Self.mainTag):\(Self.fileTag):\(Self.endTag)\\s*$"
        )

        let matches = zip(beginMatches, endMatches)

        var result: [Result] = []

        for (beginMatch, endMatch) in matches {
            guard beginMatch.numberOfRanges == 2, endMatch.numberOfRanges == 1 else {
                continue
            }

            let beginRange = beginMatch.range(at: 0)
            let endRange = endMatch.range(at: 0)

            let content = String(
                string.substring(
                    in: .init(
                        location: beginRange.location + beginRange.length,
                        length: endRange.location - (beginRange.location + beginRange.length)
                    )
                )
                .trimmingCharacters(in: .newlines)
            )

            let pathRange = beginMatch.range(at: 1)
            let path = String(string.substring(in: pathRange))

            result.append((path, content))
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
