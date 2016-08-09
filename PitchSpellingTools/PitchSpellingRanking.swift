////
////  PitchSpellingRanking.swift
////  PitchSpellingTools
////
////  Created by James Bean on 5/27/16.
////
////
//
//import Foundation
//
///**
// Interface for types that rank `PitchSpellingNode` and `PitchSpellingEdge` objects.
// */
//public protocol PitchSpellingRanking: CustomStringConvertible {
//    
//    /**
//     Apply rankings with the given `amount` to the ranked element contained herein.
//     */
//    func applyRankings(withAmount amount: Float)
//}
//
//extension PitchSpellingRanking {
//    
//    // severity goes up furhter in the list
//    public var rules: [(PitchSpellingDyad) -> Bool] {
//        return [
//            { $0.hasValidIntervalQuality },
//            { $0.isFineCompatible }
//        ]
//    }
//}
