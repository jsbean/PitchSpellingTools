//
//  Frequency.swift
//  Pitch
//
//  Created by James Bean on 3/12/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import ArithmeticTools

/// Periodic vibration in Hertz.
public struct Frequency: FloatWrapping {
    
    public let value: Float
    
    public init(floatLiteral value: Float) {
        self.value = value
    }
    
    public init(integerLiteral value: Int) {
        self.value = Float(value)
    }
    
    /**
     Create a `Frequency` with a `NoteNumber` value.
     */
    public init(_ noteNumber: NoteNumber) {
        self.value = 440.0 * pow(2.0, (noteNumber.value - 69.0) / 12.0)
    }
}
