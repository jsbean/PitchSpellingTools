//
//  PowerGenerator.swift
//  ArithmeticTools
//
//  Created by James Bean on 3/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/// Power-of-two Generator
internal class PowerGenerator<T: ArithmeticType>: GeneratorType {
    
    // MARK: - Associated Types
    
    /// This GeneratorType generates ArithmeticType values
    internal typealias Element = T
    
    private let doOvershoot: Bool
    private var hasOvershot: Bool = false
    
    private var power: T
    private var coefficient: T
    private var max: T?
    
    // MARK: - Initializers
    
    /**
     Create a PowerGenerator.
     
     - parameter coefficient: Coefficient that multiplies base of exponential expression
     - parameter max:         Maximum value of generated powers-of-two
     - parameter doOvershoot: If generator includes the next power-of-two greater than max
     
     - returns: Initialized PowerGenerator
     */
    internal init(coefficient: T, max: T? = nil, doOvershoot: Bool = false) {
        self.power = coefficient
        self.coefficient = coefficient
        self.max = max
        self.doOvershoot = doOvershoot
    }
    
    // MARK: - Instance Methods

    /// Advance to the next element and return it, or nil if no next element exists.
    internal func next() -> Element? {
        if doOvershoot {
            if hasOvershot { return nil }
            if power > max {
                hasOvershot = true
                return power
            }
        }
        let result = power
        power = power * T.two
        if let max = max { return result <= max ? result : nil }
        return result
    }
}