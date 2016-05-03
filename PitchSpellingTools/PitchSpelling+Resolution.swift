//
//  PitchSpelling+Resolution.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Foundation

extension PitchSpelling {
    
    public enum Resolution: Float {
        
        // chromatic
        case halfStep = 0
        
        // quartertone
        case quarterStep = 0.5
        
        // eighth-tone
        case eighthStep = 0.25
    }
}