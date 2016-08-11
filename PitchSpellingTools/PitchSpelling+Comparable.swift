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
        if lhs.quarterStep.rawValue < rhs.quarterStep.rawValue { return true }
        if lhs.quarterStep.rawValue == rhs.quarterStep.rawValue {
            if lhs.eighthStep.rawValue < rhs.eighthStep.rawValue { return true }
        }
    }
    return false
}
