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

        // jump start process
        let trees = Node.makeTrees(
            for: head,
            satisfying: [
                { $0.hasValidIntervalQuality },
                { $0.isFineCompatible }
            ],
            allowingBackTrack: true
        )
        
        // traverse to generate trees
        for tree in trees {
            for child in tree.children {
                child.traverse(toSpell: tail, from: pitchSet)
            }
        }

        let options = trees.flatMap { $0.leaves.map { Set($0.pathToRoot) } }
        let validSizedOptions = options.filter { $0.count == Array(pitchSet).count }
        guard validSizedOptions.count > 0 else {
            print("no valid sized options for: \(pitchSet)")
            print("other options: \(options)")
            throw Error.noOptions
        }
        
        print("valid sized options: \(validSizedOptions)")
        let sorted = validSizedOptions.sort {
            $0.map { $0.spelling.spellingDistance }.mean! <
            $1.map { $0.spelling.spellingDistance }.mean!
        }
        
        let bestOption = sorted.first!
        let path = Path(bestOption)
        return path.applySpellings()
    }
}
