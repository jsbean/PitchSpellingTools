//
//  IntervalClass.swift
//  Pitch
//
//  Created by James Bean on 3/13/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/// Modulo 12 representation of an `Interval` value.
public typealias IntervalClass = Float

public extension IntervalClass {

    /**
     Create an `IntervalClass` with an `Interval`
     */
    public init(_ interval: Interval) {
        self = interval % 12.0
    }
}