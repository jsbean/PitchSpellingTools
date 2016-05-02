//
//  PitchSpellingDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import ArithmeticTools

public struct PitchSpellingDyad {
    
    private let a: PitchSpelling
    private let b: PitchSpelling
    
    public var isCoarseMatching: Bool { return a.coarse == b.coarse }
    
    public var isCoarseDirectionMatching: Bool {
        return a.coarse.direction == b.coarse.direction
    }
    
    public var isFineMatching: Bool { return a.fine == b.fine }
    
    public var meanSharpness: Sharpness { return [a.sharpness, b.sharpness].mean! }
    
    public init(_ a: PitchSpelling, _ b: PitchSpelling) {
        self.a = a
        self.b = b
    }
}
