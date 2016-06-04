//
//  Node.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Pitch

/**
 Node in a `Graph`, holding a `PitchSpelling` object for a `Pitch` within a `PitchSet`.
 
 - note: Consider factoring this out, unless it has a bigger payload than just a `PitchSpelling`
 */
internal final class Node {
    
    internal var rank: Float? // start `nil`
    
    // add pitch
    internal let pitch: Pitch
    
    /// The `PitchSpelling` held by this `Node`.
    internal let spelling: PitchSpelling
    
    /**
     Create a `Node` with the given `spelling`.
     */
    internal init(pitch: Pitch, spelling: PitchSpelling) {
        self.pitch = pitch
        self.spelling = spelling
    }
    
    /**
     Create a `Node` with a `Pitch` that can be spelled objectively.
     
     - returns: `nil` if the given `pitch` is not spellable objectively.
     */
    internal init!(objectivelySpellablePitch pitch: Pitch) {
        guard pitch.canBeSpelledObjectively else { return nil }
        self.pitch = pitch
        self.spelling = pitch.defaultSpelling!
    }
}

extension Node: Comparable { }

internal func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.spelling == rhs.spelling
}

internal func < (lhs: Node, rhs: Node) -> Bool {
    return lhs.rank < rhs.rank
}

extension Node: CustomStringConvertible {
    
    internal var description: String {
        return "\(spelling); rank: \(rank)"
    }
}