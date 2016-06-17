//
//  Node.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/17/16.
//
//

import TreeTools

final class Node: NodeType {
    
    var parent: Node?
    var children: [Node] = []
}