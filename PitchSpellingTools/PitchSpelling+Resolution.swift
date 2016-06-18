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
    
    /// `Resolution` (e.g., halfstep (chromatic), quarter-step, or eighth-step)
    public var resolution: Resolution {
        return fine != .none
            ? .eighthStep
            : coarse.resolution == .quarterStep ? .quarterStep
            : .halfStep
    }
    
    /**
     - returns: A `PitchSpelling` object that is quantized to the given `resolution`.
     */
    public func quantized(to resolution: Resolution) -> PitchSpelling {
        switch resolution {
        case .quarterStep:
            return PitchSpelling(letterName: letterName, coarse: coarse, fine: .none)
        case .halfStep where coarse.resolution == .quarterStep:
            return PitchSpelling(letterName, coarse.quantizedToHalfStep, .none)
        default:
            return self
        }
    }
}
