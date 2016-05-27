//
//  NodeFilter.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import Foundation

internal struct NodeFilter {
    
    private let coarseDirectionPreference: PitchSpelling.CoarseAdjustment.Direction
    private let fineDirectionPreference: PitchSpelling.FineAdjustment
    private let allowsUnconventionalEnharmonics: Bool
    
    internal init(
        coarseDirectionPreference: PitchSpelling.CoarseAdjustment.Direction,
        fineDirectionPreference: PitchSpelling.FineAdjustment,
        allowsUnconventionalEnharmonics: Bool
    )
    {
        self.coarseDirectionPreference = coarseDirectionPreference
        self.fineDirectionPreference = fineDirectionPreference
        self.allowsUnconventionalEnharmonics = allowsUnconventionalEnharmonics
    }
    
    internal func filter(nodes: [Node]) -> [Node] {
        var nodes = nodes
        nodes = filterNodes(nodes, forFineDirectionPreference: fineDirectionPreference)
        nodes = filterNodes(nodes, forCoarseDirectionPreference: coarseDirectionPreference)
        nodes = filterNodes(nodes,
            forAllowingUnconventionalEnharmonics: allowsUnconventionalEnharmonics
        )
        return nodes
    }
    
    private func filterNodes(nodes: [Node],
        forCoarseDirectionPreference coarseDirectionPreference:
            PitchSpelling.CoarseAdjustment.Direction
    ) -> [Node]
    {
        switch coarseDirectionPreference {
        case .none: return nodes
        case .up: return nodes.filter { $0.spelling.coarse.direction.rawValue >= 0 }
        case .down: return nodes.filter { $0.spelling.coarse.direction.rawValue <= 0 }
        }
    }
    
    private func filterNodes(nodes: [Node],
        forFineDirectionPreference fineDirectionPreference: PitchSpelling.FineAdjustment
    ) -> [Node]
    {
        switch fineDirectionPreference {
        case .none: return nodes
        case .up: return nodes.filter { $0.spelling.fine.rawValue >= 0 }
        case .down: return nodes.filter { $0.spelling.fine.rawValue <= 0 }
        }
    }
    
    // filters out double sharps, double flats, e sharp, b sharp, f flat, c flat
    private func filterNodes(nodes: [Node],
        forAllowingUnconventionalEnharmonics allowsUnconventionalEnharmonics: Bool
    ) -> [Node]
    {
        guard !allowsUnconventionalEnharmonics else { return nodes }
        
        var nodes = nodes
        
        // c flat
        nodes = nodes.filter {
            !($0.spelling.letterName == .c && $0.spelling.coarse == .flat)
        }
        
        // f flat
        nodes = nodes.filter {
            !($0.spelling.letterName == .f && $0.spelling.coarse == .flat)
        }
        
        // e sharp
        nodes = nodes.filter {
            !($0.spelling.letterName == .e && $0.spelling.coarse == .sharp)
        }
        
        // b sharp
        nodes = nodes.filter {
            !($0.spelling.letterName == .b && $0.spelling.coarse == .sharp)
        }
        
        nodes = nodes.filter {
            !($0.spelling.coarse == .doubleSharp || $0.spelling.coarse == .doubleFlat)
        }
        
        return nodes
    }
}