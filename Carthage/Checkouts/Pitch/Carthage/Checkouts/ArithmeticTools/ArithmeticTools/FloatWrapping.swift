//
//  FloatWrapping.swift
//  ArithmeticTools
//
//  Created by James Bean on 5/10/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public protocol FloatWrapping: FloatLiteralConvertible,
    IntegerLiteralConvertible,
    Hashable,
    Comparable
{
    associatedtype FloatLiteralType = Float
    associatedtype IntegerLiteralType = Int
    init(floatLiteral: Float)
    var value: Float { get set }
    init(integerLiteral: Int)
    init(_ float: Float)
}

extension FloatWrapping {
    
    public init(_ float: Float) {
        self.init(floatLiteral: float)
    }
}

// MARK: - Hashable
extension FloatWrapping {
    public var hashValue: Int { return value.hashValue }
}

// MARK: - Comparable
public func == <T: FloatWrapping>(lhs: T, rhs: T) -> Bool {
    return lhs.value == rhs.value
}

public func == <T: FloatWrapping>(lhs: T, rhs: Float) -> Bool {
    return lhs.value == rhs
}

public func == <T: FloatWrapping>(lhs: Float, rhs: T) -> Bool {
    return lhs == rhs.value
}

public func < <T: FloatWrapping>(lhs: T, rhs: T) -> Bool {
    return lhs.value < rhs.value
}

public func < <T: FloatWrapping>(lhs: T, rhs: Float) -> Bool {
    return lhs.value < rhs
}

public func < <T: FloatWrapping>(lhs: Float, rhs: T) -> Bool {
    return lhs < rhs.value
}

/*
// MARK: - ArithmeticType
extension FloatWrapping {
    public static var zero: Float { return 0 }
    public static var one: Float { return 1 }
    public static var two: Float { return 2 }
    
    public static var max: Float { return FLT_MAX }
    public static var min: Float { return FLT_MIN }
    
    public static func mod(dividend: Float, _ modulus: Float) -> Float {
        let result = dividend % modulus
        return result < 0 ? result + modulus : result
    }
    
    public static func abs(value: Float) -> Float {
        return value < 0 ? -value : value
    }
    
    public static func random(min min: Float = 0.0, max: Float = 1.0) -> Float {
        let range = max - min
        return ((Float(arc4random())) / Float(UINT32_MAX) * range) + min
    }
    
    public var isInteger: Bool { return value % 1 == 0 }
    public var isPrime: Bool { return isInteger ? Int(value).isPrime : false }
    public var isEven: Bool { return isInteger ? Int(value).isEven : false }
    public var isOdd: Bool { return isInteger ? Int(value).isOdd : false }
    public var isPowerOfTwo: Bool { return isInteger ? Int(value).isPowerOfTwo : false }
    
    public func isDivisible(by value: Float) -> Bool {
        guard isInteger else { return false }
        return Int(self.value).isDivisible(by: Int(value))
    }
    
    public func format(f: String) -> String { return String(format(f), self) }
}
*/

// MARK: - Arithmetic
public func + <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value + addend.value)
}

public func + <T: FloatWrapping>(augend: T, addend: T) -> Float {
    return augend.value + addend.value
}

public func + <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value + rhs
}

public func + <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs + rhs.value
}

public func - <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value - addend.value)
}

public func - <T: FloatWrapping>(minuend: T, subtrahend: T) -> Float {
    return minuend.value - subtrahend.value
}

public func - <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value - rhs
}

public func - <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs - rhs.value
}

public func * <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value * addend.value)
}

public func * <T: FloatWrapping>(multiplicand: T, multiplier: T) -> Float {
    return multiplicand.value * multiplier.value
}

public func * <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value * rhs
}

public func * <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs * rhs.value
}

public func / <T: FloatWrapping>(augend: T, addend: T) -> T {
    return T(floatLiteral: augend.value / addend.value)
}

public func / <T: FloatWrapping>(dividend: T, divisor: T) -> Float {
    return dividend.value * divisor.value
}

public func / <T: FloatWrapping>(lhs: T, rhs: Float) -> Float {
    return lhs.value / rhs
}

public func / <T: FloatWrapping>(lhs: Float, rhs: T) -> Float {
    return lhs / rhs.value
}
