//
//  PitchSpelling.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Spelled representation of a `Pitch`.
 */
public struct PitchSpelling {
    
    //public typealias Resolution = Float
    public typealias Sharpness = Int
    
    public enum Resolution: Float {
        
        // chromatic
        case HalfStep = 0
        
        // quartertone
        case QuarterStep = 0.5
        
        // eighth-tone
        case EighthStep = 0.25
    }
    
    /**
     Letter name component of a `PitchSpelling`
     */
    public enum LetterName: String {
        
        /// A, la.
        case A
        
        /// B, si.
        case B
        
        /// C, do.
        case C
        
        /// D, re.
        case D
        
        /// E, mi.
        case E
        
        /// F, fa.
        case F
        
        /// G, sol.
        case G
    }
    
    /**
     Fine resolution component of a `PitchSpelling`. 
        Analogous to an up or down (or lack of) arrow of an accidental.
     
     - note: In 48-EDO, represents 1/8th-tone adjustment. 
        May be useful for other cases (e.g., -14c adjustment for 5th partial, etc.).
     */
    public enum FineAdjustment: Float {
        
        /// None.
        case None = 0
        
        /// Up.
        case Up = 1
        
        /// Down.
        case Down = -1
    }
    
    /**
     Coarse resolution component of a `PitchSpelling`.
        Analogous to the body of an accidental.
     */
    public enum CoarseAdjustment: Float {
        
        public enum Direction: Float {
            case None = 0
            case Up = 1
            case Down = -1
        }
        
        public var direction: Direction {
            switch self {
            case Natural: return .None
            case Sharp, QuarterSharp: return .Up
            case Flat, QuarterFlat: return .Down
            }
        }
        
        /// Natural.
        case Natural = 0
        
        /// QuarterSharp.
        case QuarterSharp = 0.5
        
        /// Sharp.
        case Sharp = 1
        
        /// QuarterFlat.
        case QuarterFlat = -0.5
        
        /// Flat.
        case Flat = -1
    }
    
    /// LetterName of a `PitchSpelling`.
    public let letterName: LetterName
    
    /// Fine resolution of a `PitchSpelling`.
    public let fine: FineAdjustment
    
    /// Coarse resolution of a `PitchSpelling`.
    public let coarse: CoarseAdjustment
    
    /// - warning: Not yet implemented!
    public var resolution: Resolution { return .HalfStep } // compute at init
    
    /// - warning: Not yet implemented!
    public var sharpness: Sharpness { return 0 } // compute at init
    
    /**
     Create a `PitchSpelling`.
     */
    public init(
        letterName: LetterName,
        coarse: CoarseAdjustment = .Natural,
        fine: FineAdjustment = .None
    )
    {
        self.letterName = letterName
        self.coarse = coarse
        self.fine = fine
    }
}

extension PitchSpelling: Equatable { }

public func == (lhs: PitchSpelling, rhs: PitchSpelling) -> Bool {
    return lhs.letterName == rhs.letterName && lhs.coarse == rhs.coarse && lhs.fine == rhs.fine
}