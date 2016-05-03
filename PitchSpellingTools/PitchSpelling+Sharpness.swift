//
//  PitchSpelling+Sharpness.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import Foundation

extension PitchSpelling {
    
    // MARK: - Sharpness
    
    private static let sharpnessByPitchSpelling: [PitchSpelling: Sharpness] = [
        PitchSpelling(.f, .flat): -7,
        PitchSpelling(.c, .flat): -6,
        PitchSpelling(.g, .flat): -5,
        PitchSpelling(.d, .flat): -4,
        PitchSpelling(.a, .flat): -3,
        PitchSpelling(.e, .flat): -2,
        PitchSpelling(.b, .flat): -1,
        PitchSpelling(.f, .sharp): 1,
        PitchSpelling(.c, .sharp): 2,
        PitchSpelling(.g, .sharp): 3,
        PitchSpelling(.d, .sharp): 4,
        PitchSpelling(.a, .sharp): 5,
        PitchSpelling(.e, .sharp): 6,
        PitchSpelling(.b, .sharp): 7
    ]
    
    /// Sharpness (distance from middle-c on circle of fifths)
    public var sharpness: Sharpness {
        return PitchSpelling.sharpnessByPitchSpelling[self.quantized(to: .halfStep)] ?? 0
    }
}
