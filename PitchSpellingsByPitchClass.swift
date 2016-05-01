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
        ]
        
        /*
        "1.00": [
            {
                "letterName": "C", "coarse": "1.00", "fine": "0.00"
            },
            {
                "letterName": "D", "coarse": "-1.00", "fine": "0.00"
            }
        ],
        "1.25": [
            {
                "letterName": "C", "coarse": "1.00", "fine": "0.25"
            },
            {
                "letterName": "D", "coarse": "-1.00", "fine": "0.25"
            },
            {
                "letterName": "D", "coarse": "-.50", "fine": "-0.25"
            }
        ],
        "1.50": [
            {
                "letterName": "D", "coarse": "-0.50", "fine": "0.00"
            }
        ],
        "1.75": [
            {
                "letterName": "D", "coarse": "-0.50", "fine": "0.25"
            },
            {
                "letterName": "D", "coarse": "0.00", "fine": "-0.25"
            }
        ],
        "2.00": [
            {
                "letterName": "D", "coarse": "0.00", "fine": "0.00"
            }
        ],
        "2.25": [
            {
                "letterName": "D", "coarse": "0.00", "fine": "0.25"
            },
            {
                "letterName": "D", "coarse": "0.50", "fine": "-0.25"
            }
        ],
        "2.50": [
            {
                "letterName": "D", "coarse": "0.50", "fine": "0.00"
            }
        ],
        "2.75": [
            {
                "letterName": "D", "coarse": "0.50", "fine": "0.25"
            },
            {
                "letterName": "D", "coarse": "1.00", "fine": "-0.25"
            },
            {
                "letterName": "E", "coarse": "-1.00", "fine": "-0.25"
            }
        ],
        "3.00": [
            {
                "letterName": "D", "coarse": "1.00", "fine": "0.00"
            },
            {
                "letterName": "E", "coarse": "-1.00", "fine": "0.00"
            }
        ],
        "3.25": [
            {
                "letterName": "D", "coarse": "1.00", "fine": "0.25"
            },
            {
                "letterName": "E", "coarse": "-1.00", "fine": "0.25"
            },
            {
                "letterName": "E", "coarse": "-0.50", "fine": "-0.25"
            }
        ],
        "3.50": [
            {
                "letterName": "E", "coarse": "-0.50", "fine": "0.00"
            }
        ],
        "3.75": [
            {
                "letterName": "E", "coarse": "-0.5", "fine": "0.25"
            },
            {
                "letterName": "E", "coarse": "0.00", "fine": "-0.25"
            }
        ],
        "4.00": [
            {
                "letterName": "E", "coarse": "0.00", "fine": "0.00"
            }
        ],
        "4.25": [
            {
                "letterName": "E", "coarse": "0.00", "fine": "0.25"
            },
            {
                "letterName": "E", "coarse": "0.50", "fine": "-0.25"
            },
            {
                "letterName": "F", "coarse": "-0.50", "fine": "-0.25"
            }
        ],
        "4.50": [
            {
                "letterName": "E", "coarse": "0.50", "fine": "0.00"
            },
            {
                "letterName": "F", "coarse": "-0.50", "fine": "0.00"
            }
        ],
        "4.75": [
            {
                "letterName": "E", "coarse": "0.50", "fine": "0.25"
            },
            {
                "letterName": "F", "coarse": "-0.50", "fine": "0.25"
            },
            {
                "letterName": "F", "coarse": "0.00", "fine": "-0.25"
            }
        ],
        "5.00": [
            {
                "letterName": "F", "coarse": "0.00", "fine": "0.00"
            }
        ],
        "5.25": [
            {
                "letterName": "F", "coarse": "0.00", "fine": "0.25"
            },
            {
                "letterName": "F", "coarse": "0.50", "fine": "-0.25"
            }
        ],
        "5.50": [
            {
                "letterName": "F", "coarse": "0.50", "fine": "0.00"
            }
        ],
        "5.75": [
            {
                "letterName": "F", "coarse": "0.50", "fine": "0.25"
            },
            {
                "letterName": "F", "coarse": "1.00", "fine": "-0.25"
            },
            {
                "letterName": "G", "coarse": "-1.00", "fine": "-0.25"
            }
        ],
        "6.00": [
            {
                "letterName": "F", "coarse": "1.00", "fine": "0.00"
            },
            {
                "letterName": "G", "coarse": "-1.00", "fine": "0.00"
            }
        ],
        "6.25": [
            {
                "letterName": "F", "coarse": "1.00", "fine": "0.25"
            },
            {
                "letterName": "G", "coarse": "-1.00", "fine": "0.25"
            },
            {
                "letterName": "G", "coarse": "-0.50", "fine": "-0.25"
            }
        ],
        "6.50": [
            {
                "letterName": "G", "coarse": "0.50", "fine": "0.00"
            }
        ],
        "6.75": [
            {
                "letterName": "G", "coarse": "-0.50", "fine": "0.25"
            },
            {
                "letterName": "G", "coarse": "0.00", "fine": "-0.25"
            }
        ],
        "7.00": [
            {
                "letterName": "G", "coarse": "0.00", "fine": "0.00"
            },
        ],
        "7.25": [
            {
                "letterName": "G", "coarse": "0.00", "fine": "0.25"
            },
            {
                "letterName": "G", "coarse": "0.50", "fine": "-0.25"
            }
        ],
        "7.50": [
            {
                "letterName": "G", "coarse": "0.50", "fine": "0.00"
            }
        ],
        "7.75": [
            {
                "letterName": "G", "coarse": "0.50", "fine": "0.25"
            },
            {
                "letterName": "G", "coarse": "1.00", "fine": "-0.25"
            },
            {
                "letterName": "A", "coarse": "-1.00", "fine": "-0.25"
            }
        ],
        "8.00": [
            {
                "letterName": "G", "coarse": "1.00", "fine": "0.00"
            },
            {
                "letterName": "A", "coarse": "-1.00", "fine": "0.00"
            }
        ],
        "8.25": [
            {
                "letterName": "G", "coarse": "1.00", "fine": "0.25"
            },
            {
                "letterName": "A", "coarse": "-1.00", "fine": "0.25"
            },
            {
                "letterName": "A", "coarse": "-0.50", "fine": "-0.25"
            }
        ],
        "8.50": [
            {
                "letterName": "A", "coarse": "-0.50", "fine": "0.00"
            }
        ],
        "8.75": [
            {
                "letterName": "A", "coarse": "-0.50", "fine": "0.25"
            },
            {
                "letterName": "A", "coarse": "0.00", "fine": "-0.25"
            }
        ],
        "9.00": [
            {
                "letterName": "A", "coarse": "0.00", "fine": "0.00"
            }
        ],
        "9.25": [
            {
                "letterName": "A", "coarse": "0.00", "fine": "0.25"
            },
            {
                "letterName": "A", "coarse": "0.50", "fine": "-0.25"
            }
        ],
        "9.50": [
            {
                "letterName": "A", "coarse": "0.50", "fine": "0.00"
            }
        ],
        "9.75": [
            {
                "letterName": "A", "coarse": "0.50", "fine": "0.25"
            },
            {
                "letterName": "A", "coarse": "1.00", "fine": "-0.25"
            },
            {
                "letterName": "B", "coarse": "-1.00", "fine": "-0.25"
            }
        ],
        "10.00": [
            {
                "letterName": "A", "coarse": "1.00", "fine": "0.00"
            },
            {
                "letterName": "B", "coarse": "-1.00", "fine": "0.00"
            }
        ],
        "10.25": [
            {
                "letterName": "A", "coarse": "1.00", "fine": "0.25"
            },
            {
                "letterName": "B", "coarse": "-1.00", "fine": "0.25"
            },
            {
                "letterName": "B", "coarse": "-0.50", "fine": "-0.25"
            }
        ],
        "10.50": [
            {
                "letterName": "B", "coarse": "-0.50", "fine": "0.00"
            }
        ],
        "10.75": [
            {
                "letterName": "B", "coarse": "-0.50", "fine": "0.25"
            },
            {
                "letterName": "B", "coarse": "0.00", "fine": "-0.25"
            }
        ],
        "11.00": [
            {
                "letterName": "B", "coarse": "0.00", "fine": "0.00"
            }
        ],
        "11.25": [
            {
                "letterName": "B", "coarse": "0.00", "fine": "0.25"
            },
            {
                "letterName": "B", "coarse": "0.50", "fine": "-0.25"
            },
            {
                "letterName": "C", "coarse": "-0.50", "fine": "-0.25"
            }
        ],
        "11.50": [
            {
                "letterName": "B", "coarse": "0.50", "fine": "0.00"
            },
            {
                "letterName": "C", "coarse": "-0.50", "fine": "0.00"
            }
        ],
        "11.75": [
            {
                "letterName": "B", "coarse": "0.50", "fine": "0.25"
            },
            {
                "letterName": "C", "coarse": "-0.50", "fine": "0.25"
            },
            {
                "letterName": "C", "coarse": "0.00", "fine": "-0.25"
            }
        ]
         */
    ]
    
    public subscript(pitchClass: PitchClass) -> [PitchSpelling] {
        guard let components = componentsByPitchClass[pitchClass] else { return [] }
        return components.map {
            PitchSpelling(letterName: $0.letterName, coarse: $0.coarse, fine: $0.fine)
        }
    }
}
