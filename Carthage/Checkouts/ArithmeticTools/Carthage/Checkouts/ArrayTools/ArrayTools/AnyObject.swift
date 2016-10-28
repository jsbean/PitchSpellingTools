//
//  AnyObject.swift
//  ArrayTools
//
//  Created by James Bean on 3/1/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

public extension Array where Element: AnyObject {
    
    // MARK: - Element: AnyObject
    
    /**
    - returns: `true` if `Array` contains `object`. Otherwise `nil`.
    */
    func contains(_ object: Element) -> Bool {
        return index(ofObject: object) != nil
    }
    
    /**
     - returns: Index of first instance of `object`, if present. Otherwise `nil`.
     */
    func index(ofObject object: Element) -> Int? {
        for (index, el) in self.enumerated() {
            if el === object {
                return index
            }
        }
        return nil
    }
    
    /**
     Remove `object` from `Array`.
     
     - throws: `ArrayError` if `object` is not in `Array`.
     */
    mutating func remove(_ object: Element) throws {
        guard let i = index(ofObject: object) else { throw ArrayError.removalError }
        self.remove(at: i)
    }
}
