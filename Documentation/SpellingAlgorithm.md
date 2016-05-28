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

**Note:**
> `Pitch(noteNumber: 60)` can only be spelled as `c natural`, unless we are allowing `b sharps` and `d doubleFlats`

#### Comparison Stages

There are three cases possible when attempting to spell a `Dyad`:

1. Both pitches can be spelled objectively (e.g., `(60, 67)`)
2. One pitch can be spelled objectively (e.g., `(62, 63), (66, 67)`)
3. Neither pitch can be spelled objectively (e.g., `(63, 66)`)

For case 1 above, no action is needed other than confirming that the objectively spellable `Node` values hold a `rank` of `1.0`.

##### SemiAmbiguousComparisonStage

For case 2 above, the `SemiAmbiguousComparisonStage` takes an objectively spellable `Node`, and the `Level` for a non-objectively spellable `Pitch`. 

The `SemiAmbiguousComparisonStage` iterates over each possible `PitchSpelling` in the `Level` of non-objectively spellable `Pitch`, penalizing the `PitchSpelling` values that break any of a variety of rules.

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/semi_ambiguous.jpg" height="240">

##### FullyAmbiguousComparisonStage

For case 3 above, the `FullyAmbiguousComparisonStage` takes two `Level` values for each `Pitch` in the `Dyad`.

The `FullyAmbiguousComparisonStage` iterates over each possible `PitchSpellingDyad` combination between the two `Level` values of the non-objectively spellable `Pitch` values, penalizing the `Edge` containing `PitchSpellingDyad` values that break any of a variety of rules.

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/fully_ambiguous.jpg" height="240">

### Iterate over `Dyad` values

In cases where one `Pitch` is objectively spellable, we can do a single pass over all (or often times less than all) of the `Dyad` values. At first, all `Node` values are given a `nil` `rank` value.

At the beginning of each iteration, we check if all of the `Node` values have been given a `rank`. If so, we can `break` the iteration, and make a decision based on the `rank` values of each `Node`.

Otherwise we continue to examine each `Dyad` as it comes, penalizing the offensive `Edge` values as necessary.

The weight of penalties for rule-breaking decrease as the iteration goes on (this will be refined): 
```Swift
((dyads.count - position) / dyads.count) / 2
```

In the original example, the dyads sorted are: `[(62, 63), (66, 67), (62, 67), (62, 66), (63, 67), (63, 66)]`.

#### `(62, 63)`

Here, `62` can only be spelled as `d natural`. Therefore we can create a `SemiAmgbiguous`

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/62_63.jpg" height="240">

#### `(60, 67)`

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/66_67.jpg" height="240">

### Rules not yet considered
- Spelling preferences guided by ascending / descending linear structures

### Reading

- "Automatic Pitch Spelling: From Numbers to Sharps and Flats", Cambouropoulos [[PDF](http://users.auth.gr/emilios/papers/fortaleza2001.pdf)]
- "Pitch Spelling Algorithms", Meredith [[PDF](http://www.titanmusic.com/papers/public/ps13-escom-paper.pdf)]
- "Comparing Pitch Spelling Algorithms", Meredith, Wiggins [[PDF](http://ismir2005.ismir.net/proceedings/1004.pdf)]
- "PST: Pitch Spelling Technology", Chew, Chen [[PDF](http://infolab.usc.edu/imsc/research/project/pst/pst_nsf8.pdf)]
