//
//  PitchSpellingDyad+CustomStringConvertible.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Foundation

extension PitchSpellingDyad: CustomStringConvertible {
    
    public var description: String {
        return "\(lower) | \(higher)"
    }
}