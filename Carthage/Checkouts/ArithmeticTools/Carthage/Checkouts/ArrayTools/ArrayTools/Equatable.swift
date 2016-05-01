//
//  Equatable.swift
//  ArrayTools
//
//  Created by James Bean on 2/19/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    // MARK: Where Element: Equatable
    
    /**
    Get amount of a given `Element` in `Array`.
    
    >`[1,2,2,2,3,4,2].amountOf(2) -> 4`
    
    >`[1,2,3,4].amountOf(5) -> 0`
    
    - parameter element: `Element` for which to check amount.

    - returns: Amount of `Element` in `Array`
    */
    public func amount(of element: Element) -> Int {
        
        func amount(of element: Element, inArray array: [Element], accum: Int) -> Int {
            var accum = accum
            guard let (head, tail) = array.destructured else { return accum }
            if head == element { accum += 1 }
            return amount(of: element, inArray: tail, accum: accum)
        }
        
        return amount(of: element, inArray: self, accum: 0)
    }
    
    /**
    Extract all instances of `Element` in `Array`.
     
    >`[1,2,2,2,3,4].extractAllOf(2) -> ([2,2,2], [1,3,4])`

    - parameter element: Element to extract

    - returns: 2-tuple of extracted elements, and leftovers
    */
    public func extractAll(element: Element) -> ([Element], [Element]) {

        func remove(element: Element,
            fromArray array: [Element],
            leftovers: [Element],
            extracted: [Element]
        ) -> ([Element], [Element])
        {
            guard let (head, tail) = array.destructured else { return (extracted, leftovers) }
            let (l,e) = head == element
                ? (leftovers, extracted + head)
                : (leftovers + head, extracted)
            return remove(element, fromArray: tail, leftovers: l, extracted: e)
        }
        
        return remove(element, fromArray: self, leftovers: [], extracted: [])
    }
    
    /**
    Sort the contents of `Array` with the order of contents in another `Array`.
     
    >`["a","b","c","d].sortWithOrderOfContentsIn(["b","c","d"]) -> ["b","c","d","a"]`

    - parameter array: `Array` containing the desired order of `Elements`

    - returns: `Array` of `Elements` sorted with the desired order
    */
    public func sortWithOrderOfContentsIn(array: [Element]) -> [Element] {
        
        func appendMatchesOf(element: Element,
            fromArray array: [Element],
            toArray result: [Element]
        ) -> ([Element],[Element])
        {
            let (leftovers, matches) = array.extractAll(element)
            return (result + matches, leftovers)
        }
        
        func sortArray(array: [Element],
            withOrderOfContentsInArray reference: [Element],
            intoArray result: [Element]
        ) -> [Element]
        {
            guard let (head, tail) = reference.destructured else { return result + array }
            let (sorted, source) = appendMatchesOf(head, fromArray: array, toArray: result)
            return sortArray(source, withOrderOfContentsInArray: tail, intoArray: sorted)
        }
        
        return sortArray(self, withOrderOfContentsInArray: array, intoArray: [])
    }
    
    /**
    Create a 2-tuple containing duplicates extracted from `Array`, and the leftover `Elements`
     
    >`[1,2,2,2,3,4,4].extractDuplicates() -> ([2,2,4],[1,2,3,4])`

    - returns: (extracted duplicates, leftovers)
    */
    public func extractDuplicates() -> ([Element], [Element]) {
        
        func extractDuplicates(from array: [Element],
            duplicates: [Element],
            leftovers: [Element]
        ) -> ([Element], [Element])
        {
            guard let (head, tail) = array.destructured else { return (duplicates, leftovers) }
            let (d,l) = leftovers.contains(head)
                ? (duplicates + head, leftovers)
                : (duplicates, leftovers + head)
            return extractDuplicates(from: tail, duplicates: d, leftovers: l)
        }
        
        return extractDuplicates(from: self, duplicates: [], leftovers: [])
    }
    
    /**
     `Array` of `Elements` containing only single instances of any `Element`.
     
     >`[1,2,2,3,4,4].unique -> [1,2,3,4]`
     */
    public var unique: [Element] {
        
        func extractUniqueValues(from array: [Element], to result: [Element]) -> [Element]
        {
            guard let (head, tail) = array.destructured else { return result }
            let result = result.contains(head) ? result : result + head
            return extractUniqueValues(from: tail, to: result)
        }
        
        return extractUniqueValues(from: self, to: [])
    }
    
    /**
    Get index of `Element` in `Array`
     
    >`["c","a","t","s"].indexOf("t") -> 2`
     
    >`["c","a","t","s"].indexOf("k") -> nil`

    - parameter value: Value for index to be found

    - returns: Index of first instance of value, if present. Otherwise, `nil`.
    */
    public func index(of value: Element) -> Int? {
        for (index, el) in self.enumerate() { if el == value { return index } }
        return nil
    }
    
    /**
    Replace `Element` with new `Element`
     
    >`["a","c","g","t"].replace("g", withElement: "b") -> ["a","c","b","t"]`

    - parameter element:    `Element` to be replaced, if present in `Array`
    - parameter newElement: New `Element` to replace given `Element`
    */
    public mutating func replace(element: Element, withElement newElement: Element) {
        if let index = indexOf(element) {
            removeAtIndex(index)
            insert(element, atIndex: index)
        }
    }
}
