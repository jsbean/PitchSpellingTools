//
//  PitchSpellingDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import ArithmeticTools

/**
 Pair of two `PitchSpelling` objects.
 
 - TODO: Consider transfering concerns to `SpelledDyad`.
 */
public struct PitchSpellingDyad {

    internal let a: PitchSpelling
    internal let b: PitchSpelling

    // MARK: - Instance Properties
    
    /**
    `true` if `quarterStep` values of both `PitchSpelling` objects are equivalent.
     Otherwise `false`.
     */
    public var isCoarseMatching: Bool {
        return b.quarterStep == a.quarterStep
    }
    
    /**
     `true` if `quarterStep.direction` value of either `PitchSpelling` is `natural` or if
     `isCoarseCoarseCompatible`. Otherwise `false`.
     */
    public var isCoarseCompatible: Bool {
        return eitherIsNatural || isCoarseMatching
    }
    
    /**
    `true` if `quarterStep.direction` values of both `PitchSpelling` values are equivalent.
     Otherwise `false`.
     */
    public var isCoarseDirectionMatching: Bool {
        return b.quarterStep.direction == a.quarterStep.direction
    }
    
    /**
     `true` if `quarterStep.direction` value of either `PitchSpelling` is `natural` or if
     `isCoarseDirectionMatching`. Otherwise `false`.
     */
    public var isCoarseDirectionCompatible: Bool {
        return eitherIsNatural || isCoarseDirectionMatching
    }
    
    /**
     `true` if `quarterStep.resolution` values of both `PitchSpelling` values are equivalent.
     Otherwise `false`.
    */
    public var isCoarseResolutionMatching: Bool {
        return b.quarterStep.resolution == a.quarterStep.resolution
    }
    
    /**
     `true` if `quarterStep.direction` value of either `PitchSpelling` is `natural` or if
     `isCoarseResolutionMatching`. Otherwise `false`.
     */
    public var isCoarseResolutionCompatible: Bool {
        return eitherIsNatural || isCoarseResolutionMatching
    }
    
    /**
     `true` if the `letterName` values of both `PitchSpelling` values are equivalent. 
     Otherwise, `false.
     */
    public var isLetterNameMatching: Bool {
        return a.letterName == b.letterName
    }
    
    /**
     `true if `eighthStep` values of `PitchSpelling` objects are equivalent. Otherwise `false`.
     */
    public var isFineMatching: Bool { return b.eighthStep == a.eighthStep }
    
    /**
     - warning: Undocumented!
    */
    public var isFineCompatible: Bool {
        
        // manage close seconds
        guard eitherHasEighthStepModifier else { return true }
        if eitherHasNoEighthStepModifier && (eitherIsNatural || isCoarseMatching) {
            return !isLetterNameMatching
        }
        return isFineMatching
    }
    
    /// Mean of `spellingDistance` values of both `PitchSpelling` objects.
    public var meanSpellingDistance: Float {
        return [b.spellingDistance, a.spellingDistance].mean!
    }
    
    /// Mean of `quarterStep.distance` values of both `PitchSpelling objects.
    public var meanCoarseDistance: Float {
        return [b.quarterStep.distance, a.quarterStep.distance].mean!
    }
    
    /// Amount of steps between two `PitchSpelling` objects.
    internal var steps: Int {
        let difference = a.letterName.steps - b.letterName.steps
        return abs(Int.mod(difference, 7))
    }

    private var eitherIsNatural: Bool {
        return b.quarterStep == .natural || a.quarterStep == .natural
    }
    
    private var eitherHasNoEighthStepModifier: Bool {
        return b.eighthStep == .none || a.eighthStep == .none
    }
    
    private var eitherHasEighthStepModifier: Bool {
        return a.eighthStep != .none || b.eighthStep != .none
    }

    // MARK: - Initializers
    
    /**
     Create a `PitchSpellingDyad` with two `PitchSpelling` objects.
     */
    public init(_ b: PitchSpelling, _ a: PitchSpelling) {
        self.b = b
        self.a = a
    }
}

extension PitchSpellingDyad: Hashable {
    
    // MARK: - Hashable
    
    /// Hash value.
    public var hashValue: Int { return b.hashValue * a.hashValue }
}

extension PitchSpellingDyad: Equatable { }

public func == (lhs: PitchSpellingDyad, rhs: PitchSpellingDyad) -> Bool {
    return lhs.b == rhs.b && lhs.a == rhs.a
}

extension PitchSpellingDyad: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String {
        return "(\(a) , \(b))"
    }
}
