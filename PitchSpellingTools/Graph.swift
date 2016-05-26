//
//  Graph.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Pitch

/**
 Graph of potential spelling representations of a `PitchSet`.
 */
internal struct Graph {

    private static func makeLevel(withSpellingsForPitch pitch: Pitch) -> Level {
        let nodes = pitch.spellings.map { Node(spelling: $0) }
        return Level(nodes: nodes)
    }
    
    /**
     Array of `Level` objects, created lazily. Each `Level` is a collection of `Node` objects,
     each holding a `PitchSpelling` for the same `Pitch`.
    */
    internal lazy var levels: [Level] = {
        return self.pitchSet.sortedBySpellingComplexity.lazy.map {
            Graph.makeLevel(withSpellingsForPitch: $0)
        }
    }()
    
    /// All `Node` objects in the graph.
    internal lazy var nodes: [Node] = { self.levels.flatMap { $0.nodes } }()
    
    /// All possible `Path` objects. That is, every possible way of spelling a `PitchSet`.
    internal lazy var allPaths: PathCollection = { return self.paths() }()

    private let pitchSet: PitchSet
    
    /**
     Create a `Graph` with a `pitchSet` in order to apply to it `PitchSpelling` values.
     */
    internal init(pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
    
    /**
     `Path` objects with the given preferences for compatibility with coarse and/or fine
     directions. If `nil` is given for either, no preference will be made for that aspect.
     
     - warning: Not yet fully implemented!
     */
    internal mutating func paths(
        compatibleWithCoarseDirection coarseDirectionPreference:
            PitchSpelling.CoarseAdjustment.Direction? = nil,
        compatibleWithFineDirection fineDirectionPreference:
            PitchSpelling.FineAdjustment? = nil
    ) -> PathCollection
    {
        guard let firstLevel = self.levels.first else { return PathCollection(paths: []) }
        
        // TODO: do one level of filtering here for coarse / fine direction
        
        var collection = PathCollection(level: firstLevel)
        
        // TODO: do another level of filtering here for coarse / fine direction

        // go up until the penultimate level (as we are connecting to the next one)
        for a in 0 ..< self.levels.count - 1 {
            let levelA = self.levels[a]
            let levelB = self.levels[a + 1]
            collection.addPaths(to: levelB, branchingFrom: levelA)
        }
        return collection
    }
}
