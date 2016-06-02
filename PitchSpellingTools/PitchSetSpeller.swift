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
    
    /// - warning: this is currently assuming we don't want unconventional enharmonics 
    /// (e.g., (c flat), (b sharp), (d double sharp), etc)
    private lazy var nodeResource: NodeResource = {
        NodeResource(pitchSet: self.pitchSet)
    }()
    
    private lazy var dyads: [Dyad] = {
        self.pitchSet.dyads.sort { $0.interval.spellingUrgency < $1.interval.spellingUrgency }
    }()
    
    // `ComparisonStage` objects built
    private var comparisonStages: [ComparisonStage] = []
    
    // TODO: initialize ComparisonStageFactory once, 
    // - then call for it to make a new ComparisonStage for each dyad
    private lazy var comparisonStageFactory: ComparisonStageFactory = {
        ComparisonStageFactory(nodeResource: self.nodeResource)
    }()
    
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
            
            // If both pitches can be spelled objectively,
            if dyad.canBeSpelledObjectively {
                rankObjectivelySpellableDyad(dyad)
                continue
            }
            
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
