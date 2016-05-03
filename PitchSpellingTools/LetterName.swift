//
//  LetterName.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Foundation

/**
 Letter name component of a `PitchSpelling`
 */
public enum LetterName: String {
    
    /// A, la.
    case a
    
    /// B, si.
    case b
    
    /// C, do.
    case c
    
    /// D, re.
    case d
    
    /// E, mi.
    case e
    
    /// F, fa.
    case f
    
    /// G, sol.
    case g
    
    public var steps: Int {
        switch self {
        case .c: return 0
        case .d: return 1
        case .e: return 2
        case .f: return 3
        case .g: return 4
        case .a: return 5
        case .b: return 6
        }
    }
}
