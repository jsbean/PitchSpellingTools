//
//  PitchSet+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import Pitch

extension PitchSet {
//
//    public var spellability: Spellability {
//        if allMatch({ $0.spellability == .objective }) {
//            
//        }
//    }
//    
    public var canBeSpelledObjectively: Bool {
        return self.allSatisfy { $0.canBeSpelledObjectively }
    }
    
    public func spelledWithDefaultSpellings() throws -> SpelledPitchSet {
        return try SpelledPitchSet(self.map { try $0.spelledWithDefaultSpelling() })
    }
}
