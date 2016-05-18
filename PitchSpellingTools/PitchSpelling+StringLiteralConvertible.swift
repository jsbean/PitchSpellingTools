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
    
    /**
     - warning: Not yet implemented!
     */
    public init(stringLiteral value: StringLiteralType) {
        guard let (head, _) = value.destructured else { fatalError() }
        guard let letterName = LetterName(string: head) else { fatalError() }
        // get coarse adjustment
        self = PitchSpelling(letterName)
    }
}