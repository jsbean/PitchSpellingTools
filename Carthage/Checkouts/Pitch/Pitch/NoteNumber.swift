//
//  NoteNumber.swift
//  Pitch
//
//  Created by James Bean on 3/12/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/** 
 MIDI specification Note Number.
 
 >Middle-c (c4) has the `NoteNumber` `60`. The octave above (c5), has the `NoteNumber` `72`.
 
 Microtonal intervals are represented with decimal values:
 
 >The quarter-tone value above middle-c has the `NoteNumber` `60.5`
 */
public typealias NoteNumber = Float

extension NoteNumber {
    
    /**
     Create a `NoteNumber` with `Frequency` value.
    */
    public init(frequency: Frequency) {
        self = 69.0 + (12.0 * (log(frequency / 440.0)/log(2.0)))
    }
}

/**
 Quantize a given `NoteNumber` value to the desired `resolution`.
 
 - `1`: quantize to a half-tone
 - `0.5`: quantize to a quarter-tone
 - `0.25`: quantize to an eighth-tone
 
 - returns: `NoteNumber` that is quantized to the desired `resolution`.
 */
public func quantize(noteNumber noteNumber: NoteNumber, toResolution resolution: Float)
    -> NoteNumber
{
    return round(noteNumber / resolution) * resolution
}