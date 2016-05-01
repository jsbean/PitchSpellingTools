//
//  Dyad.swift
//  Pitch
//
//  Created by James Bean on 3/13/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import ArithmeticTools

/**
 Collection of two pitches.
 */
public struct Dyad {
    
    /// Lower of two `Pitch` values.
    public let lower: Pitch
    
    /// Higher of two `Pitch` values.
    public let higher: Pitch
    
    /// `Interval` between two `Pitch` values.
    public var interval: Interval { return Interval(self) }
    
    /**
     Create a `Dyad` with two `Pitch` values.
     */
    public init(_ a: Pitch, _ b: Pitch) {
        let (lower, higher) = ordered(a,b)
        self.lower = lower
        self.higher = higher
    }
}