//
//  PitchSpellings.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/1/16.
//
//

import Pitch

internal struct PitchSpellings {
    
    private static let spellingsByPitchClass: [PitchClass: Set<PitchSpelling>] = [
        
        00.00: [
            PitchSpelling(.c, .natural, .none)
        ],
        
        00.25: [
            PitchSpelling(.c, .natural, .up),
            PitchSpelling(.c, .quarterSharp, .down)
        ],
        
        00.50: [
            PitchSpelling(.c, .quarterSharp, .none)
        ],
        
        00.75: [
            PitchSpelling(.c, .quarterSharp, .up),
            PitchSpelling(.c, .sharp, .down),
            PitchSpelling(.d, .flat, .down)
        ],
        
        01.00: [
            PitchSpelling(.c, .sharp, .none),
            PitchSpelling(.d, .flat, .none)
        ],
        
        01.25: [
            PitchSpelling(.c, .sharp, .up),
            PitchSpelling(.d, .flat, .up),
            PitchSpelling(.d, .quarterFlat, .down)
        ],
        
        01.50: [
            PitchSpelling(.d, .quarterSharp, .none)
        ],
        
        01.75: [
            PitchSpelling(.d, .quarterFlat, .up),
            PitchSpelling(.d, .natural, .down)
        ],
        
        02.00: [
            PitchSpelling(.d, .natural, .none)
        ],
        
        02.25: [
            PitchSpelling(.d, .natural, .up),
            PitchSpelling(.d, .quarterSharp, .down)
        ],
        
        02.50: [
            PitchSpelling(.d, .quarterSharp, .none)
        ],
        
        02.75: [
            PitchSpelling(.d, .quarterSharp, .up),
            PitchSpelling(.d, .sharp, .down),
            PitchSpelling(.e, .flat, .down)
        ],
        
        03.00: [
            PitchSpelling(.d, .sharp, .none),
            PitchSpelling(.e, .flat, .none)
        ],
        
        03.25: [
            PitchSpelling(.d, .sharp, .up),
            PitchSpelling(.e, .flat, .up),
            PitchSpelling(.e, .quarterFlat, .down)
        ],
        
        03.50: [
            PitchSpelling(.e, .quarterFlat, .none)
        ],
        
        03.75: [
            PitchSpelling(.e, .quarterFlat, .up),
            PitchSpelling(.e, .natural, .down)
        ],
        
        04.00: [
            PitchSpelling(.e, .natural, .none)
        ],
        
        04.25: [
            PitchSpelling(.e, .natural, .up),
            PitchSpelling(.e, .quarterSharp, .down),
            PitchSpelling(.f, .quarterFlat, .down)
        ],
        
        04.50: [
            PitchSpelling(.e, .quarterSharp, .none),
            PitchSpelling(.f, .quarterFlat, .none)
        ],
        
        04.75: [
            PitchSpelling(.e, .quarterSharp, .up),
            PitchSpelling(.f, .quarterFlat, .up),
            PitchSpelling(.f, .natural, .down)
        ],
        
        05.00: [
            PitchSpelling(.f, .natural, .none)
        ],
        
        05.25: [
            PitchSpelling(.f, .natural, .up),
            PitchSpelling(.f, .quarterSharp, .down)
        ],
        
        05.50: [
            PitchSpelling(.f, .quarterSharp, .none)
        ],
        
        05.75: [
            PitchSpelling(.f, .quarterSharp, .up),
            PitchSpelling(.f, .sharp, .down),
            PitchSpelling(.g, .flat, .down)
        ],
        
        06.00: [
            PitchSpelling(.f, .sharp, .none),
            PitchSpelling(.g, .flat, .none)
        ],
        
        06.25: [
            PitchSpelling(.f, .sharp, .up),
            PitchSpelling(.g, .flat, .up),
            PitchSpelling(.g, .quarterFlat, .down)
        ],
        
        06.50: [
            PitchSpelling(.g, .quarterFlat, .none)
        ],
        
        06.75: [
            PitchSpelling(.g, .quarterFlat, .up),
            PitchSpelling(.g, .natural, .down)
        ],
        
        07.00: [
            PitchSpelling(.g, .natural, .none)
        ],
        
        07.25: [
            PitchSpelling(.g, .natural, .up),
            PitchSpelling(.g, .quarterSharp, .down)
        ],
        
        07.50: [
            PitchSpelling(.g, .quarterSharp, .none)
        ],
        
        07.75: [
            PitchSpelling(.g, .quarterSharp, .up),
            PitchSpelling(.g, .sharp, .down),
            PitchSpelling(.a, .flat, .down)
        ],
        
        08.00: [
            PitchSpelling(.g, .sharp, .none),
            PitchSpelling(.a, .flat, .none)
        ],
        
        08.25: [
            PitchSpelling(.g, .sharp, .up),
            PitchSpelling(.a, .flat, .up),
            PitchSpelling(.a, .quarterFlat, .down)
        ],
        
        08.50: [
            PitchSpelling(.a, .quarterFlat, .none)
        ],
        
        08.75: [
            PitchSpelling(.a, .quarterFlat, .up),
            PitchSpelling(.a, .natural, .down)
        ],
        
        09.00: [
            PitchSpelling(.a, .natural, .none)
        ],
        
        09.25: [
            PitchSpelling(.a, .natural, .up),
            PitchSpelling(.a, .quarterSharp, .down)
        ],
        
        09.50: [
            PitchSpelling(.a, .quarterSharp, .none)
        ],
        
        09.75: [
            PitchSpelling(.a, .quarterSharp, .up),
            PitchSpelling(.a, .sharp, .down),
            PitchSpelling(.b, .flat, .down)
        ],
        
        10.00: [
            PitchSpelling(.a, .sharp, .none),
            PitchSpelling(.b, .flat, .none)
        ],
        
        10.25: [
            PitchSpelling(.a, .sharp, .up),
            PitchSpelling(.b, .flat, .up),
            PitchSpelling(.b, .quarterFlat, .down)
        ],
        
        10.50: [
            PitchSpelling(.b, .quarterFlat, .none)
        ],
        
        10.75: [
            PitchSpelling(.b, .quarterFlat, .up),
            PitchSpelling(.b, .natural, .down)
        ],
        
        11.00: [
            PitchSpelling(.b, .natural, .none)
        ],
        
        11.25: [
            PitchSpelling(.b, .natural, .up),
            PitchSpelling(.b, .quarterSharp, .down),
            PitchSpelling(.c, .quarterFlat, .down)
        ],
        
        11.50: [
            PitchSpelling(.b, .quarterSharp, .none),
            PitchSpelling(.c, .quarterFlat, .none)
        ],
        
        11.75: [
            PitchSpelling(.b, .quarterSharp, .up),
            PitchSpelling(.c, .quarterFlat, .up),
            PitchSpelling(.c, .natural, .down)
        ]
    ]
    
    internal static func spellings(forPitchClass pitchClass: PitchClass)
        -> Set<PitchSpelling>?
    {
        return PitchSpellings.spellingsByPitchClass[pitchClass]
    }
    
    internal static func defaultSpelling(forPitchClass pitchClass: PitchClass)
        -> PitchSpelling?
    {
        return spellings(forPitchClass: pitchClass)?.first
    }
}
