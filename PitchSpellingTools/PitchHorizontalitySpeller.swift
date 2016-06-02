//
//  PitchHorizontalitySpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/31/16.
//
//

import ArrayTools
import Pitch

final class PitchHorizontalitySpeller: PitchSpeller {
    
    /// Collection of references to `Node` objects for each `Pitch`.
    private lazy var nodeResource: NodeResource = { NodeResource(pitches: self.pitches) }()
    
    /// Factory that creates `ComparisonStage` objects applicable for this `PitchSet`
    private lazy var comparisonStageFactory: ComparisonStageFactory = {
        ComparisonStageFactory(nodeResource: self.nodeResource)
    }()
    
    private var comparisonStages: [ComparisonStage] = []
    
    let pitches: [Pitch]
    
    init(pitches: [Pitch]) {
        self.pitches = pitches
    }
    
    /**
     - warning: Not yet implemented
     */
    func spell() throws -> [SpelledPitch] {
        
        guard pitches.count > 0 else { return [] }
        
        guard pitches.count > 1 else {
            return try pitches.map { try $0.spelledWithDefaultSpelling() }
        }
        
        if pitches.allMatch({ $0.canBeSpelledObjectively }) {
            return try pitches.map { try $0.spelledWithDefaultSpelling() }
        }
        
        for index in 0 ..< pitches.count - 1 {
            guard let current = currentDyad(atIndex: index) else { break }
            let comparisonStage = createComparisonStage(for: current)
            
            // here, weight is heavier toward end
            let weight = (Float(index) + 1 / Float(pitches.count)) / 2
            comparisonStage.applyRankings(withWeight: weight)
        }

        // Refactor: commit pitch spellings
        if nodeResource.allNodesHaveBeenRanked {
            nodeResource.sortForRank()
            
            // apply spellings
            var sortedPitches: [SpelledPitch] = []
            for (pitch, nodes) in nodeResource {
                guard let first = nodes.first?.spelling else { continue }
                sortedPitches.append(SpelledPitch(pitch: pitch, spelling: first))
            }
            return sortedPitches
        }

        // Refactor: commit pitch spellings
        var spellingByPitch: [Pitch: Node] = [:]
        for comparisonStage in comparisonStages {
            switch comparisonStage {
            case let stage as DeterminateComparisonStage:
                spellingByPitch[stage.a.pitch] = stage.a
                spellingByPitch[stage.b.pitch] = stage.b
            case let stage as SemiAmbiguousComparisonStage:
                spellingByPitch[stage.other.pitch] = stage.other.highestRanked
                spellingByPitch[stage.determinate.pitch] = stage.determinate
            case let stage as FullyAmbiguousComparisonStage:
                guard let highestRanked = stage.highestRanked else { fatalError() }
                spellingByPitch[stage.a.pitch] = highestRanked.a
                spellingByPitch[stage.b.pitch] = highestRanked.b
            default: break
            }
        }
        return spellingByPitch.map { SpelledPitch(pitch: $0, spelling: $1.spelling) }
    }
    
    private func createComparisonStage(for dyad: Dyad) -> ComparisonStage {
        let comparisonStage = comparisonStageFactory.makeComparisonStage(for: dyad)
        comparisonStages.append(comparisonStage)
        return comparisonStage
    }
    
    private func currentDyad(atIndex index: Int) -> Dyad? {
        guard let currentPitch = pitches[safe: index] else { return nil }
        guard let nextPitch = pitches[safe: index + 1] else { return nil }
        return Dyad(currentPitch, nextPitch)
    }
    
    private func previousDyad(atIndex index: Int) -> Dyad? {
        guard let currentPitch = pitches[safe: index] else { return nil }
        guard let previousPitch = pitches[safe: index - 1] else { return nil }
        return Dyad(currentPitch, previousPitch)
    }
}
