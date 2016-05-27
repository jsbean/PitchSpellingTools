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
    
    /// All possible `Path` objects. That is, every possible way of spelling a `PitchSet`.
    internal lazy var allPaths: PathCollection = {
        return self.paths(allowingUnconventionalEnharmonics: true)
    }()

    private let pitchSet: PitchSet
    
    /**
     Create a `Graph` with a `pitchSet` in order to apply to it `PitchSpelling` values.
     */
    internal init(pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
    
    /**
     - parameter coarseDirectionPreference:       Direction of CoarseAdjustrment required
     - parameter fineDirectionPreference:         Direction of FineAdjustment required
     - parameter allowsUnconventionalEnharmonics: 
         Whether to include double flats, double sharps, c flat, f flat, b sharp, or e sharp
     
     - returns: All possible paths with desired settings.
     */
    internal mutating func paths(
        compatibleWithCoarseDirection coarseDirectionPreference:
            PitchSpelling.CoarseAdjustment.Direction = .none,
        compatibleWithFineDirection fineDirectionPreference:
            PitchSpelling.FineAdjustment = .none,
        allowingUnconventionalEnharmonics allowsUnconventionalEnharmonics: Bool = false
    ) -> PathCollection
    {
        
        // bail if the pitchSet is empty
        guard let firstLevel = self.levels.first else { return PathCollection(paths: []) }
        
        let filter = NodeFilter(
            coarseDirectionPreference: coarseDirectionPreference,
            fineDirectionPreference: fineDirectionPreference,
            allowsUnconventionalEnharmonics: allowsUnconventionalEnharmonics
        )
        
        filterLevels(with: filter)

        
        // wrap up
        var collection = PathCollection(nodes: firstLevel.nodes)

        // go up until the penultimate level (as we are connecting to the next one)
        for a in 0 ..< self.levels.count - 1 {
            let levelA = self.levels[a]
            let levelB = self.levels[a + 1]

            collection.addPaths(to: levelB, branchingFrom: levelA)
        }
        return collection
    }
    
    private mutating func filterLevels(with filter: NodeFilter) {
        levels.forEach { $0.filter(with: filter) }
    }
}
