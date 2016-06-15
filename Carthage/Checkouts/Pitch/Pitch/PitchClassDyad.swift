//
//  PitchClassDyad.swift
//  Pitch
//
//  Created by James Bean on 6/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

// this should be temporary
public struct PitchClassDyad {
    
    let lower: PitchClass
    let higher: PitchClass
    var interval: Interval { return Interval(higher.value - lower.value) }
    
    public init(_ lower: PitchClass, _ higher: PitchClass) {
        self.lower = lower
        self.higher = higher
    }
}