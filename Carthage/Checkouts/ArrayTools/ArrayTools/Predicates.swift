//
//  Predicates.swift
//  ArrayTools
//
//  Created by James Bean on 5/27/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

extension SequenceType {
    
    // MARK: - Predicates
    
    /**
     - returns: `true` if all `Generator.Element` values in `self` fulfill given `predicate`.
     Otherwise, `false`.
     */
    public func allMatch(@noescape predicate: Generator.Element -> Bool) -> Bool {
        for element in self { if !predicate(element) { return false } }
        return true
    }
}