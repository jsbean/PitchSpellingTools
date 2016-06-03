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
public struct PitchSequence {
    
    private let pitches: Array<Pitch>
}

extension PitchSequence: ArrayLiteralConvertible {
    
    // MARK: - ArrayLiteralConvertible
    
    // MARK: - Initializers
    
    /**
     Create a `PitchSequence` with an array literal.
     */
    public init(arrayLiteral elements: Pitch...) {
        self.pitches = elements
    }
}

extension PitchSequence: PitchSequenceType {
    
    // MARK: - PitchSequenceType
    
    // MARK: - Instance Properties
    
    /// Iterable sequence of `Pitch` values contained herein.
    public var sequence: AnySequence<Pitch> { return AnySequence(pitches) }
    
    /// - returns: `true` if there is one `Pitch` object herein. Otherwsie `false`.
    public var isMonadic: Bool { return count == 1 }
    
    // MARK: - Initializers
    
    /**
     Create a `PitchSet` with `SequenceType` containing `Pitch` values.
     */
    public init<S: SequenceType where S.Generator.Element == Pitch>(sequence: S) {
        self.pitches = Array(sequence)
    }
}

extension PitchSequence: CollectionType {
    
    // MARK: CollectionType
    
    // MARK: - Associated Types
    
    /// Pitch type contained here
    public typealias Element = Pitch
    
    /// Start index
    public var startIndex: Int { return 0 }
    
    /// End index
    public var endIndex: Int { return pitches.count }
    
    /**
     - returns: `Pitch` value at the given `index`.
     */
    public subscript(index: Int) -> Element { return pitches[index] }
}