//
//  PitchSpelling+Comparable.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/11/16.
//
//

import Foundation

extension PitchSpelling: Comparable { }

public func < (lhs: PitchSpelling, rhs: PitchSpelling) -> Bool {
    if lhs.letterName.steps < rhs.letterName.steps { return true }
    if lhs.letterName.steps == rhs.letterName.steps {
        if lhs.coarse.rawValue < rhs.coarse.rawValue { return true }
        if lhs.coarse.rawValue == rhs.coarse.rawValue {
            if lhs.fine.rawValue < rhs.fine.rawValue { return true }
        }
    }
    return false
}
