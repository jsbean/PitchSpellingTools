//
//  FullyAmbiguousComparisonStage.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import Foundation

/**
 Compares all of the potential spellings of two `Pitch` objects that cannot be spelled
 objectively, i.e., not `natural` for purpose of ranking.
 
 This structure ranks the relationships between potential `PitchSpelling` options, whereas
 the `SemiAmbiguousComparisonStage` ranks individual nodes.
 
     -----
    | o o | = a
     -----
     | X |  = edges
     -----
    | o o | = b
     -----
 */
final class FullyAmbiguousComparisonStage: ComparisonStage {
    
    let a: Level
    let b: Level
    
    lazy var edges: [Edge] = {
        var result: [Edge] = []
        for nodeA in self.a.nodes {
            for nodeB in self.b.nodes { result.append(Edge(nodeA, nodeB)) } 
        }
        return result
    }()
    
    init(_ a: Level, _ b: Level) {
        self.a = a
        self.b = b
    }
    
    func rate(withWeight weight: Float) {
        for edge in edges {
            
        }
    }
}