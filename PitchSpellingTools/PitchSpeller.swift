////
////  PitchSpeller.swift
////  Pitch
////
////  Created by James Bean on 3/17/16.
////  Copyright © 2016 James Bean. All rights reserved.
////
//
//import ArrayTools
//import Pitch
//
///**
// Interface for structures that attempt to spell pitches.
// */
//public protocol PitchSpeller {
//    
//    /// The product of an attempted spelling
//    associatedtype Result
//    
//    /// Collection of `PitchSpellingNode` objects organized by `Pitch` values.
//    var nodeResource: PitchSpellingNodeResource { get }
//    
//    /**
//     All `PitchSpellingNode` objects contained in the `nodeResource`
//     - Note: consider removing this from this protocol, as it is really an internal 
//     helper interface
//    */
//    var nodes: [PitchSpellingNode] { get }
//    
//    /**
//     Commit the spellings
//     
//     - throws: `PitchSpelling.Error` if no `PitchSpelling` options are available.
//     
//     - returns: Spelled version of the input.
//     */
//    func spell() throws -> Result
//}
