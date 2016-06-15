//
//  PitchConvertibleCollectionType.swift
//  Pitch
//
//  Created by James Bean on 6/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

/**
 Ordered collection of non-unique `PitchConvertible`-conforming values.
 */
public protocol PitchConvertibleCollectionType:
    PitchConvertibleContaining,
    CollectionType,
    Equatable
{
    
    // MARK: - Associated Types
    
    /// `PitchConvertible`-conforming type of values contained herein.
    associatedtype Element: PitchConvertible
    
    // MARK: - Instance Properties
    
    /// `Array` holding `PitchConvertible` values.
    var array: Array<Element> { get }
}

extension PitchConvertibleCollectionType {
    
    // MARK: - AnySequenceType

    /// Iterable sequence of `Pitch` values contained herein.
    public var sequence: AnySequence<Element> { return AnySequence(array) }
}

extension PitchConvertibleCollectionType {
    
    // MARK: - PitchConvertibleContaining
    
    /// - returns `true` if there are no `Pitch` values contained herein. Otherwise, `false`.
    public var isEmpty: Bool { return array.isEmpty }
    
    /// - returns `true` if there is one `Pitch` value contained herein. Otherwise `false`.
    public var isMonadic: Bool { return array.count == 1 }
}

extension PitchConvertibleCollectionType {
    
    // MARK: - CollectionType
    
    /// Start index
    public var startIndex: Int { return 0 }
    
    /// End index
    public var endIndex: Int { return array.count }
    
    /**
     - returns: `Pitch` value at the given `index`.
     */
    public subscript(index: Int) -> Element { return array[index] }
}

extension PitchConvertibleCollectionType {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description of `PitchConvertibleCollectionType`.
    public var description: String {
        return "〈\(map{ "\($0)" }.joinWithSeparator(","))〉"
    }
}

public func == <T: PitchConvertibleCollectionType> (lhs: T, rhs: T) -> Bool {
    return lhs.sequence == rhs.sequence
}
