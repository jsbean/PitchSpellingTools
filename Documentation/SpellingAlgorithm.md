## Eighth-tone PitchSet Spelling Algorithm
Finds the optimum way to spell the pitches of a `PitchSet`, with a resolution of up to an eighth-tone.

#### PitchSet

A pitch set is considered here an unordered, unique, unspelled collection of pitches. There is no inherent assumption that this pitch set is a vertical, horizontal, or diagonal collection.

By nature, a pitch set is composed of <sub>n</sub>C<sub>2</sub> dyads.

**Example:**
```Swift
// Consider a pitch set with midi note number values [62, 63, 66, 67]
let pitchSet: PitchSet = [
  Pitch(noteNumber: 62),
  Pitch(noteNumber: 63), 
  Pitch(noteNumber: 66), 
  Pitch(noteNumber: 67)
]
// In this case, there are 6 dyads => [(62, 63), (62, 66), (62, 67), (63, 66), (63, 67), (66, 67)]
```

#### Where to start

First, all of the dyads for the given pitch set are ordered by `spelling urgency` (looking for a better term...). By attempting to spell `Dyad` values with certain `IntervalClass` values first, the most salient relationships are prioritized, and therefore preserved in their graphical representation (for our purposes, half-steps before perfect intervals before imperfect intervals). To see the details of the ordering, look [here](https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/PitchSpellingTools/IntervalClass%2BPitchSpelling.swift). 

**Example:**
```Swift
// For the case above, the dyads are now ordered as such:
// => [(62, 63), (66, 67), (62, 67), (63, 67), (62, 66), (63, 66)]
```

#### Nodes, Levels, Edges, ComparisonStages, Rankings

In order to keep track of spelling preferences when there is no clear answer, certain data structures have been created:

- [`Node`](https://github.com/dn-m/PitchSpellingTools/blob/1de9c94c05b7c23e5ff60dccff8d070ba5d48a36/PitchSpellingTools/Node.swift): Wraps a single `PitchSpelling` and its `Pitch`, with a `rank`.
- [`Level`](https://github.com/dn-m/PitchSpellingTools/blob/1de9c94c05b7c23e5ff60dccff8d070ba5d48a36/PitchSpellingTools/Level.swift): All of the `Node` objects for a given `Pitch` (i.e., every possible way to spell a given pitch).
- [`ComparisonStage`](https://github.com/dn-m/PitchSpellingTools/blob/1de9c94c05b7c23e5ff60dccff8d070ba5d48a36/PitchSpellingTools/ComparisonStage.swift): Compares potential `PitchSpelling` options for a given `Dyad`.
- [`Edge`](https://github.com/dn-m/PitchSpellingTools/blob/1de9c94c05b7c23e5ff60dccff8d070ba5d48a36/PitchSpellingTools/Edge.swift): Wraps two `Node` objects, with a `rank`. 

#### Comparison Stages

There are three cases possible when attempting to spell a `Dyad`:

1. Both pitches can be spelled objectively (e.g., `(60, 67)`)
2. One pitch can be spelled objectively (e.g., `(62, 63)`)
3. Neither pitch can be spelled objectively (e.g., `(63, 66)`)

**Note:**
> `Pitch(noteNumber: 60)` can only be spelled as `c natural`, unless we are allowing `b sharps` and `d doubleFlats`

#### Iterate over dyads

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/62_63.jpeg" height="240">

#### Rules not yet considered
- Spelling preferences guided by ascending / descending linear structures

