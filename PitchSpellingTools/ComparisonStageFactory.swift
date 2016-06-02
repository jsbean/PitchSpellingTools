//
//  ComparisonStageFactory.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/2/16.
//
//

import Pitch

struct ComparisonStageFactory {
    
    private let nodeResource: NodeResource
    
    init(nodeResource: NodeResource) {
        self.nodeResource = nodeResource
    }
    
    func makeComparisonStage(for dyad: Dyad) -> ComparisonStage {
        
        if dyad.canBeSpelledObjectively {

            return DeterminateComparisonStage(
                node(forObjectivelySpellablePitch: dyad.lower),
                node(forObjectivelySpellablePitch: dyad.higher)
            )
        }
        
        if dyad.isFullyAmbiguouslySpellable {
            
            return FullyAmbiguousComparisonStage(
                level(for: dyad.lower),
                level(for: dyad.higher)
            )
            
        } else {
            
            let (objectivelySpellable, subjective) = dyad.objectivelySpellableAndNot!
            return SemiAmbiguousComparisonStage(
                determinate: node(forObjectivelySpellablePitch: objectivelySpellable),
                other: level(for: subjective)
            )
        }
    }

    private func level(for pitch: Pitch) -> Level {
        guard let nodes = nodeResource[pitch] else { fatalError("Nodes not initialized") }
        return Level(pitch: pitch, nodes: nodes)
    }
    
    private func node(forObjectivelySpellablePitch pitch: Pitch) -> Node {
        guard let nodes = nodeResource[pitch] where
            nodes.count == 1,
            let first = nodes.first
        else { fatalError("Nodes not initialized") }
        return first
    }
}
