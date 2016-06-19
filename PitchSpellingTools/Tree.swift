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
        case incorrectAmount
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
    
    public func spell() throws -> SpelledPitchSet {

        guard let dyads = dyads else { return SpelledPitchSet([]) }
        guard let (head, tail) = dyads.destructured else { return SpelledPitchSet([]) }

        let trees = Node.makeTrees(
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
        
        print(trees)
        let options = trees
            .flatMap { $0.leaves.map { Set($0.pathToRoot) } }
            .filter { $0.count == Array(pitchSet).count }
        guard options.count > 0 else { throw Error.noOptions }
        
//        for option in options {
//            print("option: \(option.map { $0.spelling })")
//        }
        
        let sorted = options.sort {
            $0.map { $0.spelling.spellingDistance }.mean! <
            $1.map { $0.spelling.spellingDistance }.mean!
        }
        
        let bestOption = sorted.first!
        let path = Path(nodes: bestOption)

        return path.applySpellings()
    }
}
