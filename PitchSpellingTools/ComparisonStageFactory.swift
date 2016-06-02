//
//  ComparisonStageFactory.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/2/16.
//
//

import Pitch

struct ComparisonStageFactory {
    
    private let nodesByPitch: [Pitch: [Node]]
    
    init(nodesByPitch: [Pitch: [Node]]) {
        self.nodesByPitch = nodesByPitch
    }
    
    func makeComparisonStage(for dyad: Dyad) -> ComparisonStage {
        let comparisonStage: ComparisonStage
        
        if dyad.isFullyAmbiguouslySpellable {
            
            comparisonStage = FullyAmbiguousComparisonStage(
                level(for: dyad.lower),
                level(for: dyad.higher)
            )
            
        } else {
            
            let (objectivelySpellable, subjective) = dyad.objectivelySpellableAndNot!
            comparisonStage = SemiAmbiguousComparisonStage(
                determinate: Node(objectivelySpellablePitch: objectivelySpellable),
                other: level(for: subjective)
            )
        }
        
        return comparisonStage
    }

    private func level(for pitch: Pitch) -> Level {
        guard let nodes = nodesByPitch[pitch] else { fatalError("Nodes not initialized") }
        return Level(pitch: pitch, nodes: nodes)
    }
}
