//
//  Functions.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/16/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

// TODO: Make `quadratic` generic over `FloatingPoint` type, when possible (Swift 3.1 / 4)

/// - returns: A `Set` of either 0, 1, or 2 x-intercepts for the given coefficients.
public func quadratic (_ a: Float, _ b: Float, _ c: Float) -> Set<Float> {
    
    let discriminant = pow(b,2) - 4 * a * c
    
    guard discriminant > 0 else {
        return Set()
    }
    
    return Set(
        [1,-1].map { sign in (-b + sign * sqrt(discriminant)) / (2 * a) }
    )
}

/// - returns: A `Set` of either 0, 1, or 2 x-intercepts for the given coefficients.
public func quadratic (_ a: Double, _ b: Double, _ c: Double) -> Set<Double> {
    
    let discriminant = pow(b,2) - 4 * a * c
    
    guard discriminant > 0 else {
        return Set()
    }
    
    return Set(
        [1,-1].map { sign in (-b + sign * sqrt(discriminant)) / (2 * a) }
    )
}


/// - returns: Greatest common divisor of a and b
public func gcd <I: Integer> (_ a: I, _ b: I) -> I {
    let result = a % b
    return result == 0 ? b : gcd(b, result)
}

/**
 Get the closer of two values to a target value.
 
 >`closer(to: 11, a: 12, b: 3) -> 12`
 
 - note: If the distances between both values and the target value are equivalent, the first
 value (a) is returned.
 
 >`closer(to: 6, a: 4, b: 8) -> 4`

 - returns: Value closer to target value
 */
public func closer <T: SignedNumber> (to target: T, a: T, b: T) -> T {
    return abs(a - target) <= abs(b - target) ? a : b
}

/**
 - note: If both values are equal, they are returned in the order in which they were given
 
 - returns: 2-tuple of two `Comparable` types, in order.
 */
public func ordered <T: Comparable> (_ a: T, _ b: T) -> (T, T) {
    return a <= b ? (a,b) : (b,a)
}

/// - returns: The average to the two given values.
public func mean <F: FloatingPoint> (_ a: F, _ b: F) -> F {
    return (a + b) / 2
}
