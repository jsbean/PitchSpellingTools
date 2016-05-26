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
            PitchSpelling.CoarseAdjustment.Direction = .none,
        compatibleWithFineDirection fineDirectionPreference:
            PitchSpelling.FineAdjustment = .none,
        allowingUnconventionalEnharmonics allowsUnconventionalEnharmonics: Bool = false
    ) -> PathCollection
    {
        
        // bail if the pitchSet is empty
        guard let firstLevel = self.levels.first else { return PathCollection(paths: []) }
        
        let nodes = filterNodes(firstLevel.nodes,
            forCoarseDirectionPreference: coarseDirectionPreference,
            forFineDirectionPreference: fineDirectionPreference,
            forAllowingUnconventionalEnharmonics: allowsUnconventionalEnharmonics
        )
        
        var collection = PathCollection(nodes: nodes)
        
        // TODO: do another level of filtering here for coarse / fine direction

        // go up until the penultimate level (as we are connecting to the next one)
        for a in 0 ..< self.levels.count - 1 {
            let levelA = self.levels[a]
            let levelB = self.levels[a + 1]
            collection.addPaths(to: levelB, branchingFrom: levelA)
        }
        return collection
    }
    
    private func filterNodes(nodes: [Node],
        forCoarseDirectionPreference coarseDirectionPreference:
            PitchSpelling.CoarseAdjustment.Direction,
        forFineDirectionPreference fineDirectionPreference: PitchSpelling.FineAdjustment,
        forAllowingUnconventionalEnharmonics allowsUnconventionalEnharmonics: Bool
    ) -> [Node]
    {
        var nodes = nodes
        nodes = filterNodes(nodes, forFineDirectionPreference: fineDirectionPreference)
        nodes = filterNodes(nodes, forCoarseDirectionPreference: coarseDirectionPreference)
        nodes = filterNodes(nodes,
            forAllowingUnconventionalEnharmonics: allowsUnconventionalEnharmonics
        )
        return nodes
    }
    
    private func filterNodes(nodes: [Node],
        forCoarseDirectionPreference coarseDirectionPreference:
            PitchSpelling.CoarseAdjustment.Direction
    ) -> [Node]
    {
        switch coarseDirectionPreference {
        case .none: return nodes
        case .up: return nodes.filter { $0.spelling.coarse.direction.rawValue >= 0 }
        case .down: return nodes.filter { $0.spelling.coarse.direction.rawValue <= 0 }
        }
    }
    
    private func filterNodes(nodes: [Node],
        forFineDirectionPreference fineDirectionPreference: PitchSpelling.FineAdjustment
    ) -> [Node]
    {
        switch fineDirectionPreference {
        case .none: return nodes
        case .up: return nodes.filter { $0.spelling.fine.rawValue >= 0 }
        case .down: return nodes.filter { $0.spelling.fine.rawValue <= 0 }
        }
    }
    
    // filters out double sharps, double flats, e sharp, b sharp, f flat, c flat
    private func filterNodes(nodes: [Node],
        forAllowingUnconventionalEnharmonics allowsUnconventionalEnharmonics: Bool
    ) -> [Node]
    {
        guard !allowsUnconventionalEnharmonics else { return nodes }

        var nodes = nodes
        
        // c flat
        nodes = nodes.filter {
            !($0.spelling.letterName == .c && $0.spelling.coarse == .flat)
        }
            
        // f flat
        nodes = nodes.filter {
            !($0.spelling.letterName == .f && $0.spelling.coarse == .flat)
        }
            
        // e sharp
        nodes = nodes.filter {
            !($0.spelling.letterName == .e && $0.spelling.coarse == .sharp)
        }
            
        // b sharp
        nodes = nodes.filter {
            !($0.spelling.letterName == .b && $0.spelling.coarse == .sharp)
        }
        
        nodes = nodes.filter {
            !($0.spelling.coarse == .doubleSharp || $0.spelling.coarse == .doubleFlat)
        }
        
        return nodes
    }
}
