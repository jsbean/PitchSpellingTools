//
//  PitchSequenceSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/31/16.
//
//

import ArrayTools
import Pitch

public final class PitchSequenceSpeller: PitchSpeller {
    
//    let sequence: PitchConvertibleContainingSequence<PitchSet>
//    
//    public init(sequence: PitchConvertibleContainingSequence<PitchSet>) {
//        self.sequence = sequence
//    }

    // make richer model later
    
    public var nodes: [PitchSpellingNode] { return [] }
    
    internal lazy var nodeResource: PitchSpellingNodeResource = {
        PitchSpellingNodeResource(sequence: [])
    }()
    
    let sets: [PitchSet]
    
    init(sets: [PitchSet]) {
        self.sets = sets
    }
    
    /**
      - TODO: Returns SpelledPitchSetSequence
     */
    func spell() throws -> [SpelledPitchSet] { fatalError() }
    
    func applyRankings() {
        
        // first, manage nodes
        // create master node resource
        

        // create node resource
        let resource = PitchSpellingNodeResource(pitches: PitchSet(sets))
         
        // make throw if resource is nil
        let individualSpellers = sets.map {
            PitchSetSpeller($0, nodeResource: resource[$0]!)
        }
        individualSpellers.forEach {
            $0.applyRankings()
        }
        
//        print("resource after initial ranking: \(resource)")
//        
//        let joinedAdjacentSpellers = sets.adjacentPairs!.map { (first, second) in
//            PitchSetSpeller(PitchSet(first.set.union(second)))
//            
//        }
    }
    
    // TEMP
    private func rankWeight(for position: Int) -> Float {
        return (Float(sets.count - position) / Float(sets.count)) / 2
    }

//    
//    enum Error: ErrorType { case notAllNodesRanked }
//    
//    /// Collection of references to `PitchSpellingNode` objects for each `Pitch`.
//    private lazy var nodeResource: PitchSpellingNodeResource = {
//        PitchSpellingNodeResource(pitches: self.pitchSequence)
//    }()
//    
//    /// Factory that creates `PitchSpellingRanking` objects applicable for this `PitchSet`
//    private lazy var comparisonStageFactory: PitchSpellingRankerFactory = {
//        PitchSpellingRankerFactory(nodeResource: self.nodeResource)
//    }()
//    
//    private var pitchSequenceIsObjectivelySpellableOrMonadic: Bool {
//        return pitchSequence.allMatch({ $0.canBeSpelledObjectively }) || pitchSequence.isMonadic
//    }
//
//    private var comparisonStages: [PitchSpellingRanking] = []
//    
//    let pitchSequence: PitchSequence
//
//    /**
//     Create a `PitchSequenceSpeller` with an array of `Pitch` values.
//     */
//    init(pitchSequence: PitchSequence) {
//        self.pitchSequence = pitchSequence
//    }
//    
//    /**
//     - throws: `PitchSpelling.Error` if improper spelling is attempted.
//     
//     - returns: Array of `SpelledPitch` values.
//     
//     - TODO: Change return value to be `SpelledPitchSet`.
//     */
//    func spell() throws -> [SpelledPitch] {
//        
//        if pitchSequence.isEmpty { return [] }
//        
//        return pitchSequenceIsObjectivelySpellableOrMonadic
//            ? try spelledPitchSequenceWithDefaultSpellings()
//            : try spelledPitchSequenceByCreatingComparisonStages()
//    }
//    
//    private func spelledPitchSequenceWithDefaultSpellings() throws -> [SpelledPitch] {
//        return try pitchSequence.map { try $0.spelledWithDefaultSpelling() }
//    }
//    
//    private func spelledPitchSequenceByCreatingComparisonStages() throws -> [SpelledPitch] {
//        createComparisonStages()
//        return nodeResource.allNodesHaveBeenRanked
//            ? try commitRankedSpellings()
//            : try commitSpellingsFromComparisonStages()
//    }
//    
//    private func createComparisonStages() {
//        for index in 0 ..< pitchSequence.count - 1 {
//            guard let currentDyad = dyad(atIndex: index) else { break }
//            let comparisonStage = createComparisonStage(for: currentDyad)
//            comparisonStage.applyRankings(withWeight: rankWeight(for: index))
//        }
//    }
//    
//    private func createComparisonStage(for dyad: Dyad) -> PitchSpellingRanking {
//        let comparisonStage = comparisonStageFactory.makeRanker(for: dyad)
//        comparisonStages.append(comparisonStage)
//        return comparisonStage
//    }
//    
//    private func rankWeight(for position: Int) -> Float {
//        return (Float(position) + 1 / Float(pitchSequence.count)) / 2
//    }
//    
//    private func commitRankedSpellings() throws -> [SpelledPitch] {
//        if comparisonStages.allMatch (
//            { $0 is DeterminatePitchSpellingRanker || $0 is SemiAmbiguousPitchSpellingRanker }
//        )
//        {
//            guard nodeResource.allNodesHaveBeenRanked else { throw Error.notAllNodesRanked }
//            nodeResource.sortByRank()
//            return nodeResource.reduce([]) { array, nodesByPitch in
//                guard let spelling = nodesByPitch.1.first?.spelling else { return array }
//                return array + SpelledPitch(pitch: nodesByPitch.0, spelling: spelling)
//            }
//        }
//        
//        for comparisonStage in comparisonStages
//            where comparisonStage is FullyAmbiguousPitchSpellingRanker
//        {
//            //print(comparisonStage)
//        }
//        
//        return []
//    }
//    
//    // TODO: refactor
//    // Currently, the previous pitch spelling is just overriden by the current
//    // - as opposed to making a rank comparison
//    private func commitSpellingsFromComparisonStages() throws -> [SpelledPitch] {
//        //print("commit spellings from comparison stages")
//        nodeResource.sortByRank()
//        var spellingByPitch: [Pitch: PitchSpellingNode] = [:]
//        for comparisonStage in comparisonStages {
//            //print(comparisonStage)
//            switch comparisonStage {
//            case let stage as DeterminatePitchSpellingRanker:
//                spellingByPitch[stage.a.pitch] = stage.a
//                spellingByPitch[stage.b.pitch] = stage.b
//            case let stage as SemiAmbiguousPitchSpellingRanker:
//                spellingByPitch[stage.other.pitch] = stage.other.highestRanked
//                spellingByPitch[stage.determinate.pitch] = stage.determinate
//            case let stage as FullyAmbiguousPitchSpellingRanker:
//                // get the highest ranked edge
//                guard let highestRanked = stage.highestRanked else { fatalError() }
//                spellingByPitch[stage.a.pitch] = highestRanked.a
//                spellingByPitch[stage.b.pitch] = highestRanked.b
//            default: break
//            }
//        }
//        return spellingByPitch.map { SpelledPitch(pitch: $0, spelling: $1.spelling) }
//    }
//
//    private func dyad(atIndex index: Int) -> Dyad? {
//        guard let currentPitch = Array(pitchSequence)[safe: index] else { return nil }
//        guard let nextPitch = Array(pitchSequence)[safe: index + 1] else { return nil }
//        return Dyad(currentPitch, nextPitch)
//    }
}
