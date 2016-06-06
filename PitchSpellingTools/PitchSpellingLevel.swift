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
public final class Level {
    
    /// `Pitch` to which `nodes` belong.
    internal let pitch: Pitch
    
    /// `PitchSpellingNode` objects contained herein, each holding a `PitchSpelling`
    internal let nodes: [PitchSpellingNode]
    
    public var highestRanked: PitchSpellingNode? { return nodes.sort { $0.rank > $1.rank }.first }
    
    /**
     Create a `Level` with an array of `PitchSpellingNode` objects, each holding a `PitchSpelling`.
     */
    public init(pitch: Pitch, nodes: [PitchSpellingNode]) {
        self.pitch = pitch
        self.nodes = nodes
    }
}

extension Level: CustomStringConvertible {
    
    public var description: String {
        return "\(pitch): \(nodes)"
    }
}
