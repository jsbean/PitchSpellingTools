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
        guard let (head, tail) = value.destructured else { fatalError() }
        guard let letterName = LetterName(string: head) else { fatalError() }
        self = PitchSpelling(letterName)
    }
    
    private static func letterName(withString string: String) -> LetterName? {
        return LetterName(string: string)
    }
}