//
//  PitchSequenceSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/8/16.
//
//

import Pitch

public final class PitchSequenceSpeller {
    
    public typealias Result = [SpelledPitchSet]
    
    // Create `Node` resource
    
    // cut up sequences in the pattern:
    // [ (zero or more) non-objectively-spellable, (zero or one) objectively-spellable ]
    // [ (zero or one) objectively-spellable, (zero or more) non-objectively-spellable ]
    
    public lazy var subSequences: [[PitchSet]] = {
        var result: [[PitchSet]] = []
        var last: [PitchSet]?
        for set in self.sets {
            var current = last ?? []
            switch set.spellability {
            case .objective:
                current.append(set)
                result.append(current)
                last = nil
            default:
                current.append(set)
                last = current
            }
        }
        if let last = last { result.append(last) }
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
