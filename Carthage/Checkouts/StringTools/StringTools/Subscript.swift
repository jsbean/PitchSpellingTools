//
//  Subscript.swift
//  StringTools
//
//  Created by James Bean on 2/24/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public extension String {
    
    /// - returns: The `Character` value at the given `index`, if available. Otherwise `nil`.
    subscript (index: Int) -> Character? {
        if index >= self.characters.count { return nil }
        return self[self.startIndex.advancedBy(index)]
    }
    
    /// - returns: The `String` value at the given `index`, if available. Otherwise `nil`.
    subscript (index: Int) -> String? {
        let charOrNil: Character? = self[index]
        guard let char = charOrNil else { return nil }
        return String(char as Character)
    }
    
    /// - returns: The `String` value for the given `range`, if available. Otherwise `nil`.
    subscript (range: Range<Int>) -> String {
        return substringWithRange(
            Range(
                startIndex.advancedBy(range.startIndex)..<startIndex.advancedBy(range.endIndex)
            )
        )
    }
}