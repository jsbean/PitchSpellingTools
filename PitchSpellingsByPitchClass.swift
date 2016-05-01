//
//  PitchSpellingsByPitchClass.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/1/16.
//
//

import Foundation
import Pitch

public struct PitchSpellingResource {
    
    private typealias PitchSpellingComponents = (
        letterName: PitchSpelling.LetterName,
        coarse: PitchSpelling.CoarseAdjustment,
        fine: PitchSpelling.FineAdjustment
    )
    
    private let pitchSpellingComponentsByPitchClass: [PitchClass: [PitchSpellingComponents]] = [
        00.00: [
            (.C, .Natural, .None)
        ],
        00.25: [
            (.C, .Natural, .Up),
            (.C, .QuarterSharp, .Down)
        ]
    ]
    
    public subscript(pitchClass: PitchClass) -> [PitchSpelling] {
        
        guard let components = pitchSpellingComponentsByPitchClass[pitchClass] else {
            return []
        }
        
        return components.map {
            PitchSpelling(letterName: $0.letterName, coarse: $0.coarse, fine: $0.fine)
        }
    }
}
