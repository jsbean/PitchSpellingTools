//
//  PitchSequenceSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/31/16.
//
//

import ArrayTools
import Pitch

final class PitchSequenceSpeller: PitchSpeller {
    
    enum Error: ErrorType { case cannotSpellNodes }
    
    /// Collection of references to `Node` objects for each `Pitch`.
    private lazy var nodeResource: NodeResource = {
        NodeResource(pitches: self.pitchSequence)
    }()
    
    /// Factory that creates `ComparisonStage` objects applicable for this `PitchSet`
    private lazy var comparisonStageFactory: ComparisonStageFactory = {
        ComparisonStageFactory(nodeResource: self.nodeResource)
    }()
    
    private var pitchSequenceIsObjectivelySpellableOrMonadic: Bool {
        return pitchSequence.allMatch({ $0.canBeSpelledObjectively }) || pitchSequence.isMonadic
    }

    private var comparisonStages: [ComparisonStage] = []
    
    let pitchSequence: PitchSequence

    /**
     Create a `PitchSequenceSpeller` with an array of `Pitch` values.
     */
    init(pitchSequence: PitchSequence) {
        self.pitchSequence = pitchSequence
    }
    
    /**
     - throws: `PitchSpelling.Error` if improper spelling is attempted.
     
     - returns: Array of `SpelledPitch` values.
     
     - TODO: Change return value to be `SpelledPitchSet`.
     */
    func spell() throws -> [SpelledPitch] {
        
        if pitchSequence.isEmpty { return [] }
        
        return pitchSequenceIsObjectivelySpellableOrMonadic
            ? try spelledPitchSequenceSpelledWithDefaultSpellings()
            : try spelledPitchSequenceByCreatingComparisonStages()
    }
    
    private func spelledPitchSequenceSpelledWithDefaultSpellings() throws -> [SpelledPitch] {
        return try pitchSequence.map { try $0.spelledWithDefaultSpelling() }
    }
    
    private func spelledPitchSequenceByCreatingComparisonStages() throws -> [SpelledPitch] {
        createComparisonStages()
        return nodeResource.allNodesHaveBeenRanked
            ? try commitRankedSpellings()
            : try commitSpellingsFromComparisonStages()
    }
    
    private func createComparisonStages() {
        for index in 0 ..< pitchSequence.count - 1 {
            guard let currentDyad = dyad(atIndex: index) else { break }
            let comparisonStage = createComparisonStage(for: currentDyad)
            comparisonStage.applyRankings(withWeight: rankWeight(for: index))
            print(comparisonStage)
        }
    }
    
    private func createComparisonStage(for dyad: Dyad) -> ComparisonStage {
        let comparisonStage = comparisonStageFactory.makeComparisonStage(for: dyad)
        comparisonStages.append(comparisonStage)
        return comparisonStage
    }
    
    private func rankWeight(for position: Int) -> Float {
        return (Float(position) + 1 / Float(pitchSequence.count)) / 2
    }
    
    private func commitRankedSpellings() throws -> [SpelledPitch] {
        print("commit ranked spellings")
        print(nodeResource.nodes)
        if comparisonStages.allMatch (
            { $0 is DeterminateComparisonStage || $0 is SemiAmbiguousComparisonStage }
        )
        {
            guard nodeResource.allNodesHaveBeenRanked else { throw Error.cannotSpellNodes }
            nodeResource.sortByRank()
            return nodeResource.reduce([]) { array, nodesByPitch in
                guard let spelling = nodesByPitch.1.first?.spelling else { return array }
                return array + SpelledPitch(pitch: nodesByPitch.0, spelling: spelling)
            }
        }
        
        // otherwise, take a second pass
        
        print("have to incorporate fully ambiguous")
        for comparisonStage in comparisonStages
            where comparisonStage is FullyAmbiguousComparisonStage
        {
            print(comparisonStage)
        }
        
        return []
    }
    
    // TODO: refactor
    // Currently, the previous pitch spelling is just overriden by the current
    // - as opposed to making a rank comparison
    private func commitSpellingsFromComparisonStages() throws -> [SpelledPitch] {
        print("commit spellings from comparison stages")
        nodeResource.sortByRank()
        var spellingByPitch: [Pitch: Node] = [:]
        for comparisonStage in comparisonStages {
            print(comparisonStage)
            switch comparisonStage {
            case let stage as DeterminateComparisonStage:
                spellingByPitch[stage.a.pitch] = stage.a
                spellingByPitch[stage.b.pitch] = stage.b
            case let stage as SemiAmbiguousComparisonStage:
                spellingByPitch[stage.other.pitch] = stage.other.highestRanked
                spellingByPitch[stage.determinate.pitch] = stage.determinate
            case let stage as FullyAmbiguousComparisonStage:
                // get the highest ranked edge
                guard let highestRanked = stage.highestRanked else { fatalError() }
                spellingByPitch[stage.a.pitch] = highestRanked.a
                spellingByPitch[stage.b.pitch] = highestRanked.b
            default: break
            }
        }
        return spellingByPitch.map { SpelledPitch(pitch: $0, spelling: $1.spelling) }
    }

    private func dyad(atIndex index: Int) -> Dyad? {
        guard let currentPitch = Array(pitchSequence)[safe: index] else { return nil }
        guard let nextPitch = Array(pitchSequence)[safe: index + 1] else { return nil }
        return Dyad(currentPitch, nextPitch)
    }
}
