//
//  PitchConvertibleContainingSequence.swift
//  Pitch
//
//  Created by James Bean on 6/6/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

/**
 Sequence containing `PitchConvertibleContaining`-conforming types.
 */
public struct PitchConvertibleContainingSequence<T: PitchConvertibleContaining> {
    
    /// `Array` holding `PitchConvertibleContaining` type contained herein.
    public let array: Array<T>
}

extension PitchConvertibleContainingSequence: AnySequenceType {
    
    // MARK: - PitchSequenceType
    
    // MARK: - Associated Types
    
    /// `PitchConvertible` values contained herein.
    public typealias Element = T
    
    /// Iterable sequence of `PitchConvertibleContaining` values held by the conforming object.
    public var sequence: AnySequence<T> { return AnySequence(array) }
    
    /**
     Create a `` with `SequenceType` containing `Pitch` values.
     */
    public init<S: SequenceType where S.Generator.Element == Element>(_ sequence: S) {
        self.array = Array(sequence)
    }
}

extension PitchConvertibleContainingSequence: ArrayLiteralConvertible {
    
    // MARK: - ArrayLiteralConvertible
    
    /**
     Create a `PitchSequence` with an array literal.
     */
    public init(arrayLiteral elements: Element...) {
        self.array = elements
    }
}
