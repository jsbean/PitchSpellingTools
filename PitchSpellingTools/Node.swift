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
    
    func spell(pitchSet: PitchSet) -> SpelledPitchSet {
        
        func traverse(toSpell unspelled: [Pitch], result: [Node]) -> [Node] {
            
            // TODO:
            guard let (head, tail) = unspelled.destructured else { return result }
            for spellingToCompare in head.spellings {
                let dyad = PitchSpellingDyad(spelling, spellingToCompare)
                
                // check all rules!
                
                addNode(forPitch: head, andSpelling: spellingToCompare)
            }
            
            return []
        }
        
        if pitchSet.isEmpty { return SpelledPitchSet([]) }

        let unspelled = prepareUnspelledPitches(fromPitchSet: pitchSet)
        traverse(toSpell: unspelled, result: [])
        
        return SpelledPitchSet([])
    }
    
    private func prepareUnspelledPitches(fromPitchSet pitchSet: PitchSet) -> [Pitch] {
        var pitchSet = pitchSet
        return pitchSet.dyads!
            .sort { $0.interval.spellingPriority < $1.interval.spellingPriority }
            .flatMap { [$0.lower, $0.higher] }
            .unique
    }
    
//    public func traverse(withPitch pitch: Pitch, result: [Node]) {
//        for otherSpelling in pitch.spellings {
//            let dyad = PitchSpellingDyad(spelling, otherSpelling)
//            if dyad.isFineCompatible {
//                addNode(forPitch: pitch, andSpelling: otherSpelling)
//            }
//        }
//    }
    
    public func addNode(forPitch pitch: Pitch, andSpelling spelling: PitchSpelling) {
        let node = Node(pitch: pitch, spelling: spelling)
        addChild(node)
    }
}