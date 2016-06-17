//
//  Node.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/17/16.
//
//

import TreeTools
import Pitch

public final class Node: NodeType {
    
    public var parent: Node?
    public var children: [Node] = []
    
    public let pitch: Pitch
    public let spelling: PitchSpelling
    
    public init(pitch: Pitch, spelling: PitchSpelling) {
        self.pitch = pitch
        self.spelling = spelling
    }
    
    public func addNode(forPitch pitch: Pitch, andSpelling spelling: PitchSpelling) {
        let node = Node(pitch: pitch, spelling: spelling)
        
    }
}