//
//  PitchSetSequence.swift
//  Pitch
//
//  Created by James Bean on 6/9/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

/**
 Ordered collection of non-unique `PitchSet` values.
 */
public struct PitchSetSequence {
    
    public typealias Element = PitchSet
    
    /// `Array` holding `PitchSet` values.
    public let array: Array<PitchSet>
    
    public init<S: SequenceType where S.Generator.Element == PitchSet>(_ sequence: S) {
        self.array = Array(sequence)
    }
}

extension PitchSetSequence: CollectionType {
    
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return array.count }
    
    public subscript(index: Int) -> Element { return array[index] }
}

extension PitchSetSequence: SequenceType {
   
    public func generate() -> AnyGenerator<PitchSet> {
        var generator = array.generate()
        return AnyGenerator { return generator.next() }
    }
}

extension PitchSetSequence: ArrayLiteralConvertible {
    
    // MARK: ArrayLiteralConvertible
    
    /**
     Create a `PitchSetSequence` with an array literal.
     */
    public init(arrayLiteral elements: Element...) {
        self.array = elements
    }
}

public func == (lhs: PitchSetSequence, rhs: PitchSetSequence) -> Bool {
    return lhs.array == rhs.array
}