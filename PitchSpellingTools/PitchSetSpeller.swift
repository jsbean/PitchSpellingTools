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
     - warning: Not yet fully implemented!
     
     - throws: `PitchSpelling.Error` if unable to apply `PitchSpelling` objects to the given
     `PitchSet`.
     
     - returns: `SpelledPitchSet` containing spelled versions of the given `PitchSet`.
     */
    func spell() throws -> SpelledPitchSet {
        
        // Exit early is pitchSet is empty
        if pitchSet.isEmpty { return SpelledPitchSet(pitches: []) }
        
        // For now, exit early if pitchSet contains a single pitch
        if pitchSet.isMonadic {
            return SpelledPitchSet(
                pitches: try pitchSet.map { try $0.spelledWithDefaultSpelling() }
            )
        }
        
        // make this return something at some point
        compareOptions()
        
        // default impl to return
        return try pitchSet.spelledWithDefaultSpellings()
    }
    
    // TODO: make enum return value
    func compareOptions() {
        
        clearComparisonStages()

        // wrap up
        for (position, dyad) in dyads.enumerate() {
            
            // If all nodes have been given a rank, we are ready to make decisions
            if allNodesHaveBeenRanked { break }
            
            // Otherwise, prepare comparison state for Dyad
            let comparisonStage = comparisonStageFactory.makeComparisonStage(for: dyad)
            comparisonStages.append(comparisonStage)
            comparisonStage.applyRankings(withWeight: rankWeight(for: position))
        }

        if allNodesHaveBeenRanked {
            
            // TODO: for each node for each pitch, sort by rank, apply PitchSpellings
            // - done.
            
        } else {
            
            // TODO: take second pass over comparison stages, weighing them as appropriate
            // - for comparisonStage in comparisonStages { }
            // - merge paths
        }
    }
    
    private func rankObjectivelySpellableDyad(dyad: Dyad) {
        [dyad.higher, dyad.lower].forEach { rankObjectivelySpellablePitch($0) }
    }
    
    private func rankObjectivelySpellablePitch(pitch: Pitch) {
        nodeResource[pitch]!.first!.rank = 1
    }
    
    // TODO: refine
    private func rankWeight(for position: Int) -> Float {
        return (Float(dyads.count - position) / Float(dyads.count)) / 2
    }
    
    private func clearComparisonStages() {
        comparisonStages = []
    }
}
