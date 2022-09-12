//
//  FileAnnotatedContentData.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 12/09/2022.
//

import Foundation

enum FileAnnotatedContentData {

    static let valid = """
//codegen:file:begin:Generated/Pablo.md
Name: Pablo
City: Barcelona
//   codegen:file:end
 // codegen:file:begin:Gaby.md
Name: Gaby
City: Barcelona
     // codegen:file:end
//   codegen:file:begin:Generated/Example/Dani.md
Name: Dani
City: Buenos Aires
// codegen:file:end
"""

    static let invalidFormat = """
// codegen:file:begin:
Name: Pablo
City: Barcelona
// codegen:file:begin:Generated/Gaby.md
// codegen:file:end
Name: Gaby
City: Barcelona
// codegen:file:end
// codegen:file:begin:Generated/Dani.md
Name: Dani
City: Buenos Aires
// codegen:file:end
"""

    static let missingEndAnnotation = """
// codegen:file:begin:Generated/Pablo.md
Name: Pablo
City: Barcelona
// codegen:file:begin:Generated/Gaby.md
Name: Gaby
City: Barcelona
// codegen:file:end
// codegen:file:begin:Generated/Dani.md
Name: Dani
City: Buenos Aires
// codegen:file:end
"""

    static let misplacedAnotation = """
// codegen:file:end
// codegen:file:begin:Generated/Pablo.md
Name: Pablo
City: Barcelona
// codegen:file:begin:Generated/Gaby.md
Name: Gaby
City: Barcelona
// codegen:file:end
// codegen:file:begin:Generated/Dani.md
Name: Dani
City: Buenos Aires
// codegen:file:end
"""

}
