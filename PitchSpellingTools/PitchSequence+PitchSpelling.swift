//
//  PitchSequence+PitchSpelling.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/5/16.
//
//

import Pitch

extension PitchSequence {
    
    /**
     - TODO: return SpelledPitchSequence structure
     - warning: Not yet implemented!
     */
    internal func spelled(
        withCoarseDirection coarseDirection: PitchSpelling.CoarseAdjustment.Direction
    ) -> [SpelledPitch]
    {
        return self.map { pitch in
            let spelling = pitch.spellingsWithoutUnconventionalEnharmonics.filter { spelling in
                spelling.isCompatible(withCoarseDirection: coarseDirection)
            }.first!
            return SpelledPitch(pitch: pitch, spelling: spelling)
        }
    }
}

