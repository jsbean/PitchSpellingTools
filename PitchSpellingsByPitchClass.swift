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
    
    private let componentsByPitchClass: [PitchClass: [PitchSpellingComponents]] = [
        
        00.00: [
            (.C, .Natural, .None)
        ],
        
        00.25: [
            (.C, .Natural, .Up),
            (.C, .QuarterSharp, .Down)
        ],
        
        00.50: [
            (.C, .QuarterSharp, .None)
        ],
        
        00.75: [
            (.C, .QuarterSharp, .Up),
            (.C, .Sharp, .Down),
            (.D, .Flat, .Down)
        ],
        
        01.00: [
            (.C, .Sharp, .None),
            (.D, .Flat, .None)
        ],
        
        01.25: [
            (.C, .Sharp, .Up),
            (.D, .Flat, .Up),
            (.D, .QuarterFlat, .Down)
        ],
        
        01.50: [
            (.D, .QuarterSharp, .None)
        ],
        
        01.75: [
            (.D, .QuarterFlat, .Up),
            (.D, .Natural, .Down)
        ],
        
        02.00: [
            (.D, .Natural, .None)
        ],
        
        02.25: [
            (.D, .Natural, .Up),
            (.D, .QuarterSharp, .Down)
        ],
        
        02.50: [
            (.D, .QuarterSharp, .None)
        ],
        
        02.75: [
            (.D, .QuarterSharp, .Up),
            (.D, .Sharp, .Down),
            (.E, .Flat, .Down)
        ],
        
        03.00: [
            (.D, .Sharp, .None),
            (.E, .Flat, .None)
        ],
        
        03.25: [
            (.D, .Sharp, .Up),
            (.E, .Flat, .Up),
            (.E, .QuarterFlat, .Down)
        ],
        
        03.50: [
            (.E, .QuarterFlat, .None)
        ],
        
        03.75: [
            (.E, .QuarterFlat, .Up),
            (.E, .Natural, .Down)
        ],
        
        04.00: [
            (.E, .Natural, .None)
        ],
        
        04.25: [
            (.E, .Natural, .Up),
            (.E, .QuarterSharp, .Down),
            (.F, .QuarterFlat, .Down)
        ],
        
        04.50: [
            (.E, .QuarterSharp, .None),
            (.F, .QuarterFlat, .None)
        ],
        
        04.75: [
            (.E, .QuarterSharp, .Up),
            (.F, .QuarterFlat, .Up),
            (.F, .Natural, .Down)
        ],
        
        05.00: [
            (.F, .Natural, .None)
        ],
        
        05.25: [
            (.F, .Natural, .Up),
            (.F, .QuarterSharp, .Down)
        ],
        
        05.50: [
            (.F, .QuarterSharp, .None)
        ],
        
        05.75: [
            (.F, .QuarterSharp, .Up),
            (.F, .Sharp, .Down),
            (.G, .Flat, .Down)
        ],
        
        06.00: [
            (.F, .Sharp, .None),
            (.G, .Flat, .None)
        ],
        
        06.25: [
            (.F, .Sharp, .Up),
            (.G, .Flat, .Up),
            (.G, .QuarterFlat, .Down)
        ],
        
        06.50: [
            (.G, .QuarterFlat, .None)
        ],
        
        06.75: [
            (.G, .QuarterFlat, .Up),
            (.G, .Natural, .Down)
        ],
        
        07.00: [
            (.G, .Natural, .None)
        ],
        
        07.25: [
            (.G, .Natural, .Up),
            (.G, .QuarterSharp, .Down)
        ],
        
        07.50: [
            (.G, .QuarterSharp, .None)
        ],
        
        07.75: [
            (.G, .QuarterSharp, .Up),
            (.G, .Sharp, .Down),
            (.A, .Flat, .Down)
        ],
        
        08.00: [
            (.G, .Sharp, .None),
            (.A, .Flat, .None)
        ],
        
        08.25: [
            (.G, .Sharp, .Up),
            (.A, .Flat, .Up),
            (.A, .QuarterFlat, .Down)
        ],
        
        08.50: [
            (.A, .QuarterFlat, .None)
        ],
        
        08.75: [
            (.A, .QuarterFlat, .Up),
            (.A, .Natural, .Down)
        ],
        
        09.00: [
            (.A, .Natural, .None)
        ],
        
        09.25: [
            (.A, .Natural, .Up),
            (.A, .QuarterSharp, .Down)
        ],
        
        09.50: [
            (.A, .QuarterSharp, .None)
        ],
        
        09.75: [
            (.A, .QuarterSharp, .Up),
            (.A, .Sharp, .Down),
            (.B, .Flat, .Down)
        ],
        
        10.00: [
            (.A, .Sharp, .None),
            (.B, .Flat, .None)
        ],
        
        10.25: [
            (.A, .Sharp, .Up),
            (.B, .Flat, .Up),
            (.B, .QuarterFlat, .Down)
        ],
        
        10.50: [
            (.B, .QuarterFlat, .None)
        ],
        
        10.75: [
            (.B, .QuarterFlat, .Up),
            (.B, .Natural, .Down)
        ],
        
        11.00: [
            (.B, .Natural, .None)
        ],
        
        11.25: [
            (.B, .Natural, .Up),
            (.B, .QuarterSharp, .Down),
            (.C, .QuarterFlat, .Down)
        ],
        
        11.50: [
            (.B, .QuarterSharp, .None),
            (.C, .QuarterFlat, .None)
        ],
        
        11.75: [
            (.B, .QuarterSharp, .Up),
            (.C, .QuarterFlat, .Up),
            (.C, .Natural, .Down)
        ]
    ]
    
    public subscript(pitchClass: PitchClass) -> [PitchSpelling] {
        guard let components = componentsByPitchClass[pitchClass] else { return [] }
        return components.map {
            PitchSpelling(letterName: $0.letterName, coarse: $0.coarse, fine: $0.fine)
        }
    }
}
