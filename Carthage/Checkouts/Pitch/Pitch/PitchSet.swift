//
//  PitchSet.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

/**
 Unordered set of unique `Pitch` values.
 */
public struct PitchSet: PitchConvertibleSetType {
    
    // MARK: - Associated Types
    
    /// `PitchConvertible` type contained herein.
    public typealias Element = Pitch
    
    // MARK: - Instance Properties
    
    /// `Set` holding `Pitch` values.
    public let set: Set<Element>
    
    /**
     All unique dyads that comprise a `PitchSet`.
     
     In the case that there are less than two `Pitch` objects in a `PitchSet`,
     the `dyads` property is an empty array.
     
     **Example:**
     
     ```
     let triad: PitchSet = [
         Pitch(noteNumber: 60),
         Pitch(noteNumber: 61),
         Pitch(noteNumber: 62)
     ]
     
     triad.dyads == [
         Dyad(Pitch(noteNumber: 60), Pitch(noteNumber: 61)),
         Dyad(Pitch(noteNumber: 60), Pitch(noteNumber: 62)),
         Dyad(Pitch(noteNumber: 61), Pitch(noteNumber: 62))
     ]
     ```
     */
    public var dyads: [Dyad] {
        
        var pitchesArray = Array(set)
        
        guard pitchesArray.count >= 2 else { return [] }
        
        var result: [Dyad] = []
        for a in 0 ..< pitchesArray.count - 1 {
            for b in a + 1 ..< pitchesArray.count {
                result.append(Dyad(pitchesArray[a], pitchesArray[b]))
            }
        }
        return result
    }
    
    /**
     Set of `PitchClass` representations of `PitchSet`.
     
     **Example:**
     
     ```
     let pitchSet: PitchSet = [Pitch(noteNumber: 63.5), Pitch(noteNumber: 69.25)]
     pitchSet.pitchClassSet // => [3.5, 9.25]
     ```
     */
    public var pitchClassSet: PitchClassSet { return PitchClassSet(map { $0.pitchClass }) }
}

extension PitchSet: AnySequenceType {
    
    // MARK: - AnySequenceType
    
    /**
     Create a `PitchSet` with a sequence of `Pitch` values.
     */
    public init<S: SequenceType where S.Generator.Element == Element>(_ sequence: S) {
        self.set = Set(sequence)
    }
}

extension PitchSet: ArrayLiteralConvertible {
    
    // MARK: - ArrayLiteralConvertible
    
    /**
     Create a `PitchClassSequence` with an array literal.
     */
    public init(arrayLiteral elements: Element...) {
        self.set = Set(elements)
    }
}
