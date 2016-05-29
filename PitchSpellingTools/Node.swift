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
}

extension Node: Equatable { }

internal func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.spelling == rhs.spelling
}

extension Node: CustomStringConvertible {
    
    internal var description: String {
        return "\(spelling); rank: \(rank)"
    }
}