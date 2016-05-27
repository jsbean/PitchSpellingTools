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
        let nodes = pitch.spellings.map { Node(pitch: pitch, spelling: $0) }
        return Level(nodes: nodes)
    }
    
    /**
     Array of `Level` objects, created lazily. Each `Level` is a collection of `Node` objects,
     each holding a `PitchSpelling` for the same `Pitch`. 
     
     `Pitch` objects are ordered by the `IntervalClass.spellingComplexity` 
     of the `IntervalClass` between them and `PitchClass` `0`.
    */
    internal var levels: [Level] = []
    
    internal lazy var paths: PathCollection = {
        self.paths()
    }()
    
    /// All possible `Path` objects. That is, every possible way of spelling a `PitchSet`.
    internal lazy var allPaths: PathCollection = {
        self.paths(allowingUnconventionalEnharmonics: true)
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
        if Array(pitchSet).isEmpty { return PathCollection(paths: []) }
    
        // regenerate all levels upon finding paths
        self.levels = makeAllLevels()
        
        // set basic preferences for spelling
        let filter = NodeFilter(
            coarseDirectionPreference: coarseDirectionPreference,
            fineDirectionPreference: fineDirectionPreference,
            allowsUnconventionalEnharmonics: allowsUnconventionalEnharmonics
        )
    
        // filter all pitches' spellings
        filterLevels(with: filter)
        
        // create the path collection, now that the settings have been implemented
        return makePathCollection()
    }
    
    private func makeAllLevels() -> [Level] {
        return pitchSet.sortedBySpellingUrgency.lazy.map {
            Graph.makeLevel(withSpellingsForPitch: $0)
        }
    }
    
    private func makePathCollection() -> PathCollection {
        guard let firstLevel = self.levels.first else { return PathCollection(paths: []) }
        
        // prepare collection with first pitch's worth of spellings
        var collection = PathCollection(nodes: firstLevel.nodes)
        
        // create all paths available within given constraints
        for a in 0 ..< self.levels.count - 1 {
            let levelA = self.levels[a]
            let levelB = self.levels[a + 1]
            collection.addPaths(to: levelB, branchingFrom: levelA)
        }
        return collection
    }
    
    private func filterLevels(with filter: NodeFilter) {
        levels.forEach { $0.filter(with: filter) }
    }
}
