//
//  ComparisonStage.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import Foundation

protocol ComparisonStage {
    
    var edges: [Edge] { mutating get }
    
    func rate(withWeight weight: Float)
}