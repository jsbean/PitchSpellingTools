//
//  Tree.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/17/16.
//
//

import ArrayTools
import TreeTools
import Pitch

public final class Tree {
    
    private var pitchSet: PitchSet
    
    /// All `Dyad` values of the `pitchSet` contained herein, sorted for spelling priority.
    public lazy var dyads: [Dyad]? = {
        self.pitchSet.dyads?.sort {
            $0.interval.spellingPriority < $1.interval.spellingPriority
        }
    }()
    
    public init(pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
    
    public func spell() throws -> SpelledPitchSet {

        guard let dyads = dyads else { return SpelledPitchSet([]) }
        guard let (head, tail) = dyads.destructured else { return SpelledPitchSet([]) }

        let trees = makeTrees(
            for: head,
            satisfying: [
                { $0.hasValidIntervalQuality },
                { $0.isFineCompatible }
            ]
        )
        
        for tree in trees {
            for child in tree.children {
                child.traverse(toSpell: tail, all: dyads)
            }
        }

        let options = trees
            .flatMap {
                $0.leaves.map {
                    Set($0.pathToRoot.map { $0.spelling })
                }
            }
            .sort {
                $0.map { $0.spellingDistance }.mean! < $1.map { $0.spellingDistance }.mean!
            }
        
        print("options: \(options)")

        return SpelledPitchSet([])
    }
}
