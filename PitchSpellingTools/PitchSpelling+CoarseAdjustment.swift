//
//  PitchSpelling+CoarseAdjustment.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Foundation

extension PitchSpelling {
    
    /**
     Coarse resolution component of a `PitchSpelling`.
     Analogous to the body of an accidental.
     */
    public enum CoarseAdjustment: Float {
        
        internal enum Direction: Float {
            case none = 0
            case up = 1
            case down = -1
        }
        
        internal enum Resolution: Float {
            case halfStep = 0
            case quarterStep = 0.5
        }
        
        internal var direction: Direction {
            switch self {
            case .natural: return .none
            case .sharp, .quarterSharp: return .up
            case .flat, .quarterFlat: return .down
            }
        }
        
        internal var resolution: Resolution {
            switch self {
            case .quarterSharp, .quarterFlat: return .quarterStep
            default: return .halfStep
            }
        }
        
        internal var quantizedToHalfStep: CoarseAdjustment {
            switch direction {
            case .none: return .natural
            case .up: return .sharp
            case .down: return .flat
            }
        }
        
        /// Natural.
        case natural = 0
        
        /// QuarterSharp.
        case quarterSharp = 0.5
        
        /// Sharp.
        case sharp = 1
        
        /// QuarterFlat.
        case quarterFlat = -0.5
        
        /// Flat.
        case flat = -1
    }
}