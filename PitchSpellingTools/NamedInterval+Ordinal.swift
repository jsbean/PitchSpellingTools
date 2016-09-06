//
//  NamedInterval+Ordinal.swift
//  PitchSpellingTools
//
//  Created by James Bean on 9/6/16.
//
//

extension NamedInterval {
    
    /**
     Ordinal of `NamedInterval`.
     
     - TODO: Add documentation!
     */
    public enum Ordinal: Int {
        
        /// Unison ordinal.
        case unison = 0
        
        /// Second ordinal.
        case second = 1
        
        /// Third ordinal.
        case third = 2
        
        /// Fourth ordinal.
        case fourth = 3
        
        /// Fifth ordinal.
        case fifth = 4
        
        /// Sixth ordinal.
        case sixth = 5
        
        /// Seventh ordinal.
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
            case .unison, .fourth, .fifth: return .perfect
            default: return .imperfect
            }
        }
    }
}
