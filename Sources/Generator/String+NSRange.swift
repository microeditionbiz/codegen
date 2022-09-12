//
//  String+NSRange.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 11/09/2022.
//

import Foundation

extension String {

    func substring(in range: NSRange) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.location)
        let endIndex = self.index(self.startIndex, offsetBy: range.location + range.length)

        let r = startIndex..<endIndex
        return self[r]
    }

}
