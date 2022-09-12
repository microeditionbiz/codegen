//
//  File.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 12/09/2022.
//

import Foundation
import PathKit
@testable import Generator

class MockContentWritter: ContentWritter {
    var saved: [(content: String, path: Path)] = []

    func save(content: String, at path: Path) throws {
        saved.append((content: content, path: path))
    }
}
