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
        case halfStep = 0
        
        // quartertone
        case quarterStep = 0.5
        
        // eighth-tone
        case eighthStep = 0.25
    }
    
    /**
     Letter name component of a `PitchSpelling`
     */
    public enum LetterName: String {
        
        /// A, la.
        case a
        
        /// B, si.
        case b
        
        /// C, do.
        case c
        
        /// D, re.
        case d
        
        /// E, mi.
        case e
        
        /// F, fa.
        case f
        
        /// G, sol.
        case g
        
        public var steps: Int {
            switch self {
            case .c: return 0
            case .d: return 1
            case .e: return 2
            case .f: return 3
            case .g: return 4
            case .a: return 5
            case .b: return 6
            }
        }
    }
    
    /**
     Fine resolution component of a `PitchSpelling`. 
        Analogous to an up or down (or lack of) arrow of an accidental.
     
     - note: In 48-EDO, represents 1/8th-tone adjustment. 
        May be useful for other cases (e.g., -14c adjustment for 5th partial, etc.).
     */
    public enum FineAdjustment: Float {
        
        /// None.
        case none = 0
        
        /// Up.
        case up = 1
        
        /// Down.
        case down = -1
    }
    
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
        
        private enum Resolution: Float {
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
        
        private var resolution: Resolution {
            switch self {
            case .quarterSharp, .quarterFlat: return .quarterStep
            default: return .halfStep
            }
        }
        
        private var quantizedToHalfStep: CoarseAdjustment {
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
    
    private static let sharpnessByPitchSpelling: [PitchSpelling: Sharpness] = [
        PitchSpelling(.f, .flat): -7,
        PitchSpelling(.c, .flat): -6,
        PitchSpelling(.g, .flat): -5,
        PitchSpelling(.d, .flat): -4,
        PitchSpelling(.a, .flat): -3,
        PitchSpelling(.e, .flat): -2,
        PitchSpelling(.b, .flat): -1,
        PitchSpelling(.f, .sharp): 1,
        PitchSpelling(.c, .sharp): 2,
        PitchSpelling(.g, .sharp): 3,
        PitchSpelling(.d, .sharp): 4,
        PitchSpelling(.a, .sharp): 5,
        PitchSpelling(.e, .sharp): 6,
        PitchSpelling(.b, .sharp): 7
    ]
    
    /// LetterName of a `PitchSpelling`.
    public let letterName: LetterName
    
    /// Fine resolution of a `PitchSpelling`.
    public let fine: FineAdjustment
    
    /// Coarse resolution of a `PitchSpelling`.
    public let coarse: CoarseAdjustment
    
    public var resolution: Resolution {
        return fine != .none
            ? .eighthStep
            : coarse.resolution == .quarterStep ? .quarterStep
            : .halfStep
    }
    
    public var sharpness: Sharpness {
        return PitchSpelling.sharpnessByPitchSpelling[quantized(to: .halfStep)] ?? 0
    }
    
    /**
     Create a `PitchSpelling`.
     */
    public init(
        letterName: LetterName,
        coarse: CoarseAdjustment = .natural,
        fine: FineAdjustment = .none
    )
    {
        self.letterName = letterName
        self.coarse = coarse
        self.fine = fine
    }
    
    public init(
        _ letterName: LetterName,
        _ coarse: CoarseAdjustment = .natural,
        _ fine: FineAdjustment = .none
    )
    {
        self.letterName = letterName
        self.coarse = coarse
        self.fine = fine
    }
    
    public func quantized(to resolution: Resolution) -> PitchSpelling {
        switch resolution {
        case .eighthStep:
            return self
        case .quarterStep:
            return PitchSpelling(letterName: letterName, coarse: coarse, fine: .none)
        case .halfStep:
            return PitchSpelling(
                letterName: letterName,
                coarse: coarse.quantizedToHalfStep,
                fine: .none
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