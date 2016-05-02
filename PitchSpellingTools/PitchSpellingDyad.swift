//
//  PitchSpellingDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import Foundation

public struct PitchSpellingDyad {
    
    private let a: PitchSpelling
    private let b: PitchSpelling
    
    public var isCoarseMatching: Bool { return a.coarse == b.coarse }
    
    
    public var isCoarseDirectionMatching: Bool {
        return a.coarse.direction == b.coarse.direction
    }
    
    public var isFineMatching: Bool { return a.fine == b.fine }
    
    public init(_ a: PitchSpelling, _ b: PitchSpelling) {
        self.a = a
        self.b = b
    }
    
    
}