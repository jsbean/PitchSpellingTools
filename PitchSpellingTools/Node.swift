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
    
    /**
     - TODO: add option for spellings with or without unconventional enharmonics.
     - TODO: add satisfying local rules / global rules (spelling conflict, fine conflicts)
     - TODO: return tree that is unique compared to the given context
     */
    public static func makeTrees(
        for dyad: Dyad,
        satisfying rules: [(PitchSpellingDyad) -> Bool] = [],
        avoidingSpellingConflictsWith nodes: [Node] = [],
        allowingUnconventionalEnharmonics allowsUnconventionalEnharmonics: Bool = true
    ) -> [Node]
    {
        var result: [Node] = []
        
        func spellingResource(for pitch: Pitch) -> [PitchSpelling] {
            return allowsUnconventionalEnharmonics
                ? pitch.spellings
                : pitch.spellingsWithoutUnconventionalEnharmonics
        }

        for lowerSpelling in spellingResource(for: dyad.lower) {
            
            // Create node for lower pitch
            let lowerNode = Node(pitch: dyad.lower, spelling: lowerSpelling)
            
            // Check global constraints
            guard !lowerNode.hasFineConflict(with: nodes) else { continue }
            guard !lowerNode.hasSpellingConflicts(with: nodes) else { continue }
            
            for higherSpelling in spellingResource(for: dyad.higher) {
                
                let higherNode = Node(pitch: dyad.higher, spelling: higherSpelling)
                
                // Check global constraints
                guard !higherNode.hasFineConflict(with: nodes) else { continue }
                guard !higherNode.hasSpellingConflicts(with: nodes) else { continue }
                
                // Check local constraints
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
        guard root.height + 1 < all.count * 2 else {
            //print("rootheight: \(root.height + 1); dyads.count: \(all.count)")
            return
        }

        // traverse the children of these nodes (skip generation)
        subTrees.forEach {
            $0.children.forEach {
                $0.traverse(toSpell: tail, all: all)
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
    
    /**
     - returns: `true` if there is any conflict of fine adjustment between this node and any
     contained in the given `nodes`. Otherwise, `false`.
     */
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
    for rule in rules where !rule(value) {
        return false
    }
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
