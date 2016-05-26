//
//  Level.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Foundation

/**
 Level of `Graph` holding the `PitchSpelling` objects for a single `Pitch` in a `PitchSet`.
 */
internal struct Level {
    
    /// `Node` objects contained herein, each holding a `PitchSpelling`
    internal let nodes: [Node]
    
    /**
     Create a `Level` with an array of `Node` objects, each holding a `PitchSpelling`.
     */
    internal init(nodes: [Node]) {
        self.nodes = nodes
    }
}
