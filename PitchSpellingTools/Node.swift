//
//  Node.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/17/16.
//
//

import ArrayTools
import TreeTools
import Pitch

public final class Node: NodeType {
    
    public var parent: Node?
    public var children: [Node] = []
    
    public let pitch: Pitch
    public let spelling: PitchSpelling
    
    public init(pitch: Pitch, spelling: PitchSpelling) {
        self.pitch = pitch
        self.spelling = spelling
    }
    
    func _traverse(toSpell unspelled: [Dyad], all: [Dyad]) {
        guard let (head, tail) = unspelled.destructured else { return }
        
        let subPaths = createDyadSubPaths(for: head)
        subPaths.forEach { addChild($0) }

        guard root.height + 1 < all.count else { return }

        subPaths.forEach {
            for child in $0.children {
                child._traverse(toSpell: tail, all: all)
            }
        }
    }
    
    func createDyadSubPaths(for dyad: Dyad) -> [Node] {
        var result: [Node] = []

        
        
        for lower in dyad.lower.spellings {
            
            // refactor
            var spellingParity = true
            for previousNode in pathToRoot {
                if previousNode.pitch == dyad.lower && previousNode.spelling != lower {
                    spellingParity = false
                }
            }
            guard spellingParity else { continue }
            
            let node = Node(pitch: dyad.lower, spelling: lower)
            for higher in dyad.higher.spellings {
                
                // refactor
                var spellingParity = true
                for previousNode in pathToRoot {
                    if previousNode.pitch == dyad.higher && previousNode.spelling != higher {
                        spellingParity = false
                    }
                }
                
                guard spellingParity else { continue }

                let pitchSpellingDyad = PitchSpellingDyad(lower, higher)
                if pitchSpellingDyad.hasValidIntervalQuality {
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
        return result
    }
    
    // construct tree
    func traverse(toSpell unspelled: [Pitch]) {
        
        //print("traverse: \(self), toSpell: \(unspelled)")
        
        // TODO:
        
        // If there is
        guard let (head, tail) = unspelled.destructured else {
            //print("SUCCESS: \(self.pathToRoot)")
            return
        }
        
        for spellingToCompare in head.spellings {
            let dyad = PitchSpellingDyad(spelling, spellingToCompare)
            
            //print("PitchSpellingDyad: \(dyad)")
            
            // check all rules!
            if dyad.hasValidIntervalQuality && dyad.isFineCompatible {
                //print("TEST PASSED")
                let node = addNode(forPitch: head, andSpelling: spellingToCompare)
                node.traverse(toSpell: tail)
            } else {
                //print("TEST FAILED")
            }
        }
    }
    
    func spell(pitchSet: PitchSet) -> SpelledPitchSet {
        
        if pitchSet.isEmpty { return SpelledPitchSet([]) }

        let unspelled = prepareUnspelledPitches(fromPitchSet: pitchSet)
        traverse(toSpell: unspelled)
        
        return SpelledPitchSet([])
    }
    
    private func prepareUnspelledPitches(fromPitchSet pitchSet: PitchSet) -> [Pitch] {
        var pitchSet = pitchSet
        return pitchSet.dyads!
            .sort { $0.interval.spellingPriority < $1.interval.spellingPriority }
            .flatMap { [$0.lower, $0.higher] }
            .unique
    }

    public func addNode(forPitch pitch: Pitch, andSpelling spelling: PitchSpelling) -> Node {
        let node = Node(pitch: pitch, spelling: spelling)
        addChild(node)
        return node
    }
}

extension Node: Hashable {
    public var hashValue: Int { return "\(pitch),\(spelling)".hashValue }
}

public func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.pitch == rhs.pitch && lhs.spelling == rhs.spelling
}

extension Node: CustomStringConvertible {
    
    public var description: String {
        var result = "\n"
        for _ in 0..<depth { result += "\t" }
        result += "\(pitch.noteNumber.value): \(spelling)"
        for child in children {
            result += "\(child)"
        }
        return result
    }
}