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
    public lazy var dyads: [Dyad]? = {
        Array(self.set).subsets(withCardinality: 2)?.map { Dyad($0[0], $0[1]) }
    }()
    
    /**
     Set of `PitchClass` representations of `PitchSet`.
     
     **Example:**
     
     ```
     let pitchSet: PitchSet = [Pitch(noteNumber: 63.5), Pitch(noteNumber: 69.25)]
     pitchSet.pitchClassSet // => [3.5, 9.25]
     ```
     */
    public var pitchClassSet: PitchClassSet { return PitchClassSet(map { $0.pitchClass }) }
    
    public init(_ pitchSets: PitchSet...) {
        self.init(pitchSets)
    }
    
    /**
     Create a `PitchSet` with a sequence of `PitchSet` values.
     */
    public init<S: Sequence>(_ pitchSets: S) where S.Iterator.Element == PitchSet {
        if let (head, tail) = Array(pitchSets).destructured {
            self.set = tail.reduce(head.set) { $0.union($1.set) }
        } else {
            self.set = []
        }
    }
    
    /**
     - TODO: Move up the `PitchConvertibleSetType` protocol hierarchy.
     
     - returns: `PitchSet` with the union of this and the given `pitchSet`.
     */
    public func formUnion(with pitchSet: PitchSet) -> PitchSet {
        return PitchSet(set.union(pitchSet))
    }
}

extension PitchSet: AnySequenceType {
    
    // MARK: - AnySequenceType
    
    /**
     Create a `PitchSet` with a sequence of `Pitch` values.
     */
    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        self.set = Set(sequence)
    }
}

extension PitchSet: ExpressibleByArrayLiteral {
    
    // MARK: - ArrayLiteralConvertible
    
    /**
     Create a `PitchClassSequence` with an array literal.
     */
    public init(arrayLiteral elements: Element...) {
        self.set = Set(elements)
    }
}

extension PitchSet: Equatable { }

public func == (lhs: PitchSet, rhs: PitchSet) -> Bool {
    return lhs.set == rhs.set
}

extension PitchSet: CustomStringConvertible {
    
    public var description: String {
        return "\(set.map { "\($0)" })"
    }
}
