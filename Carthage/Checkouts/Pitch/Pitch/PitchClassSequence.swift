//
//  PitchClassSequence.swift
//  Pitch
//
//  Created by James Bean on 6/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools
import ArithmeticTools

/**
 Ordered collection of non-unique `PitchClass` values.
 */
public struct PitchClassSequence: PitchConvertibleCollectionType {

    // MARK: - Instance Properties
    
    /// Array of the `PitchClass` values contained herein.
    public let array: Array<PitchClass>
    
    /// `PitchClassSequence` with `PitchClass` values in reverse order.
    public var retrograde: PitchClassSequence {
        return PitchClassSequence(reversed())
    }
    
    /// `PitchClassSequence` with `PitchClass` values inverted around `0`.
    public var inversion: PitchClassSequence {
        return PitchClassSequence(map { return $0.inversion })
    }
    
    /**
     Array of `IntervalClass` values between each adjacent `PitchClass` herein.

     - TODO: Refactor up the `PitchConvertibleCollectionType` protocol hierarchy
     - TODO: Implement `IntervalClassSeqeuence`
     */
    public lazy var intervals: [IntervalClass]? = {
        return self.array.adjacentPairs?.map { IntervalClass($0.1 - $0.0) }
    }()
    
    /** 
     Array of `PitchClassDyad` values between each combination (choose 2) herein.
    
     - TODO: Refactor up the `PitchConvertibleContaining` protocol hierarchy
     - TODO: Implement generic Dyad and Interval
     */
    public lazy var dyads: [PitchClassDyad]? = {
        self.array.subsets(withCardinality: 2)?.map { PitchClassDyad($0[0], $0[1]) }
    }()
}

extension PitchClassSequence: AnySequenceType {
    
    // MARK: - AnySequenceType
    
    /// `PitchConvertible`-conforming type contained herein.
    public typealias Element = PitchClass
    
    /**
     Create a `PitchSet` with `SequenceType` containing `Pitch` values.
     */
    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        self.array = Array(sequence)
    }
}

extension PitchClassSequence: ExpressibleByArrayLiteral {
    
    // MARK: - ArrayLiteralConvertible
    
    /**
     Create a `PitchClassSequence` with an array literal.
     */
    public init(arrayLiteral elements: PitchClass...) {
        self.array = elements
    }
}

public func == (lhs: PitchClassSequence, rhs: PitchClassSequence) -> Bool {
    return lhs.sequence == rhs.sequence
}

extension PitchClassSequence: Sequence {
    
    public func makeIterator() -> AnyIterator<PitchClass> {
        var iterator = array.makeIterator()
        return AnyIterator {
            return iterator.next()
        }
    }
}

