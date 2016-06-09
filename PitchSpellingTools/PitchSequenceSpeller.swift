//
//  PitchSequenceSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/8/16.
//
//

import ArrayTools
import Pitch

public final class PitchSequenceSpeller {
    
    public typealias Result = [SpelledPitchSet]
    
    public lazy var subSequences: [[PitchSet]] = {
        var result: [[PitchSet]] = []
        var last: [PitchSet]?
        
        var s = self.sets.startIndex
        while s < self.sets.endIndex {

            let currentSet = self.sets[s]
            
            // If first
            guard let previousSet = self.sets[safe: s - 1] else {
                last = [currentSet]
                s += 1
                continue
            }
            
            var subSegment = last ?? []
            subSegment.append(currentSet)
            
            // If last
            guard let nextSet = self.sets[safe: s + 1] else {
                result.append(subSegment)
                break
            }
            
            switch (currentSet.spellability, nextSet.spellability) {
            case (_, .objective):
                subSegment.append(nextSet)
                result.append(subSegment)
                last = nil
                s += 1 // advance past
            default:
                print("just add it to the collection")
                last = subSegment
            }
            s += 1
        }
        return result
    }()
    
    private lazy var spellers: [PitchSubSequenceSpeller] = {
        self.subSequences.map { PitchSubSequenceSpeller(sets: $0) }
    }()
    
    private let sets: [PitchSet]
    
    public init(sets: [PitchSet]) {
        self.sets = sets
    }
    
    public func applyRankings() {
        spellers.forEach { $0.applyRankings() }
    }
    
    public func spell() throws -> Result {
        applyRankings()
        return try spellers.flatMap { try $0.spell() }
    }
}
