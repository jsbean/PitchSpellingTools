//
//  PitchSpellings.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/1/16.
//
//

import Foundation
import Pitch

internal struct PitchSpellings {
    
    private typealias PitchSpellingComponents = (
        letterName: PitchSpelling.LetterName,
        coarse: PitchSpelling.CoarseAdjustment,
        fine: PitchSpelling.FineAdjustment
    )
    
    private static let spellingsByPitchClass: [PitchClass: [PitchSpelling]] = [
        
        00.00: [
            PitchSpelling(.C, .Natural, .None)
        ],
        
        00.25: [
            PitchSpelling(.C, .Natural, .Up),
            PitchSpelling(.C, .QuarterSharp, .Down)
        ],
        
        00.50: [
            PitchSpelling(.C, .QuarterSharp, .None)
        ],
        
        00.75: [
            PitchSpelling(.C, .QuarterSharp, .Up),
            PitchSpelling(.C, .Sharp, .Down),
            PitchSpelling(.D, .Flat, .Down)
        ],
        
        01.00: [
            PitchSpelling(.C, .Sharp, .None),
            PitchSpelling(.D, .Flat, .None)
        ],
        
        01.25: [
            PitchSpelling(.C, .Sharp, .Up),
            PitchSpelling(.D, .Flat, .Up),
            PitchSpelling(.D, .QuarterFlat, .Down)
        ],
        
        01.50: [
            PitchSpelling(.D, .QuarterSharp, .None)
        ],
        
        01.75: [
            PitchSpelling(.D, .QuarterFlat, .Up),
            PitchSpelling(.D, .Natural, .Down)
        ],
        
        02.00: [
            PitchSpelling(.D, .Natural, .None)
        ],
        
        02.25: [
            PitchSpelling(.D, .Natural, .Up),
            PitchSpelling(.D, .QuarterSharp, .Down)
        ],
        
        02.50: [
            PitchSpelling(.D, .QuarterSharp, .None)
        ],
        
        02.75: [
            PitchSpelling(.D, .QuarterSharp, .Up),
            PitchSpelling(.D, .Sharp, .Down),
            PitchSpelling(.E, .Flat, .Down)
        ],
        
        03.00: [
            PitchSpelling(.D, .Sharp, .None),
            PitchSpelling(.E, .Flat, .None)
        ],
        
        03.25: [
            PitchSpelling(.D, .Sharp, .Up),
            PitchSpelling(.E, .Flat, .Up),
            PitchSpelling(.E, .QuarterFlat, .Down)
        ],
        
        03.50: [
            PitchSpelling(.E, .QuarterFlat, .None)
        ],
        
        03.75: [
            PitchSpelling(.E, .QuarterFlat, .Up),
            PitchSpelling(.E, .Natural, .Down)
        ],
        
        04.00: [
            PitchSpelling(.E, .Natural, .None)
        ],
        
        04.25: [
            PitchSpelling(.E, .Natural, .Up),
            PitchSpelling(.E, .QuarterSharp, .Down),
            PitchSpelling(.F, .QuarterFlat, .Down)
        ],
        
        04.50: [
            PitchSpelling(.E, .QuarterSharp, .None),
            PitchSpelling(.F, .QuarterFlat, .None)
        ],
        
        04.75: [
            PitchSpelling(.E, .QuarterSharp, .Up),
            PitchSpelling(.F, .QuarterFlat, .Up),
            PitchSpelling(.F, .Natural, .Down)
        ],
        
        05.00: [
            PitchSpelling(.F, .Natural, .None)
        ],
        
        05.25: [
            PitchSpelling(.F, .Natural, .Up),
            PitchSpelling(.F, .QuarterSharp, .Down)
        ],
        
        05.50: [
            PitchSpelling(.F, .QuarterSharp, .None)
        ],
        
        05.75: [
            PitchSpelling(.F, .QuarterSharp, .Up),
            PitchSpelling(.F, .Sharp, .Down),
            PitchSpelling(.G, .Flat, .Down)
        ],
        
        06.00: [
            PitchSpelling(.F, .Sharp, .None),
            PitchSpelling(.G, .Flat, .None)
        ],
        
        06.25: [
            PitchSpelling(.F, .Sharp, .Up),
            PitchSpelling(.G, .Flat, .Up),
            PitchSpelling(.G, .QuarterFlat, .Down)
        ],
        
        06.50: [
            PitchSpelling(.G, .QuarterFlat, .None)
        ],
        
        06.75: [
            PitchSpelling(.G, .QuarterFlat, .Up),
            PitchSpelling(.G, .Natural, .Down)
        ],
        
        07.00: [
            PitchSpelling(.G, .Natural, .None)
        ],
        
        07.25: [
            PitchSpelling(.G, .Natural, .Up),
            PitchSpelling(.G, .QuarterSharp, .Down)
        ],
        
        07.50: [
            PitchSpelling(.G, .QuarterSharp, .None)
        ],
        
        07.75: [
            PitchSpelling(.G, .QuarterSharp, .Up),
            PitchSpelling(.G, .Sharp, .Down),
            PitchSpelling(.A, .Flat, .Down)
        ],
        
        08.00: [
            PitchSpelling(.G, .Sharp, .None),
            PitchSpelling(.A, .Flat, .None)
        ],
        
        08.25: [
            PitchSpelling(.G, .Sharp, .Up),
            PitchSpelling(.A, .Flat, .Up),
            PitchSpelling(.A, .QuarterFlat, .Down)
        ],
        
        08.50: [
            PitchSpelling(.A, .QuarterFlat, .None)
        ],
        
        08.75: [
            PitchSpelling(.A, .QuarterFlat, .Up),
            PitchSpelling(.A, .Natural, .Down)
        ],
        
        09.00: [
            PitchSpelling(.A, .Natural, .None)
        ],
        
        09.25: [
            PitchSpelling(.A, .Natural, .Up),
            PitchSpelling(.A, .QuarterSharp, .Down)
        ],
        
        09.50: [
            PitchSpelling(.A, .QuarterSharp, .None)
        ],
        
        09.75: [
            PitchSpelling(.A, .QuarterSharp, .Up),
            PitchSpelling(.A, .Sharp, .Down),
            PitchSpelling(.B, .Flat, .Down)
        ],
        
        10.00: [
            PitchSpelling(.A, .Sharp, .None),
            PitchSpelling(.B, .Flat, .None)
        ],
        
        10.25: [
            PitchSpelling(.A, .Sharp, .Up),
            PitchSpelling(.B, .Flat, .Up),
            PitchSpelling(.B, .QuarterFlat, .Down)
        ],
        
        10.50: [
            PitchSpelling(.B, .QuarterFlat, .None)
        ],
        
        10.75: [
            PitchSpelling(.B, .QuarterFlat, .Up),
            PitchSpelling(.B, .Natural, .Down)
        ],
        
        11.00: [
            PitchSpelling(.B, .Natural, .None)
        ],
        
        11.25: [
            PitchSpelling(.B, .Natural, .Up),
            PitchSpelling(.B, .QuarterSharp, .Down),
            PitchSpelling(.C, .QuarterFlat, .Down)
        ],
        
        11.50: [
            PitchSpelling(.B, .QuarterSharp, .None),
            PitchSpelling(.C, .QuarterFlat, .None)
        ],
        
        11.75: [
            PitchSpelling(.B, .QuarterSharp, .Up),
            PitchSpelling(.C, .QuarterFlat, .Up),
            PitchSpelling(.C, .Natural, .Down)
        ]
    ]
    
    internal static func spellings(forPitchClass pitchClass: PitchClass) -> [PitchSpelling]? {
        return PitchSpellings.spellingsByPitchClass[pitchClass]
    }
    
    internal static func defaultSpelling(forPitchClass pitchClass: PitchClass)
        -> PitchSpelling?
    {
        return spellings(forPitchClass: pitchClass)?.first
    }
}
