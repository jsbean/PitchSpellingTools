//
//  Node.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Foundation

/**
 Node in a `Graph`, holding a `PitchSpelling` object for a `Pitch` within a `PitchSet`.
 
 - note: Consider factoring this out, unless it has a bigger payload than just a `PitchSpelling`
 */
internal final class Node {
    
    /// The `PitchSpelling` held by this `Node`.
    internal let spelling: PitchSpelling
    
    /**
     Create a `Node` with the given `spelling`.
     */
    internal init(spelling: PitchSpelling) {
        self.spelling = spelling
    }
}

extension Node: CustomStringConvertible {
    
    internal var description: String { return "\(spelling)" }
}
