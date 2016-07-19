//
//  SequenceType.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/16/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

extension SequenceType where Generator.Element: ArithmeticType {
    
    /**
     Sum of elements in Sequence.
     
     >`[1,2,4].sum -> 7`
    */
    public var sum: Generator.Element { return reduce(Generator.Element.zero, combine: +) }
    
    /**
     Greatest common divisor of elements in Sequence.
     
     >`[8,12].gcd -> 4`
    */
    public var gcd: Generator.Element? {
        guard let min = self.minElement() else { return nil }
        return self.map { greatestCommonDivisor(min, $0) }.minElement()
    }
}