//
//  PitchSpeller.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Pitch

public protocol PitchSpeller { }

extension PitchSpeller {
    
    internal func spell(pitch: Pitch, with spelling: PitchSpelling) -> SpelledPitch? {
        return SpelledPitch(pitch: pitch, spelling: spelling)
    }
}