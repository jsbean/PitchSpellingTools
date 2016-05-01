//
//  Frequency.swift
//  Pitch
//
//  Created by James Bean on 3/12/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/// Periodic vibration in Hertz.
public typealias Frequency = Float

extension Frequency {
    
    /**
     Create a `Frequency` with a `NoteNumber` value.
     */
    public init(noteNumber: NoteNumber) {
        self = 440.0 * pow(2.0, (noteNumber - 69.0) / 12.0)
    }
}