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
    
    public static func makeTrees(
        for dyad: Dyad,
        satisfying rules: [(PitchSpellingDyad) -> Bool] = [],
        avoidingSpellingConflictsWith nodes: [Node] = []
    ) -> [Node]
    {
        var result: [Node] = []
        for lowerSpelling in dyad.lower.spellings {
            let lowerNode = Node(pitch: dyad.lower, spelling: lowerSpelling)
            guard !lowerNode.hasFineConflict(with: nodes) else { continue }
            guard !lowerNode.hasSpellingConflicts(with: nodes) else { continue }
            for higherSpelling in dyad.higher.spellings {
                let higherNode = Node(pitch: dyad.higher, spelling: higherSpelling)
                guard !higherNode.hasFineConflict(with: nodes) else { continue }
                guard !higherNode.hasSpellingConflicts(with: nodes) else { continue }
                let pitchSpellingDyad = PitchSpellingDyad(lowerSpelling, higherSpelling)
                guard value(pitchSpellingDyad, satisfiesAll: rules) else { continue }
                lowerNode.addChild(higherNode)
            }
            if lowerNode.isContainer { result.append(lowerNode) }
        }
        return result
    }
    
    public init(pitch: Pitch, spelling: PitchSpelling) {
        self.pitch = pitch
        self.spelling = spelling
    }
    
    func traverse(toSpell unspelled: [Dyad], all: [Dyad]) {
        
        // no more pitches to spell (worst case scenario)
        guard let (head, tail) = unspelled.destructured else { return }

        // generate subtrees for next dyad
        let subTrees = Node.makeTrees(
            for: head,
            satisfying: [
                { $0.hasValidIntervalQuality },
                { $0.isFineCompatible }
            ],
            avoidingSpellingConflictsWith: pathToRoot
        )
        
        // attach child nodes
        subTrees.forEach { addChild($0) }
        
        // if all pitches present // get out of here, we are done!
        guard root.height + 1 < all.count else { return }

        // traverse the children of these nodes (skip generation)
        subTrees.forEach {
            for child in $0.children {
                child.traverse(toSpell: tail, all: all)
            }
        }
    }
    
    /**
     - returns: `true` if the given `nodes` share a `pitch` value, but are spelled differently.
     Otherwise, `false`.
     */
    public func hasSpellingConflicts(with nodes: [Node]) -> Bool {
        for node in nodes {
            
            if self.pitch == node.pitch && self.spelling != node.spelling {
                return true
            }
        }
        return false
    }
    
    public func hasFineConflict(with nodes: [Node]) -> Bool {
        for node in nodes {
            let pitchSpellingDyad = PitchSpellingDyad(self.spelling, node.spelling)
            if !pitchSpellingDyad.isFineCompatible {
                return true
            }
        }
        return false
    }
}



func value<T>(value: T, satisfiesAll rules: [(T) -> Bool]) -> Bool {
    for rule in rules where !rule(value) { return false }
    return true
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
