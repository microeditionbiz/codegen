//
//  String+Regex.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 11/09/2022.
//

import Foundation

public extension String {

    func matches(pattern: String) throws -> [NSTextCheckingResult] {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
        return regex.matches(in: self, options: [], range: range)
    }

    func firstMatch(pattern: String) throws -> NSTextCheckingResult? {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
        return regex.firstMatch(in: self, options: [], range: range)
    }

}
