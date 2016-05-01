//
//  Class.swift
//  Pitch
//
//  Created by James Bean on 3/13/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/// Modulo 12 representation of `NoteNumber` representation of `Pitch`.
public typealias PitchClass = Float

extension PitchClass {
    
    /**
     Create a `PitchClass` with a `Pitch`.
     */
    public init(_ pitch: Pitch) {
        self = pitch.noteNumber % 12.0
    }
}