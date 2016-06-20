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
     - TODO: refactor this into own struct
     - TODO: change local constraints to dyadIntrinsicConstraints ?
     - TODO: add option for spellings with or without unconventional enharmonics.
     - TODO: add satisfying local rules / global rules (spelling conflict, fine conflicts)
     - TODO: return tree that is unique compared to the given context
     */
    public static func makeTrees(
        for dyad: Dyad,
        globalConstraints: [(PitchSpellingDyad) -> Bool] = [],
        localConstraints: [(PitchSpellingDyad) -> Bool] = [],
        extendingPath path: Path = [],
        allowingUnconventionalEnharmonics allowsUnconventionalEnharmonics: Bool = true,
        allowingBackTrack allowsBackTrack: Bool = false
    ) -> [Node]
    {
        
        func spellingResource(for pitch: Pitch) -> [PitchSpelling] {
            return allowsUnconventionalEnharmonics
                ? pitch.spellings
                : pitch.spellingsWithoutUnconventionalEnharmonics
        }
        
        func globallyVerifiedSpellings(for pitch: Pitch, in path: Path) -> [PitchSpelling] {
            return spellingResource(for: pitch).filter { spelling in
                path.satisfiesAll(globalConstraints, for: spelling)
            }
        }

        // if a pitch has been represented, the spelling must be the same
        // global rules must be met
        // local rules _should_ be met
        // -- start strict
        // -- then roll back progressively for local rules only
        // -- starting at the leaves
        
        var result: [Node] = []

        switch path.pitchesRepresented(from: dyad) {
            
        case .neither:
            
            /// Iterate over every spelling of the **lower** pitch of the dyad that we are
            /// currently attempting to spell that satisfies all of the global constraints
            /// in the path that we are attempting to extend.
            for lowerSpelling in globallyVerifiedSpellings(for: dyad.lower, in: path) {
                
                /// Do the same for the **higher** pitch
                for higherSpelling in globallyVerifiedSpellings(for: dyad.higher, in: path) {
                    
                    /// Create a pitch spelling dyad for each globally verified spellings
                    /// for the purpose of checking it against all of the local constraints
                    let localDyad = PitchSpellingDyad(lowerSpelling, higherSpelling)
                    
                    /// Only if the local dyad satifies all of the local constraints, we then
                    /// add a branch for the two spellings we have found
                    if value(localDyad, satisfiesAll: localConstraints) {
                        let lowerNode = Node(pitch: dyad.lower, spelling: lowerSpelling)
                        let higherNode = Node(pitch: dyad.higher, spelling: higherSpelling)
                        lowerNode.addChild(higherNode)
                        result.append(lowerNode)
                    }
                }
            }
        
        case .single(let represented, let unrepresented):
            
            /// Get the spelling that already occurs in the path we are extending
            guard let spelling = path.spelling(for: represented) else { break }
            
            /// Get all of the spellings for the pitch that does not occur in the path we
            /// are attempting to extend
            let globallyVerified = globallyVerifiedSpellings(for: unrepresented, in: path)
            
            /// Filter out the spellings for the pitch that does not occur in the path we
            /// are attempting to extend that satisfy all of the local constraints
            let locallyVerified = globallyVerified
                .map { PitchSpellingDyad(spelling, $0) }
                .filter { value($0, satisfiesAll: localConstraints) }
                .map { Node(pitch: unrepresented, spelling: $0.a) }
            
            /// Add each of the locally and globally verified nodes
            result.appendContentsOf(locallyVerified)
            
        case .both:
            
            // skip if both pitches have been decided for this path!
            break
        }
        
        return result
    }
    
    public init(pitch: Pitch, spelling: PitchSpelling) {
        self.pitch = pitch
        self.spelling = spelling
    }
    
    func traverse(toSpell unspelled: [Dyad], from pitchSet: PitchSet) {
        
        // no more pitches to spell (worst case scenario)
        guard let (head, tail) = unspelled.destructured else { return }

        // generate subtrees for next dyad
        let subTrees = Node.makeTrees(
            for: head,
            localConstraints: [
                { $0.hasValidIntervalQuality },
                { $0.isFineCompatible }
            ],
            globalConstraints: [
                { $0.isFineCompatible }
            ],
            extendingPath: Path(pathToRoot)
        )
        
        subTrees.forEach { addChild($0) }
        leaves.forEach { $0.traverse(toSpell: tail, from: pitchSet) }
    }
}

// TODO: refactor as an extension of some sort ? on an Any ?!
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
    
    public var serialized: String {
        var result = "\n"
        for _ in 0..<depth { result += "\t" }
        result += "\(pitch.noteNumber.value): \(spelling)"
        for child in children {
            result += "\(child.serialized)"
        }
        return result
    }
    
    public var description: String {
        return "NODE: \(pitch); \(spelling); children: \(children.count)"
    }
}
