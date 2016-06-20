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
    
    public enum Error: ErrorType {
        case noOptions
    }
    
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
    
    public func spell(
        allowingUnconventionalEnharmonics allowsUnconventionalEnharmonics: Bool = true
    ) throws -> SpelledPitchSet
    {

        guard let dyads = dyads else { return SpelledPitchSet([]) }
        guard let (head, tail) = dyads.destructured else { return SpelledPitchSet([]) }
        
        let localConstraints: [(PitchSpellingDyad) -> Bool] = [
            { $0.hasValidIntervalQuality },
            { $0.isFineCompatible }
        ]
        
        let globalConstraints: [(PitchSpellingDyad) -> Bool] = [
            { $0.isFineCompatible }
        ]

        // jump start process
        var trees = Node.makeTrees(
            for: head,
            localConstraints: localConstraints,
            globalConstraints: globalConstraints,
            allowingUnconventionalEnharmonics: allowsUnconventionalEnharmonics
        )
        
        // while trees.count == 0 { }
        
        // start rolling back local constraints
        if trees.count == 0 {
            print("retry 1")
            trees = Node.makeTrees(
                for: head,
                localConstraints: [
                    { $0.isFineCompatible }
                ]
            )
        }
        
        if trees.count == 0 {
            print("retry 2")
            trees = Node.makeTrees(for: head)
        }
        
        print("trees.count: \(trees.count); dyad: \(head)")
        
        // TODO: wrap in method traverse to generate trees
        for tree in trees {
            for leaf in tree.leaves {
                leaf.traverse(
                    toSpell: tail,
                    from: pitchSet,
                    localConstraints: [
                        { $0.hasValidIntervalQuality },
                        { $0.isFineCompatible }
                    ]
                )
            }
        }

        // just get the longest ones
        let options = trees
            .flatMap { $0.leaves.map { $0.pathToRoot } }
            .filter { $0.count == Array(pitchSet).count }
        
        guard options.count > 0 else { throw Error.noOptions }
        
        let sorted = options.sort {
            $0.map { $0.spelling.spellingDistance }.mean! <
            $1.map { $0.spelling.spellingDistance }.mean!
        }
        
        let bestOption = sorted.first!
        let path = Path(bestOption)
        return path.applySpellings()
    }
}
