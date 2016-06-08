# PitchSpelling

## Background
`Pitch` values can often be represented multiple ways on a musical staff. 

For example, the `Pitch` with a `MIDI` note number of `61`, or a frequency of `277.18 Hz`, is one half-step above `middle c`. This pitch can be represented either as a `c sharp` or a `d flat`, each representation being more appropriate for different contexts.

### Interval Optimization
In general, `IntervalQuality` values of type `diminished` or `augmented` are less preferred to those of type `minor`, `perfect`, or `major`. In the case of the `tritone`, `augmented fourth` and `diminished fifth` `IntervalQuality` values are necessary, and therefore acceptable.

Consider a context in which an `a natural` is present along with the aforementioned pitch of `MIDI` note number `61`.

| First | Second | `IntervalQuality` |  Preference   |
| ----- | ------ | ----------------- | --- |
| `a natural` | `c sharp` | `major third` | **desired** |
| `a natural` | `d flat`  | `diminished fourth` | **undesired** |

## Structures

### PitchSet

A `PitchSet` is considered here an unordered, unique, unspelled collection of `Pitch` values. There is no inherent assumption that this `PitchSet` is a vertical, horizontal, or diagonal collection. 

### PitchSetSequence

Ordered, not-necessarily unique sequence of one or more unspelled vertical `PitchSet` values (chords).

### Dyads

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

### Nodes, Edges, Stacks, Rankings

In order to keep track of spelling preferences when there is no clear answer, certain data structures have been created:

| Structure | Note        |
|-----------|-------------|
| [`PitchSpellingNode`](https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/PitchSpellingTools/PitchSpellingNode.swift) |  Wraps a single `PitchSpelling` and its `Pitch`, with a `rank` |
| [`PitchSpellingEdge`](https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/PitchSpellingTools/PitchSpellingEdge.swift) | Combination of a single pair of `PitchSpellingNode` values from a `Dyad`, with a `rank` |
| [`PitchSpellingStack`](https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/PitchSpellingTools/PitchSpellingStack.swift) | Collection of all `PitchSpellingNode` objects for a given `Pitch` |
| [`Ranker`](https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/PitchSpellingTools/PitchSpellingRanking.swift)  | Ranks all possible `PitchSpellingNode` or `PitchSpellingEdge` options for a given `Dyad` |


### Ranking Potential Spellings

Ranking values are `Float` values in the range `0.0...1.0`, and both `PitchSpellingNode` and `PitchSpellingEdge` objects may be ranked. 

In cases where at least one `Pitch` value in the given `PitchSet` is can only be spelled one way, a conclusive set of `PitchSpelling` values can be determined by comparing the `rank` values of each `PitchSpellingNode`. 

When no conclusive spelling can be found for a given `PitchSet` (i.e., when no `Pitch` values therein are objectively spellable), the `rank` value of `Edge` values can be used to influence a decision for an otherwise ambiguous context.

> `Pitch(noteNumber: 60)` can only be spelled as `c natural`, unless we are allowing `b sharps` and `d doubleFlats`

### Rankers

There are three cases possible when attempting to spell a `Dyad`:

1. Both pitches can be spelled objectively (e.g., `(60, 67)`)
2. One pitch can be spelled objectively (e.g., `(62, 63), (66, 67)`)
3. Neither pitch can be spelled objectively (e.g., `(63, 66)`)

For case 1 above, no action is needed other than confirming that the objectively spellable `PitchSpellingNode` values hold a `rank` of `1.0`.

#### SemiAmbiguousPitchSpellingRanker

For case 2 above, the `SemiAmbiguousPitchSpellingRanker` takes an objectively spellable `Node`, and the `Level` for a non-objectively spellable `Pitch`. 

The `SemiAmbiguousPitchSpellingRanker` iterates over each possible `PitchSpelling` in the `Level` of non-objectively spellable `Pitch`, penalizing the `PitchSpelling` values that break any of a variety of rules.

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/semi_ambiguous.jpg" height="240">

#### FullyAmbiguousPitchSpellingRanker

For case 3 above, the `FullyAmbiguousPitchSpellingRanker` takes two `Level` values for each `Pitch` in the `Dyad`.

