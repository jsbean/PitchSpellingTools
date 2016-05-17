//
//  PitchSpelling+StringLiteralConvertible.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/17/16.
//
//

import Foundation
import StringTools

extension PitchSpelling: StringLiteralConvertible {
    
    public typealias UnicodeScalarLiteralType = UnicodeScalar
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: String(value))
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: String(value))
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self = PitchSpelling(.c)
    }
    
    private func letterName(withString string: String) -> LetterName? {
        return LetterName(string: String(string.characters.first!))
    }
}