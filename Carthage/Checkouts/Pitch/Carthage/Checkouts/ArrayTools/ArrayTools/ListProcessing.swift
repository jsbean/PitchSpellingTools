//
//  ListProcessing.swift
//  ArrayTools
//
//  Created by James Bean on 2/22/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

extension Array {
    
    // MARK: - List Processing
    
    /// First `Element` of a list.
    public var head: Element? {
        return self.first
    }
    
    /// Remaining `Elements` of a list.
    public var tail: [Element]? {
        guard self.count > 0 else { return nil }
        return Array(self[1..<self.count])
    }
    
    /**
     2-tuple containing the `head` `Element` and `tail` `[Element]` of `Self`
     
     -  note: From Chris Eidhof: http://chris.eidhof.nl/posts/swift-tricks.html
     */
    public var destructured: (Element, [Element])? {
        guard let head = head, tail = tail else { return nil }
        return (head, tail)
    }
}

/**
Construct an `Array` from a `head` and a `tail`

- parameter head: First element of new `Array`
- parameter tail: Array of elements appended after head in new `Array`

- returns: New `Array` with the first element `head`, and the remaining elements of `tail`
*/
public func + <T>(head: T, tail: [T]) -> [T] {
    return [head] + tail
}

/**
Append an element

- parameter list: `Array` to append `item` to
- parameter item: Element to append to `list`

- returns: New `Array` with `item` appended to the end of `list`
*/
public func + <T>(list: [T], item: T) -> [T] {
    return list + [item]
}