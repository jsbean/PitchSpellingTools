//
//  PitchSpeller.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import Pitch

/**
 - warning: Not yet implemented!
 */
public protocol PitchSpeller {
    
}

extension PitchSpeller {
    
    /**
     - warning: Not yet implemented!
     
     - returns: `PitchSpelling` for given `IntervalClass`. 
        `nil` if `intervalClass` is not divisable by `0.25`.
     */
    public static func spellings(forIntervalClass intervalClass: IntervalClass)
        -> [PitchSpelling]
    {
        return []
    }
}