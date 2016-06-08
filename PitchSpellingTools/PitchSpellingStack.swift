//
//  PitchSpellingStack.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Pitch

/**
 Collection of `PitchSpelling` objects for a single `Pitch` in a `PitchSet`.
 */
public final class PitchSpellingStack {
    
    /// `Pitch` to which `nodes` belong.
    internal let pitch: Pitch
    
    /// `PitchSpellingNode` objects contained herein, each holding a `PitchSpelling`
    internal let nodes: [PitchSpellingNode]
    
    // MARK: - Instance Properties
    
    /// The currently highest ranked `PitchSpellingNode` contained herein.
    public var highestRanked: PitchSpellingNode? {
        return nodes.sort { $0.rank > $1.rank }.first
    }
    
    // MARK: - Initializers
    
    /**
     Create a `PitchSpellingStack` with an array of `PitchSpellingNode` objects, each holding a `PitchSpelling`.
     */
    public init(pitch: Pitch, nodes: [PitchSpellingNode]) {
        self.pitch = pitch
        self.nodes = nodes
    }
    
    // TODO: init with pitch and nodeResource
}

extension PitchSpellingStack: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String { return "\(pitch): \(nodes)" }
}
