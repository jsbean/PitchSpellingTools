//
//  PitchHorizontalitySpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/31/16.
//
//

import ArrayTools
import Pitch

final class PitchHorizontalitySpeller: PitchSpeller {
    
    enum Error: ErrorType {
        case cannotSpellNodes
    }
    
    /// Collection of references to `Node` objects for each `Pitch`.
    private lazy var nodeResource: NodeResource = { NodeResource(pitches: self.pitches) }()
    
    /// Factory that creates `ComparisonStage` objects applicable for this `PitchSet`
    private lazy var comparisonStageFactory: ComparisonStageFactory = {
        ComparisonStageFactory(nodeResource: self.nodeResource)
    }()
    
    private var pitchesAreObjectivelySpellableOrMonadic: Bool {
        return pitches.allMatch({ $0.canBeSpelledObjectively }) || pitches.count == 1
    }

    private var comparisonStages: [ComparisonStage] = []
    
    let pitches: [Pitch]

    /**
     Create a `PitchHorizontalitySpeller` with an array of `Pitch` values.
     */
    init(pitches: [Pitch]) {
        self.pitches = pitches
    }
    
    /**
     - throws: `PitchSpelling.Error` if improper spelling is attempted.
     
     - returns: Array of `SpelledPitch` values.
     
     - TODO: Change return value to be `SpelledPitchSet`.
     */
    func spell() throws -> [SpelledPitch] {
        
        if pitches.isEmpty { return [] }
        
        return pitchesAreObjectivelySpellableOrMonadic
            ? try spelledPitchesSpelledWithDefaultSpellings()
            : try spelledPitchesByCreatingComparisonStages()
    }
    
    private func spelledPitchesSpelledWithDefaultSpellings() throws -> [SpelledPitch] {
        return try pitches.map { try $0.spelledWithDefaultSpelling() }
    }
    
    private func spelledPitchesByCreatingComparisonStages() throws -> [SpelledPitch] {
        createComparisonStages()
        return nodeResource.allNodesHaveBeenRanked
            ? try commitRankedSpellings()
            : try commitSpellingsFromComparisonStages()
    }
    
    private func createComparisonStages() {
        for index in 0 ..< pitches.count - 1 {
            guard let currentDyad = dyad(atIndex: index) else { break }
            let comparisonStage = createComparisonStage(for: currentDyad)
            comparisonStage.applyRankings(withWeight: rankWeight(for: index))
        }
    }
    
    private func createComparisonStage(for dyad: Dyad) -> ComparisonStage {
        let comparisonStage = comparisonStageFactory.makeComparisonStage(for: dyad)
        comparisonStages.append(comparisonStage)
        return comparisonStage
    }
    
    private func rankWeight(for position: Int) -> Float {
        return (Float(position) + 1 / Float(pitches.count)) / 2
    }
    
    private func commitRankedSpellings() throws -> [SpelledPitch] {
        guard nodeResource.allNodesHaveBeenRanked else { throw Error.cannotSpellNodes }
        return nodeResource.reduce([]) {
            guard let spelling = $1.1.first?.spelling else { return $0 }
            return $0 + SpelledPitch(pitch: $1.0, spelling: spelling)
        }
    }
    
    // TODO: refactor
    private func commitSpellingsFromComparisonStages() throws -> [SpelledPitch] {
        nodeResource.sortForRank()
        var spellingByPitch: [Pitch: Node] = [:]
        for comparisonStage in comparisonStages {
            switch comparisonStage {
            case let stage as DeterminateComparisonStage:
                spellingByPitch[stage.a.pitch] = stage.a
                spellingByPitch[stage.b.pitch] = stage.b
            case let stage as SemiAmbiguousComparisonStage:
                spellingByPitch[stage.other.pitch] = stage.other.highestRanked
                spellingByPitch[stage.determinate.pitch] = stage.determinate
            case let stage as FullyAmbiguousComparisonStage:
                guard let highestRanked = stage.highestRanked else { fatalError() }
                spellingByPitch[stage.a.pitch] = highestRanked.a
                spellingByPitch[stage.b.pitch] = highestRanked.b
            default: break
            }
        }
        return spellingByPitch.map { SpelledPitch(pitch: $0, spelling: $1.spelling) }
    }

    private func dyad(atIndex index: Int) -> Dyad? {
        guard let currentPitch = pitches[safe: index] else { return nil }
        guard let nextPitch = pitches[safe: index + 1] else { return nil }
        return Dyad(currentPitch, nextPitch)
    }
}
