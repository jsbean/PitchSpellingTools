//
//  PitchSpellingNode.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Pitch

/**
 PitchSpellingNode in a `Graph`, holding a `PitchSpelling` object for a `Pitch` within a `PitchSet`.
 
 - note: Consider factoring this out, unless it has a bigger payload than just a `PitchSpelling`
 */
internal final class PitchSpellingNode {
    
    internal var rank: Float? // start `nil`
    
    // add pitch
    internal let pitch: Pitch
    
    /// The `PitchSpelling` held by this `PitchSpellingNode`.
    internal let spelling: PitchSpelling
    
    /**
     Create a `PitchSpellingNode` with the given `spelling`.
     */
    internal init(pitch: Pitch, spelling: PitchSpelling) {
        self.pitch = pitch
        self.spelling = spelling
    }
    
    /**
     Create a `PitchSpellingNode` with a `Pitch` that can be spelled objectively.
     
     - returns: `nil` if the given `pitch` is not spellable objectively.
     */
    internal init!(objectivelySpellablePitch pitch: Pitch) {
        guard pitch.canBeSpelledObjectively else { return nil }
        self.pitch = pitch
        self.spelling = pitch.defaultSpelling!
    }
}

extension PitchSpellingNode: Comparable { }

internal func == (lhs: PitchSpellingNode, rhs: PitchSpellingNode) -> Bool {
    return lhs.spelling == rhs.spelling
}

internal func < (lhs: PitchSpellingNode, rhs: PitchSpellingNode) -> Bool {
    return lhs.rank < rhs.rank
}

extension PitchSpellingNode: CustomStringConvertible {
    
    internal var description: String {
        return "\(spelling); rank: \(rank)"
    }
}