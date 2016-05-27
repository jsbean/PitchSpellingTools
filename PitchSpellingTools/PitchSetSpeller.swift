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
    
    private var nodesByPitch: [Pitch: [Node]] {
        var result: [Pitch: [Node]] = [:]
        for pitch in pitchSet {
            result[pitch] = pitch.spellingsWithoutUnconventionalEnharmonics.map {
                Node(pitch: pitch, spelling: $0)
            }
        }
        return result
    }
    
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
    
    func compareOptions() {
        
        print("spell:")
        
        // manage monad
        let pitchArray = Array(pitchSet)
        if pitchArray.count == 1 {
            
        }
        
        
        for (position, dyad) in dyads.enumerate() {
            
            print("dyad: \(dyad)")
            if allNodesHaveBeenRanked { break }
            
            // bail if both can be spelled objectively
            if dyad.canBeSpelledObjectively {
                rankObjectivelySpellableDyad(dyad)
                continue
            }
            
            let comparisonStage = makeComparisonStage(for: dyad)
            comparisonStages.append(comparisonStage)
            
            let weight = Float(dyads.count - position) / Float(dyads.count)
            comparisonStage.rate(withWeight: weight)
        }
    }
    
    // make better name
    func spell() throws -> SpelledPitchSet {
        
        return try pitchSet.spelledWithDefaultSpellings()
    }
    
    private func rankObjectivelySpellableDyad(dyad: Dyad) {
        [dyad.higher, dyad.lower].forEach { rankObjectivelySpellablePitch($0) }
    }
    
    private func rankObjectivelySpellablePitch(pitch: Pitch) {
        nodesByPitch[pitch]?.first?.rank = 1
    }
    
    // TODO: refactor
    private func makeComparisonStage(for dyad: Dyad) -> ComparisonStage {
        
        let comparisonStage: ComparisonStage

        if dyad.isfullyAmbiguouslySpellable {
            comparisonStage = FullyAmbiguousComparisonStage(
                Level(nodes: nodesByPitch[dyad.lower]!),
                Level(nodes: nodesByPitch[dyad.higher]!)
            )
        } else {
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
