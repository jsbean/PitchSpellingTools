//
//  PitchSequenceType.swift
//  Pitch
//
//  Created by James Bean on 6/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools

public protocol PitchSequenceType: AnySequenceType {
    
    var sequence: AnySequence<Pitch> { get }
    
    /// - returns `true` if there are no `Pitch` values contained herein. Otherwise, `false`.
    var isEmpty: Bool { get }
    
    /// - returns `true` if there is a single `Pitch` value contained herein. Otherwise `false`.
    var isMonadic: Bool { get }
}

extension PitchSequenceType {
    
    public typealias Element = Pitch
}

