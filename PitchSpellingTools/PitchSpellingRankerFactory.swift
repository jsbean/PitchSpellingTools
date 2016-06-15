//
//  PitchSpellingRankerFactory.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/2/16.
//
//

import Pitch

/**
 Factory structure that creates the proper `PitchSpellingRanking`-conforming object from the
 given `PitchSpellingNodeResource` for each `Dyad`.
 */
public struct PitchSpellingRankerFactory {
    
    private let nodeResource: PitchSpellingNodeResource
    
    // MARK: - Initializers
    
    /**
     Create a `PitchSpellingRankerFactory` with a `PitchSpellingNodeResource`.
     */
    public init(nodeResource: PitchSpellingNodeResource) {
        self.nodeResource = nodeResource
    }
    
    // MARK: - Instance Methods
    
    /**
     - returns: `PitchSpellingRanking`-conforming object suitable for the given `dyad`.
     */
    public func makeRanker(for dyad: Dyad) -> PitchSpellingRanking {
        
        switch dyad.spellability {
        case .objective:
            return DeterminatePitchSpellingRanker(
                node(forObjectivelySpellablePitch: dyad.lower),
                node(forObjectivelySpellablePitch: dyad.higher)
            )
        case .fullyAmbiguous:
            return FullyAmbiguousPitchSpellingRanker(
                level(for: dyad.lower),
                level(for: dyad.higher)
            )
        case .semiAmbiguous:
            let (objectivelySpellable, subjective) = dyad.objectivelySpellableAndNot!
            return SemiAmbiguousPitchSpellingRanker(
                objectivelySpellable: node(forObjectivelySpellablePitch: objectivelySpellable),
                ambiguouslySpellable: level(for: subjective)
            )
        }
    }

    private func level(for pitch: Pitch) -> PitchSpellingStack {
        guard let nodes = nodeResource[pitch] else { fatalError("Nodes not initialized") }
        return PitchSpellingStack(pitch: pitch, nodes: nodes)
    }
    
    private func node(forObjectivelySpellablePitch pitch: Pitch) -> PitchSpellingNode {
        guard let nodes = nodeResource[pitch] where
            nodes.count == 1,
            let first = nodes.first
        else { fatalError("Nodes not initialized") }
        return first
    }
}
