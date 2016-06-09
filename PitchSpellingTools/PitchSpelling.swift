//
//  PitchSpelling.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Pitch

/**
 Spelled representation of a `Pitch`.
 
 - TODO: Conform to `StringLiteralConvertible`.
 */
public struct PitchSpelling {
    
    // MARK: - Errors
    
    /**
     Errors possible when attempting to spell a `Pitch`.
     */
    public enum Error: ErrorType {
        
        /**
         If the given `PitchSpelling` is not applicable to the given `Pitch`.
         */
        case invalidSpelling(Pitch, PitchSpelling)
        
        /**
         If there is no `PitchSpelling` found for the given `Pitch`.
         */
        case noSpellingForPitch(Pitch)
    }
    
    // MARK: - Instance Properties
    
    /// LetterName of a `PitchSpelling`.
    public let letterName: LetterName
    
    /// Fine resolution of a `PitchSpelling`.
    public let fine: FineAdjustment
    
    /// Coarse resolution of a `PitchSpelling`.
    public let coarse: CoarseAdjustment
    
    // MARK: - Initializers
    
    /*:
     Create a `PitchSpelling` (with argument labels).

     **Example:**
     ```
     let cNatural = PitchSpelling(letterName: .c)
     let aFlat = PitchSpelling(letterName: .a, coarse: .flat)
     let gQuarterSharp = PitchSpelling(letterName: .g, coarse: .quarterSharp)
     let dQuarterFlatDown = PitchSpelling(letterName: .d, coarse: .quarterFlat, fine: .down)
     let bDoubleSharp = PitchSpelling(letterName: .b, coarse: .doubleSharp)
     ```
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
    
    /**
     Create a `PitchSpelling` (without argument labels).
     
     **Example:**
     
     ```
     let cNatural = PitchSpelling(.c)
     let aFlat = PitchSpelling(.a, .flat)
     let gQuarterSharp = PitchSpelling(.g, .quarterSharp)
     let dQuarterFlatDown = PitchSpelling(.d, .quarterFlat, .down)
     let bDoubleSharp = PitchSpelling(.b, .doubleSharp)
     ```
     */
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

    // MARK: - Instance Methods
    
    /**
     - returns: `true` if this `PitchSpelling` can be applied to the given `Pitch`.
     Otherwise, `false`.
     */
    public func isValid(forPitch pitch: Pitch) -> Bool {
        return pitch.spellings.contains(self)
    }
}

extension PitchSpelling: Hashable {
    
    public var hashValue: Int { return "\(letterName),\(coarse),\(fine)".hashValue }
}

public func == (lhs: PitchSpelling, rhs: PitchSpelling) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
