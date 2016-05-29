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
        for (_, nodes) in nodesByPitch {
            for node in nodes {
                if node.rank == nil { return false }
            }
        }
        return true
    }
    
    private lazy var nodesByPitch: [Pitch: [Node]] = {
        var result: [Pitch: [Node]] = [:]
        for pitch in self.pitchSet {
            result[pitch] = pitch.spellingsWithoutUnconventionalEnharmonics.map {
                Node(pitch: pitch, spelling: $0)
            }
        }
        return result
    }()
    
    private lazy var dyads: [Dyad] = {
        self.pitchSet.dyads.sort { $0.interval.spellingUrgency < $1.interval.spellingUrgency }
    }()
    
    // `ComparisonStage` objects built
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

        for (position, dyad) in dyads.enumerate() {
            
            // If all nodes have been given a rank, we are ready to make decisions
            if allNodesHaveBeenRanked { break }
            
            // If both pitches can be spelled objectively,
            if dyad.canBeSpelledObjectively {
                rankObjectivelySpellableDyad(dyad)
                continue
            }
            
            // Otherwise, prepare comparison state for Dyad
            let comparisonStage = makeComparisonStage(for: dyad)
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
        nodesByPitch[pitch]!.first!.rank = 1
    }
    
    private func rankWeight(for position: Int) -> Float {
        return (Float(dyads.count - position) / Float(dyads.count)) / 2
    }
    
    // FIXME: Make better names
    private func makeComparisonStage(for dyad: Dyad) -> ComparisonStage {
        
        let comparisonStage: ComparisonStage

        if dyad.isFullyAmbiguouslySpellable {
            
            comparisonStage = FullyAmbiguousComparisonStage(
                level(for: dyad.lower),
                level(for: dyad.higher)
            )
            
        } else {
            
            let (objectivelySpellable, not) = dyad.objectivelySpellableAndNot!
            comparisonStage = SemiAmbiguousComparisonStage(
                determinate: node(for: objectivelySpellable),
                other: level(for: not)
            )
        }
        
        // add comparison stages for later
        comparisonStages.append(comparisonStage)
        
        return comparisonStage
    }

    private func level(for pitch: Pitch) -> Level {
        guard let nodes = nodesByPitch[pitch] else { fatalError("Nodes not initialized") }
        return Level(pitch: pitch, nodes: nodes)
    }
    
    private func node(for objectivelySpellablePitch: Pitch) -> Node {
        guard let nodes = nodesByPitch[objectivelySpellablePitch]
            where nodes.count == 1,
            let node = nodes.first
        else {
            fatalError("Not objectively spellable Pitch")
        }
        return node
    }
    
    private func clearComparisonStages() {
        comparisonStages = []
    }
}
