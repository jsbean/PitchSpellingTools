//
//  SpelledPitch.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/1/16.
//
//

import Pitch

/**
 Structure that extends a `Pitch` with a `PitchSpelling`.
 */
public struct SpelledPitch {
    
    public let pitch: Pitch
    
    public let spelling: PitchSpelling
    
    /**
     Create a `SpelledPitch` with a given `pitch` and `spelling`.
     
     - TODO: ensure `PitchSpelling` is valid for given `pitch`.
     */
    public init(pitch: Pitch, spelling: PitchSpelling) {
        self.pitch = pitch
        self.spelling = spelling
//        super.init(pitch: pitch)
    }
    
    public var description: String {
        return "\(pitch): \(spelling)"
    }
}

extension SpelledPitch: Hashable {
    
    public var hashValue: Int { return "\(pitch)\(spelling)".hashValue }
}

public func == (lhs: SpelledPitch, rhs: SpelledPitch) -> Bool {
    return lhs.pitch == rhs.pitch && lhs.spelling == rhs.spelling
}
