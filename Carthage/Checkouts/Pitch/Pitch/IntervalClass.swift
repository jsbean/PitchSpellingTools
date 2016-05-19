//
//  IntervalClass.swift
//  Pitch
//
//  Created by James Bean on 3/13/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArithmeticTools

/// Modulo 12 representation of an `Interval` value.
public struct IntervalClass: FloatWrapping {
    
    public typealias Complexity = Int
    
    private static let intervalClassOrderedBySpellingComplexity: [IntervalClass] = [
        
        // perfectable intervals
        00.00, 07.00, 05.00,
        
        // perfectable intervals 1/8th tone neighborhood
        11.75, 00.25, 06.75, 07.25, 04.75, 05.25,
        
        // minor second, major seventh
        01.00, 11.00,
        
        // minor second, major seventh 1/8th tone neighborood
        00.75, 01.25, 11.25, 10.75,
        
        // second, minor seventh
        02.00, 10.00,
        
        // perfectable intervals 1/4 tone neighborhood
        00.50, 11.50, 07.50, 06.50, 05.50, 04.50,

        // major third, major sixth
        04.00, 09.00,
        
        // minor third, minor sixth
        03.00, 08.00,
        
        // major second, minor seventh 1/8th tone neighborhood
        01.75, 02.25, 09.75, 10.25,
        
        // major third, major sixth 1/8th tone neighborhood
        03.75, 04.25, 08.75, 09.25,
        
        // minor third, minor sixth 1/8th tone neighborhood
        02.75, 03.25, 07.75, 08.25,
        
        // tritone
        06.00,
        
        // tritone 1/8th tone neighborhood
        06.25, 05.75,
        
        // neutral second up / down
        01.50, 10.50,
        
        // large second up / down
        02.50, 09.50,
        
        // neutral third up / down
        03.50, 08.50,
    ]
    
    public let value: Float
    
    public var complexity: Complexity? {
        return IntervalClass.intervalClassOrderedBySpellingComplexity.indexOf(self)
    }
    
    public init(floatLiteral value: Float) {
        self.value = value
    }
    
    public init(integerLiteral value: Int) {
        self.value = Float(value)
    }
    
    /// Create an `IntervalClass` with an `Interval`.
    public init(_ interval: Interval) {
        self.value = interval.value % 12.0
    }
}
