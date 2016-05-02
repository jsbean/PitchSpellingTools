//
//  PitchSpelling.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

/**
 Spelled representation of a `Pitch`.
 */
public struct PitchSpelling {
    
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
        
        internal enum Direction: Float {
            case None = 0
            case Up = 1
            case Down = -1
        }
        
        private enum Resolution: Float {
            case HalfStep = 0
            case QuarterStep = 0.5
        }
        
        internal var direction: Direction {
            switch self {
            case .Natural: return .None
            case .Sharp, .QuarterSharp: return .Up
            case .Flat, .QuarterFlat: return .Down
            }
        }
        
        private var resolution: Resolution {
            switch self {
            case .QuarterSharp, .QuarterFlat: return .QuarterStep
            default: return .HalfStep
            }
        }
        
        private var quantizedToHalfStep: CoarseAdjustment {
            switch direction {
            case .None: return .Natural
            case .Up: return .Sharp
            case .Down: return .Flat
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
    
    private static let sharpnessByPitchSpelling: [PitchSpelling: Sharpness] = [
        PitchSpelling(.F, .Flat): -7,
        PitchSpelling(.C, .Flat): -6,
        PitchSpelling(.G, .Flat): -5,
        PitchSpelling(.D, .Flat): -4,
        PitchSpelling(.A, .Flat): -3,
        PitchSpelling(.E, .Flat): -2,
        PitchSpelling(.B, .Flat): -1,
        PitchSpelling(.F, .Sharp): 1,
        PitchSpelling(.C, .Sharp): 2,
        PitchSpelling(.G, .Sharp): 3,
        PitchSpelling(.D, .Sharp): 4,
        PitchSpelling(.A, .Sharp): 5,
        PitchSpelling(.E, .Sharp): 6,
        PitchSpelling(.B, .Sharp): 7
    ]
    
    /// LetterName of a `PitchSpelling`.
    public let letterName: LetterName
    
    /// Fine resolution of a `PitchSpelling`.
    public let fine: FineAdjustment
    
    /// Coarse resolution of a `PitchSpelling`.
    public let coarse: CoarseAdjustment
    
    public var resolution: Resolution {
        return fine != .None
            ? .EighthStep
            : coarse.resolution == .QuarterStep ? .QuarterStep
            : .HalfStep
    }
    
    public var sharpness: Sharpness {
        return PitchSpelling.sharpnessByPitchSpelling[quantized(to: .HalfStep)] ?? 0
    }
    
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
    
    public init(
        _ letterName: LetterName,
        _ coarse: CoarseAdjustment = .Natural,
        _ fine: FineAdjustment = .None
    )
    {
        self.letterName = letterName
        self.coarse = coarse
        self.fine = fine
    }
    
    public func quantized(to resolution: Resolution) -> PitchSpelling {
        switch resolution {
        case .EighthStep:
            return self
        case .QuarterStep:
            return PitchSpelling(letterName: letterName, coarse: coarse, fine: .None)
        case .HalfStep:
            return PitchSpelling(
                letterName: letterName,
                coarse: coarse.quantizedToHalfStep,
                fine: .None
            )
        }
    }
}

extension PitchSpelling: Hashable {
    
    public var hashValue: Int { return "\(letterName),\(coarse),\(fine)".hashValue }
}

extension PitchSpelling: Equatable { }

public func == (lhs: PitchSpelling, rhs: PitchSpelling) -> Bool {
    return lhs.hashValue == rhs.hashValue
}