//
//  AnySequenceType.swift
//  ArrayTools
//
//  Created by James Bean on 6/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

/**
 Type erasing protocol that allows the `SequenceType` implementation to be left to the 
 individual `struct`.
 
 For example, `PitchSet` and `PitchSequence` are both containers for `Pitch` values, and should
 both be able to be used as `SequenceType` conforming structures. By conforming to this
 protocol, the `PitchSet` can use a `Set<Pitch>` as its underlying model, while `PitchSequence`
 can use an `Array<Pitch>` as its underlying model.
 
 In the conforming `struct`, it is necessary to add a private `var` which is an implementation
 of a `SequenceType` conforming `struct`, which is then given by the `sequence` getter. 
 
 In the `init` method of the conforming `struct`, set the value of this private `var` with the
 given `sequence.
 */
public protocol AnySequenceType: Sequence, ExpressibleByArrayLiteral {
    
    // MARK: Associated Types
    
    /// The contained type
    associatedtype Element
    
    // MARK: - Instance Properties
    
    /// `AnySequence` wrapper that provides shade for the domain specific implementation.
    var sequence: AnySequence<Element> { get }
    
    // MARK: - Initializers
    
    /**
     Create an `AnySequenceType` with a `Sequence` of any type.
     
     In the `init` method of the conforming `struct`, set the value of this private variable
     with the given `sequence`.
     */
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element
}

extension AnySequenceType {

    // MARK: - SequenceType
    
    /**
     Returns a generator over the elements of this sequence.
     */
    public func makeIterator() -> AnyIterator<Element> {
        let iterator = sequence.makeIterator()
        return AnyIterator { return iterator.next() }
    }
}

/**
 - returns: `true` if all elements in both sequnces are equivalent. Otherwise, `false`.
 */
public func == <T: AnySequenceType>(lhs: T, rhs: T) -> Bool where T.Element: Equatable {
    return lhs.sequence == rhs.sequence
}