The `FullyAmbiguousPitchSpellingRanker` iterates over each possible `PitchSpellingDyad` combination between the two `Level` values of the non-objectively spellable `Pitch` values, penalizing the `Edge` containing `PitchSpellingDyad` values that break any of a variety of rules.

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/fully_ambiguous.jpg" height="240">

---

# PitchSetSpeller

**Goal:** Find the optimum way to spell the pitches of a `PitchSet`.

For our purposes, this algorithm is to handle cases of `Pitch` values with a resolution of up to an eighth-tone (48 divisions of the octave).

## Prepare `Dyad` values

First, all `Dyad` values for the given `PitchSet` are ordered by `spelling priority` of their `IntervalClass`. By attempting to spell `Dyad` values with certain `IntervalClass` values first, the most salient relationships are prioritized, and are therefore preserved in their graphical representation.

For our purposes, half-steps are spelled before perfect intervals, which are spelled before imperfect intervals, which are spelled before tritone intervals. To see the details of the ordering, look [here](https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/PitchSpellingTools/IntervalClass%2BPitchSpelling.swift). 

**Example:**
```Swift
// For the case above, the dyads are now ordered as such:
// => [(62, 63), (66, 67), (62, 67), (62, 66), (63, 67), (63, 66)]
```

## Iterate over `Dyad` values

In cases where one `Pitch` is objectively spellable, we can do a single pass over all (or often times less than all) of the `Dyad` values. At first, all `PitchSpellingNode` values are given a `nil` `rank` value.

Each iteration, we do two general things:

- A. Check if all of the `PitchSpellingNode` values have been given a `rank`. 
  - If so, we can `break` the iteration, and make a decision based on the `rank` values of each `PitchSpellingNode`.
- B. Create an appropriate `Ranker`
  - Examine each `Dyad`, penalizing the offensive `Edge` values as necessary.

>The weight of penalties for rule-breaking decrease as the iteration goes on (needs to be refined): 
>```Swift
>((dyads.count - position) / dyads.count) / 2
>```

In the original example, the dyads sorted are: 
- 1. [`(62, 63)`](#62-63)
- 2. [`(66, 67)`](#66-67)
- 3. [`(62, 67)`](#62-67)
- 4. _`(62, 66)`_
- 5. _`(63, 67)`_
- 6. _`(63, 66)`_

<a name = "62-63"></a>
#### 1. `(62, 63)`
- **A:** Check if all of the `PitchSpellingNode` values have been ranked. At this point, no `Node` values have been ranked, so we must keep going.

- **B:** Here, `62` can only be spelled as `d natural`. Therefore we can create a `SemiAmgbiguousPitchSpellingRanker`.

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/62_63.jpg" height="240">

The comparison stage penalizes the `D` / `D#` `PitchSpellingDyad` as it does not preserve step count. 

> Because it is the first to be checked, the penalty is very high.

<a name = "66-67"></a>
#### 2. `(66, 67)`

- **A:** Check if all of the `PitchSpellingNode` values have been ranked. At this point, the `PitchSpellingNode` values belonging to `Pitch(noteNumber: 62)`, `Pitch(noteNumber: 63)`, and `Pitch(noteNumber: 67)` have been ranked, but not yet `Pitch(noteNumber: 66)`.

- **B:** We can create a `SemiAmgbiguousPitchSpellingRanker` as `67` will be spelled as a `g natural`.

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/Documentation/img/66_67.jpg" height="240">

<a name = "62-67"></a>
#### 3. `(62, 67)`

- **A:** Check if all of the `PitchSpellingNode` values have been ranked. At this point, all `PitchSpellingNode` values have been ranked. We are now able to compare.

- _**B:**_ _(not called)_

---

## Rules not yet considered
- Spelling preferences guided by ascending / descending linear structures

## Reading

- "Automatic Pitch Spelling: From Numbers to Sharps and Flats", Cambouropoulos [[PDF](http://users.auth.gr/emilios/papers/fortaleza2001.pdf)]
- "Pitch Spelling Algorithms", Meredith [[PDF](http://www.titanmusic.com/papers/public/ps13-escom-paper.pdf)]
- "Comparing Pitch Spelling Algorithms", Meredith, Wiggins [[PDF](http://ismir2005.ismir.net/proceedings/1004.pdf)]
- "PST: Pitch Spelling Technology", Chew, Chen [[PDF](http://infolab.usc.edu/imsc/research/project/pst/pst_nsf8.pdf)]
