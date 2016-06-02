//
//  Level.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Pitch

/**
 Collection of `PitchSpelling` objects for a single `Pitch` in a `PitchSet`.
 */
internal final class Level {
    
    /// `Pitch` to which `nodes` belong.
    internal let pitch: Pitch
    
    /// `Node` objects contained herein, each holding a `PitchSpelling`
    internal let nodes: [Node]
    
    internal var highestRanked: Node? { return nodes.sort { $0.rank > $1.rank }.first }
    
    /**
     Create a `Level` with an array of `Node` objects, each holding a `PitchSpelling`.
     */
    internal init(pitch: Pitch, nodes: [Node]) {
        self.pitch = pitch
        self.nodes = nodes
    }
}

extension Level: CustomStringConvertible {
    
    internal var description: String {
        return "\(pitch): \(nodes)"
    }
}
