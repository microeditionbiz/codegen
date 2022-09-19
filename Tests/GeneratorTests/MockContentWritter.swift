//
//  File.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 12/09/2022.
//

import Foundation

@testable import Generator

class MockContentWritter: ContentWritter {
    var saved: [(content: String, path: String, override: Bool)] = []

    func save(content: String, at path: String, override: Bool) throws {
        saved.append((content: content, path: path, override: override))
    }
}
