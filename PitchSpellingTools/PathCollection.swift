//
//  PathCollection.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

//import Foundation
//import ArrayTools
//
///**
// Collection of `Path` objects. May be all possible `Path` representations, or may be just 
//    a subset (only Sharps, or only compatible with Fine down).
// - TODO: conform to `CollectionType`.
// */
//internal struct PathCollection: SequenceType {
//
//    /// Amount of `Path` objects contain herein.
//    internal var count: Int { return paths.count }
//    
//    /// All `Path` objects contained herein.
//    internal var paths: [Path] = []
//    
//    private let filters: [(Path) -> Bool] = [
//        { $0.isFineCompatible },
//        { $0.hasValidIntervalQuality },
//        { $0.meanCoarseDistance <= 1 },
//    ]
//    
//    internal var stepPreserving: PathCollection {
//        return PathCollection(paths: paths.filter { $0.hasValidIntervalQuality })
//    }
//    
//    internal var fineCompatible: PathCollection {
//        return PathCollection(paths: paths.filter { $0.isFineCompatible })
//    }
//    
//    internal mutating func applyFiltersToPaths() {
//        var filteredPaths = paths
//        var filterIndex = 0
//        while filterIndex < filters.count && paths.count > 1 {
//            let filter = filters[filterIndex]
//            filteredPaths = filteredPaths.filter { filter($0) }
//            filterIndex += 1
//        }
//    }
//    
//    /**
//     Create a `PathCollection` with the given array of `Path` objects.
//     */
//    internal init(paths: [Path]) {
//        self.paths = paths
//    }
//    
//    internal init(nodes: [PitchSpellingNode]) {
//        self.init(paths: nodes.map { Path(nodes: [$0]) })
//    }
//    
//    /**
//     Add `Path` objects to the given `nextLevel` branching from the given `previouslLevel`.
//     */
//    internal mutating func addPaths(to nextLevel: PitchSpellingStack, branchingFrom previousLevel: PitchSpellingStack) {
//        previousLevel.nodes.forEach { addPaths(for: nextLevel.nodes, branchingFrom: $0) }
//    }
//
//    /**
//     Add `Path` objects for each in the given array of `nodes`, branching from the given 
//        `previousNode`.
//     */
//    internal mutating func addPaths(for nodes: [PitchSpellingNode], branchingFrom previousNode: PitchSpellingNode) {
//        
//        // get paths branching from previous node
//        let pathsToExtend = pathsBranching(from: previousNode)
//        
//        // clean paths of previous branch
//        paths = paths.filter { !$0.contains(previousNode) }
//        
//        // wrap
//        addPaths(for: nodes, extending: pathsToExtend)
//    }
//    
//    /**
//     TODO: clarify responsibility of `Graph` and `PathCollection` here.
//     */
//    private mutating func addPaths(for nodes: [PitchSpellingNode], extending pathsToExtend: [Path]) {
//        for node in nodes {
//            for path in pathsToExtend {
//
//                // TODO: bail if a predicate is not followed, 
//                // we can prevent creating all of the subpaths as necessary
//                paths.append(path + node)
//            }
//        }
//    }
//
//    private func pathsBranching(from node: PitchSpellingNode) -> [Path] {
//        let branchingPaths = paths.filter { $0.contains(node) }
//        return branchingPaths.count > 0 ? branchingPaths : [Path(nodes: [node])]
//    }
//    
//    internal func generate() -> AnyGenerator<Path> {
//        var generator = paths.generate()
//        return AnyGenerator { return generator.next() }
//    }
//}
//
//extension PathCollection: Hashable {
//    
//    internal var hashValue: Int { return description.hashValue }
//}
//
//func == (lhs: PathCollection, rhs: PathCollection) -> Bool {
//    return lhs.paths == rhs.paths
//}
//
//extension PathCollection: CustomStringConvertible {
//    
//    internal var description: String {
//        return paths.map { $0.description }.joinWithSeparator("\n")
//    }
//}
