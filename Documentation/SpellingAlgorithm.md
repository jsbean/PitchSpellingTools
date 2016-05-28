## Eighth-tone PitchSet Spelling Algorithm
Find the optimum way to spell the pitches of a `PitchSet`.

### PitchSet

A `PitchSet` is considered here an unordered, unique, unspelled collection of `Pitch` values. There is no inherent assumption that this `PitchSet` is a vertical, horizontal, or diagonal collection. 

For our purposes, this algorithm is to handle cases of `Pitch` values with a resolution of up to an eighth-tone.

#### Dyads

By nature, a `PitchSet` is composed of _<sub>n</sub>C<sub>2</sub>_ `Dyad` values (pairs of `Pitch` values). 

In this algorithm, optimum spellings for each `Dyad` comprising the given `PitchSet` are sought. This process continues until all `PitchSpelling` options for all `Pitch` values have been examined, and can therefore be compared by `rank`.

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

The case above is interesting, as its optimum spelling contains both sharps and flats. 

### Where to start

First, all `Dyad` values for the given `PitchSet` are ordered by `spelling urgency` (looking for a better term...) of their `IntervalClass`. By attempting to spell `Dyad` values with certain `IntervalClass` values first, the most salient relationships are prioritized, and are therefore preserved in their graphical representation.

For our purposes, half-steps are spelled before perfect intervals, which are spelled before imperfect intervals, which are spelled before tritone intervals. To see the details of the ordering, look [here](https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/PitchSpellingTools/IntervalClass%2BPitchSpelling.swift). 

**Example:**
```Swift
// For the case above, the dyads are now ordered as such:
// => [(62, 63), (66, 67), (62, 67), (62, 66), (63, 67), (63, 66)]
```

### Nodes, Levels, Edges, ComparisonStages, Rankings

In order to keep track of spelling preferences when there is no clear answer, certain data structures have been created:

| Tables   |      Are      |
|----------|-------------|
| [`Node`](https://github.com/dn-m/PitchSpellingTools/blob/1de9c94c05b7c23e5ff60dccff8d070ba5d48a36/PitchSpellingTools/Node.swift) |  Wraps a single `PitchSpelling` and its `Pitch`, with a `rank` |
| [`Edge`](https://github.com/dn-m/PitchSpellingTools/blob/1de9c94c05b7c23e5ff60dccff8d070ba5d48a36/PitchSpellingTools/Edge.swift) | A single combination of `Node` values from a `Dyad`, with a `rank` |
| [`Level`](https://github.com/dn-m/PitchSpellingTools/blob/1de9c94c05b7c23e5ff60dccff8d070ba5d48a36/PitchSpellingTools/Level.swift) |    All of the `Node` objects for a given `Pitch` (i.e., every possible way to spell a given `Pitch`)   |
| [`ComparisonStage`](https://github.com/dn-m/PitchSpellingTools/blob/1de9c94c05b7c23e5ff60dccff8d070ba5d48a36/PitchSpellingTools/ComparisonStage.swift)  | Compares potential `PitchSpelling` options for a given `Dyad`, owns `Edge` values |


#### Ranking Potential Spellings

Ranking values are `Float` values in the range `0.0...1.0`, and both `Node` and `Edge` objects may be ranked. 

In cases where at least one `Pitch` value in the given `PitchSet` is objectively spellable, a conclusive set of `PitchSpelling` values can be determined by comparing the `rank` values of each `Node`. 

When no conclusive spelling can be found for a given `PitchSet` (i.e., when no `Pitch` values therein are objectively spellable), the `rank` value of `Edge` values can be used to enforce a decision for an otherwise ambiguous context.

#### Comparison Stages

There are three cases possible when attempting to spell a `Dyad`:

1. Both pitches can be spelled objectively (e.g., `(60, 67)`)
2. One pitch can be spelled objectively (e.g., `(62, 63), (66, 67)`)
3. Neither pitch can be spelled objectively (e.g., `(63, 66)`)

For case 1 above, no action is needed other than confirming that the objectively spellable `Node` values hold a `rank` of `1.0`.

For case 2, the `SemiAmbiguousComparisonStage` takes an objectively spellable `Node`, and the `Level` for a non-objectively spellable `Pitch`.

For case 3, the `FullyAmbiguousComparisonStage` takes two `Level` values for each `Pitch` in the `Dyad`.

For each `Dyad` that is examined, infrastructure for judging potential spellings for each `Pitch` therein.

**Note:**
> `Pitch(noteNumber: 60)` can only be spelled as `c natural`, unless we are allowing `b sharps` and `d doubleFlats`

### Iterate over dyads

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/62_63.jpeg" height="240">

### Rules not yet considered
- Spelling preferences guided by ascending / descending linear structures

