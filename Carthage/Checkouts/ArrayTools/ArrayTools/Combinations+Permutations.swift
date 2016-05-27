//
//  Combinations+Permutations.swift
//  ArrayTools
//
//  Created by James Bean on 5/5/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 - returns: All combinations of elements of two arrays.
 */
public func combinations<T, U>(array1: [T], _ array2: [U]) -> [(T, U)] {
    return array1.reduce([]) { accum, t in accum + array2.map { u in (t,u) } }
}
