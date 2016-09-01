//
//  PitchSequence.swift
//  Pitch
//
//  Created by James Bean on 6/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

/**
 Ordered collection of non-unique `Pitch` values.
 */
public struct PitchSequence: PitchConvertibleCollectionType {

    // MARK: - Instance Properties
    
    /// Array of the `Pitch` values contained herein.
    public let array: Array<Pitch>

    /// - TODO: Make IntervalSequence
    public var intervals: [Interval]? {
        return array.adjacentPairs?.lazy.map(Dyad.init).map(Interval.init)
    }
}

extension PitchSequence: AnySequenceType {
    
    // MARK: - PitchSequenceType
    
    // MARK: - Associated Types
    
    /// `PitchConvertible` values contained herein.
    public typealias Element = Pitch
    
    /**
     Create a `PitchSet` with `SequenceType` containing `Pitch` values.
     */
    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        self.array = Array(sequence)
    }
}

extension PitchSequence: ExpressibleByArrayLiteral {
    
    // MARK: - ArrayLiteralConvertible
    
    /**
     Create a `PitchSequence` with an array literal.
     */
    public init(arrayLiteral elements: Element...) {
        self.array = elements
    }
}

public func == (lhs: PitchSequence, rhs: PitchSequence) -> Bool {
    return lhs.sequence == rhs.sequence
}

extension PitchSequence: Sequence {
    
    public func makeIterator() -> AnyIterator<Pitch> {
        var iterator = array.makeIterator()
        return AnyIterator { iterator.next() }
    }
}
