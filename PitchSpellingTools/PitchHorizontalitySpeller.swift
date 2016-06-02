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
    
    enum Error: ErrorType { case Empty }
    
    private lazy var nodeResource: NodeResource = {
        NodeResource(pitches: self.pitches)
    }()
    
    /// Factory that creates `ComparisonStage` objects applicable for this `PitchSet`
    private lazy var comparisonStageFactory: ComparisonStageFactory = {
        ComparisonStageFactory(nodeResource: self.nodeResource)
    }()
    
    private var comparisonStages: [ComparisonStage] = []
    
    let pitches: [Pitch]
    
    init(pitches: [Pitch]) {
        self.pitches = pitches
    }
    
    /**
     - warning: Not yet implemented
     */
    func spell() throws -> [SpelledPitch] {
        guard pitches.count > 0 else { throw Error.Empty }
        
        if pitches.count == 1 {
            return try pitches.map { try $0.spelledWithDefaultSpelling() }
        }
        
        for index in 0 ..< pitches.count - 1 {
            guard let current = currentDyad(atIndex: index) else { break }
            let comparisonStage = createComparisonStage(for: current)
            comparisonStage.applyRankings(withWeight: 1)
        }
        
        for comparisonStage in comparisonStages {
            print(comparisonStage)
        }

//        
//        // window of unspelled pitches; for now, a single array, maybe abstract if needed
//        var window: [Pitch] = []
//        var spelledPitches: [SpelledPitch] = []
//        var p = 0
//        while p < pitches.count {
//            let pitch = pitches[p]
//            if pitch.canBeSpelledObjectively {
//                // check window
//                // use pitchSet speller to spell window?
//                
//                // right now
//                if window.count > 0 {
//                    let pitchSetSpeller = PitchSetSpeller(PitchSet(window + pitch))
//                    let spelledPitchArray = (try pitchSetSpeller.spell()).map { $0 }
//                    
//                    // purge window
//                    window = []
//                }
//                //spelledPitches.append(try pitch.spelledWithDefaultSpelling())
//            } else {
//                window.append(pitch)
//            }
//     
//            p += 1
//        }
//        
//        return spelledPitches
        return []
    }
    
    /**
     
     */
    private func createComparisonStage(for dyad: Dyad) -> ComparisonStage {
        let comparisonStage = comparisonStageFactory.makeComparisonStage(for: dyad)
        comparisonStages.append(comparisonStage)
        return comparisonStage
    }
    
    private func currentDyad(atIndex index: Int) -> Dyad? {
        guard let currentPitch = pitches[safe: index] else { return nil }
        guard let nextPitch = pitches[safe: index + 1] else { return nil }
        return Dyad(currentPitch, nextPitch)
    }
    
    private func previousDyad(atIndex index: Int) -> Dyad? {
        guard let currentPitch = pitches[safe: index] else { return nil }
        guard let previousPitch = pitches[safe: index - 1] else { return nil }
        return Dyad(currentPitch, previousPitch)
    }
}