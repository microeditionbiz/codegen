//
//  AnnotationsFinder.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 09/09/2022.
//

import Foundation

public enum FileAnnotatedContentError: Error {
    case invalidFormat
    case mislocatedEndAnnotation
}

public struct FileAnnotatedContent {
    public typealias Result = (content: String, path: String)

    public static let mainTag = "codegen"
    public static let fileTag = "file"
    public static let beginTag = "begin"
    public static let endTag = "end"

    public static func process(content string: String) throws -> [Result] {
        let beginMatches = try string.matches(
            pattern: "^\\s*//\\s*\(Self.mainTag):\(Self.fileTag):\(Self.beginTag):(.+)\\s*$"
        )

        let endMatches = try string.matches(
            pattern: "^\\s*//\\s*\(Self.mainTag):\(Self.fileTag):\(Self.endTag)\\s*$"
        )

        guard beginMatches.count == endMatches.count else {
            throw FileAnnotatedContentError.invalidFormat
        }

        return try zip(beginMatches, endMatches).map { (beginMatch, endMatch) in
            guard beginMatch.numberOfRanges == 2, endMatch.numberOfRanges == 1 else {
                throw FileAnnotatedContentError.invalidFormat
            }

            let beginRange = beginMatch.range(at: 0)
            let beginLocation = beginRange.location + beginRange.length + 1
            let endRange = endMatch.range(at: 0)

            guard endRange.location > beginLocation else {
                throw FileAnnotatedContentError.mislocatedEndAnnotation
            }

            let content = String(
                string.substring(
                    in: .init(
                        location: beginLocation,
                        length: endRange.location - 1 - beginLocation
                    )
                )
            )

            let pathRange = beginMatch.range(at: 1)
            let path = String(string.substring(in: pathRange))

            return (content, path)
        }
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

func appendRootDirectory(_ root: String?) -> (FileAnnotatedContent.Result) -> FileAnnotatedContent.Result {
    let root = root.map {
        $0.hasSuffix("/") ? $0 : $0 + "/"
    }

    return { result in
        if let root = root {
            return (content: result.content, path: root + result.path)
        } else {
            return result
        }
    }
}
