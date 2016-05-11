//
//  PitchSpelling+CoarseAdjustment.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Foundation

extension PitchSpelling {
    
    // MARK: - Coarse Adjustment
    
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
            return self == .natural ? .none : rawValue > 0 ? .up : .down
        }
        
        internal var resolution: Resolution {
            return rawValue % 1 == 0 ? .halfStep : .quarterStep
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
        
        /// ThreeQuarterSharp.
        case threeQuarterSharp = 1.5
        
        /// QuarterFlat.
        case quarterFlat = -0.5
        
        /// Flat.
        case flat = -1
        
        /// ThreeQuarterFlat.
        case threeQuarterFlat = -1.5
    }
}
