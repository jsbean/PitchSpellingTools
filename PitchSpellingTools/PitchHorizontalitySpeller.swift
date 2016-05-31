//
//  PitchHorizontalitySpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/31/16.
//
//

import ArrayTools
import Pitch

public final class PitchHorizontalitySpeller: PitchSpeller {
    
    public enum Error: ErrorType {
        case Empty
    }
    
    let pitches: [Pitch]
    
    public init(pitches: [Pitch]) {
        self.pitches = pitches
    }
    
    /**
     - warning: Not yet implemented
     */
    public func spell() throws -> [SpelledPitch] {
        guard pitches.count > 0 else { throw Error.Empty }
        
        // window of unspelled pitches; for now, a single array, maybe abstract if needed
        var window: [Pitch] = []
        var spelledPitches: [SpelledPitch] = []
        var p = 0
        while p < pitches.count {
            let pitch = pitches[p]
            if pitch.canBeSpelledObjectively {
                // check window
                // use pitchSet speller to spell window?
                
                // right now
                if window.count > 0 {
                    let pitchSetSpeller = PitchSetSpeller(PitchSet(window + pitch))
                    let spelledPitchArray = (try pitchSetSpeller.spell()).map { $0 }
                    
                    // purge window
                    window = []
                }
                //spelledPitches.append(try pitch.spelledWithDefaultSpelling())
            } else {
                window.append(pitch)
            }
     
            p += 1
        }
        
        return spelledPitches
    }
    
    private func nextDyad(atIndex index: Int) -> Dyad? {
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