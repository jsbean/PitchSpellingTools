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
    
    private var comparisonStages: [ComparisonStage] = []
    
    private let pitchSet: PitchSet
    
    /**
     Create a `PitchSetSpeller` with a `PitchSet`.
     */
    public init(_ pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
    
    /**
     - warning: Not yet implemented!
     
     - throws: `PitchSpelling.Error` if unable to apply `PitchSpelling` objects to the given
     `PitchSet`.
     
     - returns: `SpelledPitchSet` containing spelled versions of the given `PitchSet`.
     */
    func spell() throws -> SpelledPitchSet {
        
        if pitchSet.isEmpty { return SpelledPitchSet(pitches: []) }
        
        if pitchSet.isMonadic {
            return SpelledPitchSet(
                pitches: try pitchSet.map { try $0.spelledWithDefaultSpelling() }
            )
        }
        
        compareOptions()
        
        // default impl to return
        return try pitchSet.spelledWithDefaultSpellings()
    }
    
    func compareOptions() {

        for (position, dyad) in dyads.enumerate() {
            if allNodesHaveBeenRanked {
                print("bail if all nodes have been ranked")
                break
            }
            
            // bail if both can be spelled objectively
            if dyad.canBeSpelledObjectively {
                rankObjectivelySpellableDyad(dyad)
                continue
            }
            
            let comparisonStage = makeComparisonStage(for: dyad)
            comparisonStages.append(comparisonStage)
            
            let weight = (Float(dyads.count - position) / Float(dyads.count)) / 2
            
            comparisonStage.applyRankings(withWeight: weight)
        }

        if allNodesHaveBeenRanked {
            print("all nodes have been ranked")
        } else {
            //
        }
        
        // check out what each comparison stage has got
        // if needed, merge edges to form paths, if possible
        
        for (pitch, nodes) in nodesByPitch {
            nodesByPitch[pitch] = nodes.filter { $0.rank != nil }.sort { $0.rank! > $1.rank! }
        }
        print("nodesByPitch: \(nodesByPitch)")
        if !allNodesHaveBeenRanked {
            // this means we have to make a decision, or pass the buck
        }
    }

    private func rankObjectivelySpellableDyad(dyad: Dyad) {
        [dyad.higher, dyad.lower].forEach { rankObjectivelySpellablePitch($0) }
    }
    
    private func rankObjectivelySpellablePitch(pitch: Pitch) {
        nodesByPitch[pitch]?.first?.rank = 1
    }
    
    // TODO: refactor
    private func makeComparisonStage(for dyad: Dyad) -> ComparisonStage {
        
        print("make comparison stage for dyad: \(dyad)")
        let comparisonStage: ComparisonStage

        if dyad.isfullyAmbiguouslySpellable {
            print("Begin FullyAmbiguous Comparison Stage")
            comparisonStage = FullyAmbiguousComparisonStage(
                Level(nodes: nodesByPitch[dyad.lower]!),
                Level(nodes: nodesByPitch[dyad.higher]!)
            )
        } else {
            print("Begin SemiAmbiguous Comparison Stage")
            if dyad.higher.canBeSpelledObjectively {
                comparisonStage = SemiAmbiguousComparisonStage(
                    determinate: nodesByPitch[dyad.higher]!.first!,
                    other: Level(nodes: nodesByPitch[dyad.lower]!)
                )
            } else {
                comparisonStage = SemiAmbiguousComparisonStage(
                    determinate: nodesByPitch[dyad.lower]!.first!,
                    other: Level(nodes: nodesByPitch[dyad.higher]!)
                )
            }
        }
        return comparisonStage
    }
}
