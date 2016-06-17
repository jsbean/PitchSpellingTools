////
////  SpelledPitchSet.swift
////  PitchSpellingTools
////
////  Created by James Bean on 5/28/16.
////
////
//
//import Pitch
//
///**
// Unordered set of unique `SpelledPitch` values.
// */
//public struct SpelledPitchSet {
//    
//    private let pitches: Set<SpelledPitch>
//    
//    // MARK: - Initializers
//    
//    /**
//     Create a `SpelledPitchSet` with an array of `SpelledPitch` values.
//     */
//    public init<S: SequenceType where S.Generator.Element == SpelledPitch>(_ pitches: S) {
//        self.pitches = Set(pitches)
//    }
//    
//    /**
//     Create a `SpelledPitchSet` for a given `PitchSet` value.
//     
//     - throws: `PitchSpelling.Error` if the given `pitchSet` cannot be spelled with current technology.
//     */
//    public init(_ pitchSet: PitchSet) throws {
//        self = try PitchSetSpeller(pitchSet).spell()
//    }
//}
//
//extension SpelledPitchSet: SequenceType {
//    
//    // MARK: - SequenceType
//    
//    /// Generate `Pitches` for iteration.
//    public func generate() -> AnyGenerator<SpelledPitch> {
//        var generator = pitches.generate()
//        return AnyGenerator { return generator.next() }
//    }
//}
//
//extension SpelledPitchSet: Equatable { }
//
//public func == (lhs: SpelledPitchSet, rhs: SpelledPitchSet) -> Bool {
//    return lhs.pitches == rhs.pitches
//}