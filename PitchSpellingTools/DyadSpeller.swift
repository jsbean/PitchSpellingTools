//
//  DyadSpeller.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import ArrayTools
import Pitch

/// Applies `PitchSpelling` objects to the pitches in a `Dyad`.
public class DyadSpeller: PitchSpeller {

    internal enum ObjectiveSpellability {
        case neither
        case one(objective: Pitch, subjective: Pitch)
        case both
    }
    
    // TODO: refine
    public enum Error: ErrorType { case error }
    
    /**
     Result from an attempt to spell a `Dyad`.
     */
    public enum Result {
        
        /// No `PitchSpellingDyad` objects found fulfilling given requirements.
        case none
        
        /// Single `PitchSpellingDyad` object found fulfilling given requirements.
        case single(PitchSpellingDyad)
        
        /// Multiple `PitchSpellingDyad` objects found fulfilling given requirements.
        case multiple([PitchSpellingDyad])
    }
    
    // All possible combinations of `PitchSpellings` of each `Pitch`.
    internal lazy var pitchSpellingDyads: [PitchSpellingDyad] = {
        combinations(
            self.dyad.lower.spellings,
            self.dyad.higher.spellings
        ).lazy.map { PitchSpellingDyad($0.0, $0.1) }
    }()

    /**
     - warning: Default implementation is `.none`. Must be overriden.
     */
    public var options: Result { return .none }
    
    internal var dyad: Dyad
    
    // MARK: - Type Methods
    
    /**
     Make the best-suited subclass of `DyadSpeller` for the given `dyad`.
     */
    public static func makeSpeller(forDyad dyad: Dyad) -> DyadSpeller? {
        var classType: DyadSpeller.Type? {
            switch dyad.finestResolution {
            case 0.25: return EighthToneDyadSpeller.self
            case 0.5: return QuarterToneDyadSpeller.self
            case 1.0: return HalfToneDyadSpeller.self
            default: return nil
            }
        }
        return classType?.init(dyad)
    }

    // MARK: - Initializers
    
    /**
     Create a `DyadSpeller` for the given `dyad`.
     */
    public required init(_ dyad: Dyad) {
        self.dyad = dyad
    }
    
    // MARK: - Instance Methods
    
    /**
     Spell the pitches in `dyad` with their default spellings. Often in the case that there is
     no hope to spell the pitches amicably.
     
     - throws: `PitchSpelling.Error` in the case the pitches in `dyad` are currently 
     unspellable.
     */
    public func spellWithDefaultSpellings() throws -> SpelledDyad {
        return try dyad.spellWithDefaultSpellings()
    }
    
    /**
     Spell `dyad` with the pitchSpellings found in the given `pitchSpellingDyad`.
     
     - throws: `PitchSpelling.Error.invalidSpellingForPitch` if either pitchSpelling in the
     `pitchSpellingDyad` is unfit for the target pitch of `dyad`.
     */
    public func spell(with pitchSpellingDyad: PitchSpellingDyad) throws -> SpelledDyad {
        return try dyad.spell(with: pitchSpellingDyad)
    }
    
    /**
     Forcibly spell the pitches in `dyad`. 
     
     In the case that no options are available wherein
     the pitches in `dyad` can be spelled amicably, 
     the default `PitchSpelling` value for each `Pitch` is chosen. 
     It should be noted that at the half-tone level, this is not actually a reality.
     
     In the case that there is exactly one option available wherein
     the pitches can be spelled amicable, this `PitchSpellingDyad` is chosen.
     
     In the case that there are more than one options available wherein 
     the pitches can be spelled amicably, 
     the `PitchSpellingDyad` with the least `meanDistance` value is chosen.
     
     >`(c sharp, f sharp); not (d flat, g flat)`
     
     - throws: `PitchSpeller.Error` if either `Pitch` cannot be spelled with the available
     `PitchSpelling` object.
     */
    public func spell() throws -> SpelledDyad {
        switch options {
        case .none:
            return try spellWithDefaultSpellings()
        case .single(let pitchSpellingDyad):
            return try spell(with: pitchSpellingDyad)
        case .multiple(let pitchSpellingDyads):
            return try spell(with: pitchSpellingDyads.first!)
        }
    }
}
