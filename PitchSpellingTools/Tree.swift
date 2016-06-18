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

        let subPaths = createDyadSubPaths(for: head)
        for subPath in subPaths {
            for child in subPath.children {
                child._traverse(toSpell: tail, all: dyads)
            }
        }
        
        let options = subPaths
            .flatMap {
                $0.leaves.map {
                    Set($0.pathToRoot.map { $0.spelling })
                }
            }
            .sort {
                $0.map { $0.spellingDistance }.mean! < $1.map { $0.spellingDistance }.mean!
            }

        return SpelledPitchSet([])
    }
    
    func createDyadSubPaths(for dyad: Dyad) -> [Node] {
        
        var result: [Node] = []
        for lower in dyad.lower.spellings {
            let node = Node(pitch: dyad.lower, spelling: lower)
            for higher in dyad.higher.spellings {
                let pitchSpellingDyad = PitchSpellingDyad(lower, higher)
                if pitchSpellingDyad.hasValidIntervalQuality && pitchSpellingDyad.isFineCompatible {
                    //print("PASSED TEST")
                    let child = Node(pitch: dyad.higher, spelling: higher)
                    node.addChild(child)
                } else {
                    //print("FAILED TEST")
                }
            }
            if node.isContainer {
                result.append(node)
            }
        }
        //print("create dyad sub paths for dyad: \(dyad): \(result)")
        return result
    }
    
    private func prepareUnspelledPitches(fromPitchSet pitchSet: PitchSet) -> [Pitch] {
        var pitchSet = pitchSet
        return pitchSet.dyads!
            .sort { $0.interval.spellingPriority < $1.interval.spellingPriority }
            .flatMap { [$0.lower, $0.higher] }
            .unique
    }
}
