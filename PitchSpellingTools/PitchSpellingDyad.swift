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
 */
public struct PitchSpellingDyad {

    internal let a: PitchSpelling
    internal let b: PitchSpelling

    // MARK: - Instance Properties
    
//    /// `IntervalQuality` between `PitchSpelling` objects.
//    public var intervalQuality: IntervalQualityKind {
//        return IntervalQuality.kind(forPitchSpellingDyad: self)
//    }
    
//    /// `true` if has `intervalQuality` is objectively valid. Otherwise `false`.
//    public var hasValidIntervalQuality: Bool { return intervalQuality.hasValidIntervalQuality }
    
    /**
    `true` if `coarse` values of both `PitchSpelling` objects are equivalent.
     Otherwise `false`.
     */
    public var isCoarseMatching: Bool { return b.coarse == a.coarse }
    
    /**
     `true` if `coarse.direction` value of either `PitchSpelling` is `natural` or if
     `isCoarseCoarseCompatible`. Otherwise `false`.
     */
    public var isCoarseCompatible: Bool { return eitherIsNatural || isCoarseMatching }
    
    /**
    `true` if `coarse.direction` values of both `PitchSpelling` values are equivalent.
     Otherwise `false`.
     */
    public var isCoarseDirectionMatching: Bool {
        return b.coarse.direction == a.coarse.direction
    }
    
    /**
     `true` if `coarse.direction` value of either `PitchSpelling` is `natural` or if
     `isCoarseDirectionMatching`. Otherwise `false`.
     */
    public var isCoarseDirectionCompatible: Bool {
        return eitherIsNatural || isCoarseDirectionMatching
    }
    
    /**
     `true` if `coarse.resolution` values of both `PitchSpelling` values are equivalent.
     Otherwise `false`.
    */
    public var isCoarseResolutionMatching: Bool {
        return b.coarse.resolution == a.coarse.resolution
    }
    
    /**
     `true` if `coarse.direction` value of either `PitchSpelling` is `natural` or if
     `isCoarseResolutionMatching`. Otherwise `false`.
     */
    public var isCoarseResolutionCompatible: Bool {
        return eitherIsNatural || isCoarseResolutionMatching
    }
    
    public var isLetterNameMatching: Bool {
        return a.letterName == b.letterName
    }
    
    /**
     `true if `fine` values of `PitchSpelling` objects are equivalent. Otherwise `false`.
     */
    public var isFineMatching: Bool { return b.fine == a.fine }
    
    public var isFineCompatibleLoose: Bool {
        guard eitherHasNoFineAdjustment else { return true }
        return isFineMatching
    }
    
    /**
     - warning: No documentation
    */
    public var isFineCompatible: Bool {
        
        // manage close seconds
        guard eitherHasFineAdjustment else { return true }
        if eitherHasNoFineAdjustment && (eitherIsNatural || isCoarseMatching) {
            return !isLetterNameMatching
        }
        return isFineMatching
    }
    
    /// Mean of `spellingDistance` values of both `PitchSpelling` objects.
    public var meanSpellingDistance: Float {
        return [b.spellingDistance, a.spellingDistance].mean!
    }
    
    /// Mean of `coarse.distance` values of both `PitchSpelling objects.
    public var meanCoarseDistance: Float {
        return [b.coarse.distance, a.coarse.distance].mean!
    }
    
    /// Amount of steps between two `PitchSpelling` objects.
    internal var steps: Int {
        let difference = a.letterName.steps - b.letterName.steps
        return abs(Int.mod(difference, 7))
    }

    private var eitherIsNatural: Bool {
        return b.coarse == .natural || a.coarse == .natural
    }
    
    private var eitherHasNoFineAdjustment: Bool {
        return b.fine == .none || a.fine == .none
    }
    
    private var eitherHasFineAdjustment: Bool {
        return a.fine != .none || b.fine != .none
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
