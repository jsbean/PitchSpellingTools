//
//  Comparable.swift
//  ArrayTools
//
//  Created by James Bean on 6/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

// Modified from: https://airspeedvelocity.net/2016/01/10/writing-a-generic-stable-sort/

extension RangeReplaceableCollection where
    Index == Int,
    IndexDistance == Int,
    SubSequence.Iterator.Element == Iterator.Element
{
    public func stableSort(
        _ isOrderedBefore: @escaping (Iterator.Element, Iterator.Element) -> Bool
    ) -> [Iterator.Element]
    {
        var result = self // make copy of self to return
        let count = result.count
        
        var aux: [Iterator.Element] = []
        aux.reserveCapacity(numericCast(count))
        
        func merge(_ lo: Index, _ mid: Index, _ hi: Index) {
            
            aux.removeAll(keepingCapacity: true)
        
            var i = lo
            var j = mid
            
            while i < mid && j < hi {
                if isOrderedBefore(result[j], result[i]) {
                    aux.append(result[j])
                    j += 1
                }
                else {
                    aux.append(result[i])
                    i += 1
                }
            }
            
            aux.append(contentsOf: result[i ..< mid])
            aux.append(contentsOf: result[j ..< hi])
            result.replaceSubrange(lo ..< hi, with: aux)
        }
        
        var sz: Int = 1
        while sz < count {
            for lo in stride(from: result.startIndex, to: result.endIndex - sz, by: sz * 2) {
                merge(lo, lo + sz, (lo + (sz * 2)).limited(notToExceed: count))
            }
            sz *= 2
        }
        return Array(result)
    }
}

extension Int {
    func limited(notToExceed maximum: Int) -> Int {
        return self >= maximum ? maximum : self
    }
}
