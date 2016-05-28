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
        
        // Exit early is pitchSet is empty
        if pitchSet.isEmpty { return SpelledPitchSet(pitches: []) }
        
        // For now, exit early if pitchSet contains a single pitch
        if pitchSet.isMonadic {
            return SpelledPitchSet(
                pitches: try pitchSet.map { try $0.spelledWithDefaultSpelling() }
            )
        }
        
        // make this return something
        compareOptions()
        
        // default impl to return
        return try pitchSet.spelledWithDefaultSpellings()
    }
    
    func compareOptions() {

        for (position, dyad) in dyads.enumerate() {
            
            print("Nodes: \(nodesByPitch)")
            
            if allNodesHaveBeenRanked {
                print("BREAK IF ALL NODES HAVE BEEN RANKED!")
                break
            }
            
            // bail if both can be spelled objectively
            if dyad.canBeSpelledObjectively {
                print("Dyad is objectively spellable: rank = 1 for both")
                rankObjectivelySpellableDyad(dyad)
                continue
            }
            
            let comparisonStage = makeComparisonStage(for: dyad)
            let weight = (Float(dyads.count - position) / Float(dyads.count)) / 2
            comparisonStage.applyRankings(withWeight: weight)
        }

        if allNodesHaveBeenRanked {
            print("all nodes have been ranked")
            var spelledPitches: [SpelledPitch] = []
            for (pitch, nodes) in nodesByPitch {
                // for each pitch, get the highest rated node
                let bestMatch = nodes.sort { $0.rank > $1.rank }.first!.spelling
                let spelledPitch = spell(pitch, with: bestMatch)!
                spelledPitches.append(spelledPitch)
            }
            // RETURN PITCH SET FROM HERE!
            print("spelledPitches: \(spelledPitches)")
        } else {
            for comparisonStage in comparisonStages {
                print("ComparisonStage: Edges: \(comparisonStage.edges)")
            }
            // compare and merge edges into paths
        }
        
        // check out what each comparison stage has got
        // if needed, merge edges to form paths, if possible
        
        print("nodesByPitch: \(nodesByPitch)")
        if !allNodesHaveBeenRanked {
            
        }
    }

    private func rankObjectivelySpellableDyad(dyad: Dyad) {
        [dyad.higher, dyad.lower].forEach { rankObjectivelySpellablePitch($0) }
    }
    
    private func rankObjectivelySpellablePitch(pitch: Pitch) {
        nodesByPitch[pitch]!.first!.rank = 1
    }
    
    // TODO: refactor
    private func makeComparisonStage(for dyad: Dyad) -> ComparisonStage {
        
        let comparisonStage: ComparisonStage

        if dyad.isFullyAmbiguouslySpellable {
            print("Begin FullyAmbiguous Comparison Stage")
            comparisonStage = FullyAmbiguousComparisonStage(
                Level(nodes: nodesByPitch[dyad.lower]!),
                Level(nodes: nodesByPitch[dyad.higher]!)
            )
        } else {
            print("Begin SemiAmbiguous Comparison Stage")
            print("dyad: \(dyad)")
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
        comparisonStages.append(comparisonStage)
        return comparisonStage
    }
}
