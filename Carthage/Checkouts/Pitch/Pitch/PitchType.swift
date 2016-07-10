//
//  PitchType.swift
//  Pitch
//
//  Created by James Bean on 3/12/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Protocol defining types representable with `NoteNumber` and `Frequency` values.
 */
public protocol PitchType {
    
    /// `NoteNumber` representation of `PitchType`.
    var noteNumber: NoteNumber { get }
    
    /// `Frequency` representation of `PitchType`.
    var frequency: Frequency { get }
}