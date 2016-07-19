//
//  Destructured.swift
//  StringTools
//
//  Created by James Bean on 5/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Breaking String into (head, tail)
    
    /**
     - returns: Tuple of the first, and remaining string values, if available. 
     Otherwise, `nil`.
     */
    public var destructured: (String, String)? {
        guard let head: String = self[0] else { return nil }
        guard let tail: String = self[1..<self.characters.count] else { return nil }
        return (head, tail)
    }
}
