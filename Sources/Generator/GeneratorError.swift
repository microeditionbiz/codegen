//
//  GeneratorError.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 08/09/2022.
//

import Foundation

public enum GeneratorError: Error {
    case missingExtension(URL)
    case unsupportedExtension(String)
    case invalidInputPath(String)
    case invalidInputFileContent
}
