//
//  PitchSpelling+CustomStringConvertible.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Foundation

extension PitchSpelling: CustomStringConvertible {
    
    public var description: String {
        var result = "\(letterName)"
        if coarse != .natural { result += " \(coarse)" }
        if fine != .none { result += " \(fine)" }
        return result
    }
}
