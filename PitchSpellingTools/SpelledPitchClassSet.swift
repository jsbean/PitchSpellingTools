//
//  SpelledPitchClassSet.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/25/16.
//
//

import Pitch

public struct SpelledPitchClassSet {
    
    private let pitches: Set<SpelledPitchClass>
    
    public init<S: SequenceType where S.Generator.Element == SpelledPitchClass>(_ pitches: S) {
        self.pitches = Set(pitches)
    }
}

extension SpelledPitchClassSet: ArrayLiteralConvertible {
    
    public typealias Element = SpelledPitchClass
    
    public init(arrayLiteral elements: Element...) {
        self.pitches = Set(elements)
    }
}

extension SpelledPitchClassSet: SequenceType {
    
    public func generate() -> AnyGenerator<SpelledPitchClass> {
        var generator = pitches.generate()
        return AnyGenerator { return generator.next() }
    }
}

extension SpelledPitchClassSet: Equatable { }

public func == (lhs: SpelledPitchClassSet, rhs: SpelledPitchClassSet) -> Bool {
    return lhs.pitches == rhs.pitches
}
