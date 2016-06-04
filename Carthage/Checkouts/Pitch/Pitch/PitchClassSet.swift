//
//  PitchClassSet.swift
//  Pitch
//
//  Created by James Bean on 6/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

/**
 Unordered set of unique `PitchClass` values.
 */
public struct PitchClassSet: PitchConvertibleSetType {
    
    // MARK: - Associated Types
    
    /// `PitchConvertible` type contained herein.
    public typealias Element = PitchClass
    
    // MARK: - Instance Properties
    
    /// `Set` holding `PitchClass` values.
    public let set: Set<Element>
    
    public var dyads: [PitchClassDyad] {
        var pitchesArray = Array(set)
        
        guard pitchesArray.count >= 2 else { return [] }
        
        var result: [PitchClassDyad] = []
        for a in 0 ..< pitchesArray.count - 1 {
            for b in a + 1 ..< pitchesArray.count {
                result.append(PitchClassDyad(pitchesArray[a], pitchesArray[b]))
            }
        }
        return result
    }
    
    // TODO: normal form
    // TODO: prime form
}

extension PitchClassSet: AnySequenceType {
    
    // MARK: - AnySequenceType
    
    /**
     Create an `AnySequenceType` with a `Sequence` of any type.
     
     In the `init` method of the conforming `struct`, set the value of this private `var` with
     the given `sequence.
     */
    public init<S: SequenceType where S.Generator.Element == Element>(_ sequence: S) {
        self.set = Set(sequence)
    }
}

extension PitchClassSet: ArrayLiteralConvertible {
    
    // MARK: - ArrayLiteralConvertible
    
    /**
     Create a `PitchClassSequence` with an array literal.
     */
    public init(arrayLiteral elements: Element...) {
        self.set = Set(elements)
    }
}
