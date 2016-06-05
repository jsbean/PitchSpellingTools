//
//  PitchSetSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/17/16.
//
//

import ArrayTools
import Pitch

/**
 Spells `PitchSet` values.
 */
public final class PitchSetSpeller: PitchSpeller {
    
    private var allNodesHaveBeenRanked: Bool {
        return nodeResource.allNodesHaveBeenRanked
    }

    private lazy var nodeResource: NodeResource = { NodeResource(pitches: self.pitchSet) }()
    
    private lazy var dyads: [Dyad] = {
        self.pitchSet.dyads.sort { $0.interval.spellingUrgency < $1.interval.spellingUrgency }
    }()
    
    /// Factory that creates `ComparisonStage` objects applicable for this `PitchSet`
    private lazy var comparisonStageFactory: ComparisonStageFactory = {
        ComparisonStageFactory(nodeResource: self.nodeResource)
    }()
    
    // `ComparisonStage` objects built that can be referenced after initial decision making
    private var comparisonStages: [ComparisonStage] = []
    
    private var pitchSetIsObjectivelySpellableOrMonadic: Bool {
        return pitchSet.allMatch({ $0.canBeSpelledObjectively }) || pitchSet.isMonadic
    }
    
    // `PitchSet` to be spelled
    private let pitchSet: PitchSet
    
    /**
     Create a `PitchSetSpeller` with a `PitchSet`.
     */
    public init(_ pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
    
    // TODO: incorporate external coarse / fine preferences
    
    /**
     - throws: `PitchSpelling.Error` if unable to apply `PitchSpelling` objects to the given
     `PitchSet`.
     
     - returns: `SpelledPitchSet` containing spelled versions of the given `PitchSet`.
     */
    func spell() throws -> SpelledPitchSet {
        
        // Exit early is pitchSet is empty
        if pitchSet.isEmpty { return SpelledPitchSet(pitches: []) }

        return pitchSetIsObjectivelySpellableOrMonadic
            ? try spelledPitchSetWithDefaultSpellings()
            : try spelledPitchSetByCreatingComparisonStages()
    }
    
    private func spelledPitchSetWithDefaultSpellings() throws -> SpelledPitchSet {
        return try pitchSet.spelledWithDefaultSpellings()
    }
    
    // TODO: Make throw
    func spelledPitchSetByCreatingComparisonStages() throws -> SpelledPitchSet {
        
        clearComparisonStages()

        // TODO: refactor into own private method
        for (position, dyad) in dyads.enumerate() {
            
            // If all nodes have been given a rank, we are ready to make decisions
            if allNodesHaveBeenRanked { break }
            
            // Otherwise, prepare comparison state for Dyad
            let comparisonStage = comparisonStageFactory.makeComparisonStage(for: dyad)
            comparisonStages.append(comparisonStage)
            comparisonStage.applyRankings(withWeight: rankWeight(for: position))
        }
        
        // TODO: refactor into own private method
        // Jump start ambiguous choosing process by asserting most urgent edge ranked
        if nodeResource.noNodesHaveBeenRanked {
            let first = comparisonStages[0] as! FullyAmbiguousComparisonStage
            first.highestRanked!.a.rank = 1
            first.highestRanked!.b.rank = 1
        }
        
        // TODO: refacotr into own private method
        for c in comparisonStages.indices {
            
            // TODO: come up with better names
            guard let ambiguous = comparisonStages[c] as? FullyAmbiguousComparisonStage
            else { continue }

            // TODO: make this not a reach-around
            let bestRanked = ambiguous.edges.extremeElements(>) { $0.rank }
            let notGoodEnough = bestRanked.extremeElements(<) { $0.meanRank ?? Float.min }
            for edge in notGoodEnough { edge.penalizeNodes(withWeight: rankWeight(for: c)) }
        }
        return highestRankedPitches()
    }
    
    // Make throws
    private func highestRankedPitches() -> SpelledPitchSet {
        precondition(allNodesHaveBeenRanked)
        nodeResource.sortByRank()
        return SpelledPitchSet(pitches:
            nodeResource.reduce([]) { array, nodesByPitch in
                guard let spelling = nodesByPitch.1.first?.spelling else { return array }
                return array + SpelledPitch(pitch: nodesByPitch.0, spelling: spelling)
            }
        )
    }
    
    // TODO: refine
    private func rankWeight(for position: Int) -> Float {
        return (Float(dyads.count - position) / Float(dyads.count)) / 2
    }
    
    private func clearComparisonStages() {
        comparisonStages = []
    }
}
