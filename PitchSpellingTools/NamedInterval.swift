//
//  NamedInterval.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/9/16.
//
//

import Foundation

/**
 NamedInterval.
 
 **Example:**
 
 ```
 let perfectUnison = NamedInterval(.perfect, .unison)!
 let augmentedFifth = NamedInterval(.augmented, .fifth)!
 let _ = NamedInterval(.major, .fourth) // nil
 let doubleAugmentedSeventh = NamedInterval(.double, .augmented, .seventh)!
 ```
 */
public struct NamedInterval {
    
    /// Ordinal of `NamedInterval`.
    public enum Ordinal: Int {

        case unison = 0
        case second = 1
        case third = 2
        case fourth = 3
        case fifth = 4
        case sixth = 5
        case seventh = 6

        /**
         Perfect and imperfect class of interval ordinal.
         */
        public enum Family: String {
            
            /**
             Perfect interval family (e.g., `.unison`, `.fourth`, `.fifth`)
             
             > `.diminished`, `.perfect`, and `.augmented` interval qualities allowed.
            */
            case perfect
            
            /**
             Imperfect interval family (e.g., `.second`, `.third`, `.sixth`, `.seventh`)
             
             > `.diminished`, `.minor`, `.major`, and `.augmented` interval qualities allowed.
            */
            case imperfect
        }

        /**
         The inverse of an `Ordinal` 
         (e.g., `.second.inverse == .seventh`, `.third.inverse == .sixth`, etc).
        */
        public var inverse: Ordinal {
            return Ordinal(rawValue: 7 - rawValue)!
        }

        /// `Family` of an `Ordinal`.
        public var family: Family {
            switch self {
            case unison, fourth, fifth: return .perfect
            default: return .imperfect
            }
        }
    }
    
    /**
     `Quality` of a `NamedInterval`.
     */
    public struct Quality: OptionSetType {
        
        /**
         `Degree` of a `Quality` (e.g., `double augmented second`).
         
         - note: Only applicable for `.augmented` and `.diminished` values.
        */
        public enum Degree: Int {
            case quintuple = 5
            case quadruple = 4
            case triple = 3
            case double = 2
            case single = 1
        }
        
        // MARK: - Cases
        
        /// Diminished `Quality`
        public static let diminished = Quality(rawValue: -2)
        
        /// Minor `Quality`.
        public static let minor = Quality(rawValue: -1)
        
        /// Perfect `Quality`.
        public static let perfect = Quality(rawValue: 0)
        
        /// Major `Quality`.
        public static let major = Quality(rawValue: 1)
        
        /// Augmented `Quality`.
        public static let augmented = Quality(rawValue: 2)
        
        // MARK: - Sets by interval ordinal family
        
        private static let perfectSet: Quality = [diminished, perfect, augmented]
        private static let imperfectSet: Quality = [diminished, minor, major, augmented]
        
        // MARK: - Instance Properties
        
        /**
         Inverse of a `Quality`
         (e.g., `.major.inverse == .minor`, `.perfect.inverse == .perfect`, etc).
        */
        public var inverse: Quality {
            return Quality(rawValue: -1 * rawValue, degree: degree)
        }
        
        /// Raw value of a `Quality`.
        public let rawValue: Int
        
        /// Degree of a `Quality`.
        public let degree: Degree
        
        // MARK: - Initializers
        
        /**
         Create a `NamedInterval.Quality` with a degree.
         */
        public init(rawValue: Int, degree: Degree) {
            self.rawValue = rawValue
            self.degree = degree
        }
        
        /**
         Create a `NamedInterval.Quality`.
         */
        public init(rawValue: Int) {
            self.rawValue = rawValue
            self.degree = .single
        }
        
        // MARK: - Subscripts
        
        /**
         - returns: Quality with the given `degree` if `.diminished` or `.augmented`. 
         Otherwise, `nil`.
         */
        public subscript (degree: Degree) -> Quality? {
            switch self {
            case Quality.diminished, Quality.augmented:
                return Quality(rawValue: rawValue, degree: degree)
            default:
                return nil
            }
        }
        
        
        public subscript (degree: Int) -> Quality? {
            guard let degree = Degree(rawValue: degree) else { return nil }
            return self[degree]
        }
        
        // MARK: - Instance methods
        
        /**
         - returns: `true` if this `Quality` is valid for a given `Ordinal`. Otheriwse, `false`.
        
         > One cannot have a major fifth, etc.
         */
        public func isValid(for ordinal: Ordinal) -> Bool {
            switch ordinal.family {
            case .perfect where !Quality.perfectSet.contains(self): return false
            case .imperfect where !Quality.imperfectSet.contains(self): return false
            default: return true
            }
        }
    }
    
    // MARK: - Instance Properties
    
    /**
     Inverse of a `NamedInterval`.
     
     - TODO: Add examples to documentation.
    */
    public var inverse: NamedInterval {
        return NamedInterval(quality.inverse, ordinal.inverse)!
    }
    
    /// Ordinal of a `NamedInterval` (e.g., `.unison`, `.fifth`, `.seventh`, etc.).
    public let ordinal: Ordinal
    
    /// Quality of a `NamedInterval` (e.g., `.perfect`, `.augmented`, `.minor`, etc.).
    public let quality: Quality
    
    // MARK: - Initializers
    
    /**
     Create a `NamedInterval` with a given `quality` and an `ordinal`.
     
     - TODO: Add examples to documentation.
     */
    public init?(_ quality: Quality, _ ordinal: Ordinal) {

        guard quality.isValid(for: ordinal) else { return nil }
        
        self.quality = quality
        self.ordinal = ordinal
    }
    
    /**
     Create a `NamedInterval` with a `degree`, `quality`, and `ordinal`.
     
     - TODO: Add examples to documentation.
     */
    public init?(_ degree: Quality.Degree, _ quality: Quality, _ ordinal: Ordinal) {
        guard let quality = quality[degree] else { return nil }
        self.init(quality, ordinal)
    }
}

extension NamedInterval: Equatable { }

/**
 - returns: `true` if `ordinal` and `quality` values are equivalent. Otherwise, `false`.
 */
public func == (lhs: NamedInterval, rhs: NamedInterval) -> Bool {
    return lhs.ordinal == rhs.ordinal && rhs.quality == rhs.quality
}
