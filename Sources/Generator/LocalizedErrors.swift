//
//  File.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 19/09/2022.
//

import Foundation

extension ContentWritterError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .pathExist(path):
            return "File at location \(path) already exist. Use --override param in case that you want to override autogenerated files."
        }
    }
}
