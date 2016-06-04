//
//  Dyad.swift
//  Pitch
//
//  Created by James Bean on 3/13/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import func ArithmeticTools.ordered

/**
 Collection of two pitches.
 
 - TODO: Make generic
 */
public struct Dyad {
    
    // MARK: - Instance properties
    
    /// Lower of two `Pitch` values.
    public let lower: Pitch
    
    /// Higher of two `Pitch` values.
    public let higher: Pitch
    
    /// `Interval` between two `Pitch` values.
    public var interval: Interval { return Interval(dyad: self) }
    
    // MARK: - Initializers
    
    /**
     Create a `Dyad` with two `Pitch` values. 
     These pitches need not be ordered; they are ordered upon initialization.
     */
    public init(_ a: Pitch, _ b: Pitch) {
        let (lower, higher) = ordered(a,b)
        self.lower = lower
        self.higher = higher
    }
}

extension Dyad: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description
    public var description: String { return "\(lower), \(higher)" }
}

extension Dyad: Equatable { }

public func == (lhs: Dyad, rhs: Dyad) -> Bool {
    return lhs.lower == rhs.lower && lhs.higher == rhs.higher
}