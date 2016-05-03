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