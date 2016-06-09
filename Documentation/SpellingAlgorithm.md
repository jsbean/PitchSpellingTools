# PitchSpelling

## Background
`Pitch` values can often be represented multiple ways on a musical staff. 

> A `Pitch` with a `MIDI` note number of `61` (frequency of `277.18 Hz`) is one half-step above `middle c`. 
> 
> This pitch can be represented either as a `c sharp` or a `d flat`. Each representation is more appropriate for different contexts.

## Spelling preferrences

### Interval Optimization

`IntervalQuality` between two `PitchSpelling` values is the primary determinate of preference. 

| `IntervalQuality` | Preference |
| --- | --- |
| `diminished` | **undesired** |
| `minor` | **desired**  | 
| `perfect` | **desired**  |
| `major` | **desired**  |
| `augmented` | **undesired** |

> In the case of the `tritone`, `augmented fourth` and `diminished fifth` `IntervalQuality` values are necessary, and therefore acceptable.

Consider the possibilities for representing a context in which an `a natural` is present along with the aforementioned `Pitch` of `MIDI` note number `61`:

| Pitch (nn: 57) | Pitch (nn: 61) | `IntervalQuality` |  Preference   |
| ----- | ------ | ----------------- | --- |
| `a natural` | `c sharp` | `major third` | **desired** |
| `a natural` | `d flat`  | `diminished fourth` | **undesired** |

> There is a clear preference, because the `Pitch` of `MIDI` note number `57` can only be spelled as an `a natural` (granted that we are disallowing `double flat` and `double sharp` `PitchSpelling` values).

However, consider a context in which the other `Pitch` also has multiple spelling representations, such as the `Pitch` of `MIDI`note number `56`:

| Pitch (nn: 56) | Pitch (nn: 61) | `IntervalQuality` |  Preference   |
| ----- | ------ | ----------------- | --- |
| `g sharp` | `c sharp` | `perfect fourth` | **desired** |
| `g sharp` | `d flat` | `diminished fifth` | **undesired** |
| `a flat` | `c sharp` | `augmented third`  | **undesired** |
| `a flat` | `d flat` | `perfect fourth` | **desired**  |

> Not that there are multiple desired options.

## Eighth-step Resolution 

There are a few additional preferences when spelling eighth-step resolution `Pitch` values.

### Fine Compatibility

In cases of eighth-step resolution `Pitch` values, it is preferred that the `fine.direction` (`up`, `down`) is compatible.

### Coarse Resolution Compatibility

In the case of eighth-step resolution `Pitch` values, which may be spelled with a quarter-step body (`a quarterSharp down`), it is preferred that the `coarse.resolution` (`quarterSharp`, `sharp`, `quarterFlat`, `flat`) is compatible.

---

## Structures

### PitchSet

A `PitchSet` is considered here an unordered, unique, unspelled collection of `Pitch` values. There is no inherent assumption that this `PitchSet` is a vertical, horizontal, or diagonal collection. 

### Dyads

By nature, a `PitchSet` is composed of _<sub>n</sub>C<sub>2</sub>_ `Dyad` values (pairs of `Pitch` values). 

**Example:**

Consider a pitch set with `MIDI` note number values `[62, 63, 66, 67]`:

```Swift

let pitchSet: PitchSet = [
  Pitch(noteNumber: 62),
  Pitch(noteNumber: 63), 
  Pitch(noteNumber: 66), 
  Pitch(noteNumber: 67)
]
```

In this case, there are 6 `Dyad` values:

```Swift
[(62, 63), (62, 66), (62, 67), (63, 66), (63, 67), (66, 67)]
```

### PitchSetSequence

Ordered, not-necessarily unique sequence of one or more unspelled vertical `PitchSet` values (chords).


### Nodes, Edges, Stacks, Rankings

In order to keep track of spelling preferences when there is no clear answer, certain data structures have been created:

| Structure | Note        |
|-----------|-------------|
| [`PitchSpellingNode`](https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/PitchSpellingTools/PitchSpellingNode.swift) |  Wraps a single `PitchSpelling` and its `Pitch`, with a `rank` |
| [`PitchSpellingEdge`](https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/PitchSpellingTools/PitchSpellingEdge.swift) | Combination of a single pair of `PitchSpellingNode` values from a `Dyad`, with a `rank` |
| [`PitchSpellingStack`](https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/PitchSpellingTools/PitchSpellingStack.swift) | Collection of all `PitchSpellingNode` objects for a given `Pitch` |
| [`Ranker`](https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/PitchSpellingTools/PitchSpellingRanking.swift)  | Ranks all possible `PitchSpellingNode` or `PitchSpellingEdge` options for a given `Dyad` |

### Ranking Potential Spellings and Potential Spelling Pairs

Both `PitchSpellingNode` and `PitchSpellingEdge` objects may be ranked. 

When no conclusive spelling can be found for a given `PitchSet` (i.e., when no `Pitch` values therein are objectively spellable), the `rank` value of `PitchSpellingEdge` values are consulted to determine an otherwise ambiguous context.

### Rankers

There are **three cases** possible when attempting to spell a `Dyad`:

1. Both `Pitch` values can be spelled objectively: `(60, 67)`
2. One `Pitch` value can be spelled objectively: `(62, 63), (66, 67)`
3. Neither `Pitch` value can be spelled objectively: `(63, 66)`

#### Case 1: DeterminatePitchSpellingRanker

The `DeterminatePitchSpellingRanker` applies an optimum `rank` of `1.0` to both `PitchSpellingNode` values.

#### Case 2: SemiAmbiguousPitchSpellingRanker

The `SemiAmbiguousPitchSpellingRanker` ranks each possible `PitchSpellingNode` for a given ambiguously spellable `PitchSpellingStack`, given the context of an objectively spellable `PitchSpellingNode`.

Each `PitchSpellingNode` from the ambiguously spellable `PitchSpellingStack` is penalized for breaking a given set of rules when contextualized by the objectively spellable `PitchSpellingNode`.

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/semi_ambiguous.jpg" height="240">

#### Case 3: FullyAmbiguousPitchSpellingRanker

The `FullyAmbiguousPitchSpellingRanker` ranks each possible `PitchSpellingEdge` between each possible `PitchSpellingNode` from each ambiguously spellable `PitchSpellingStack`.

Each `PitchSpellingEdge` is penalized if it breakings any of a given set of rules within its own context.

<img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/Documentation/img/fully_ambiguous.jpg" height="240">

---

# PitchSetSpeller

## Goal
Find the optimum way to spell the `Pitch` values comprising a `PitchSet`.

For our purposes, this algorithm is to handle cases of `Pitch` values with a resolution of up to an eighth-step (48 divisions of the octave).

## Process

#### 1. Prepare `Dyad` values

Sort `Dyad` values for the given `PitchSet` by `spelling priority` of its `IntervalClass`.

> By attempting to spell `Dyad` values with certain `IntervalClass` values first, the most salient relationships are prioritized, and are therefore preserved in their graphical representation.

> To see the details of the ordering, look [here](https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/PitchSpellingTools/IntervalClass%2BPitchSpelling.swift). 

**Example:**
For the case above, the dyads are now ordered as such:

```Swift
[(62, 63), (66, 67), (62, 67), (62, 66), (63, 67), (63, 66)]
```

The order of applying rules is important, as the weight of the penalties applied to each `Dyad` decreases throughout the iterative process.

> <img src="https://github.com/dn-m/PitchSpellingTools/blob/bean-horizontal/Documentation/img/62_63.jpg" height="240">

For example, the penalty applied to the `d sharp` `PitchSpellingNode` in the above graphic is more severe than those applied to the `PitchSpellingNode` objects for the `Dyad` values ranked afterward.

#### 2. Create `PitchSpellingRanking` structure for each `Dyad`
For each `Dyad` in the given `PitchSet`: 
- Create the appropriate `PitchSpellingRanking` structure:
  - `Determinate`
  - `SemiAmbiguous`
  - `FullyAmbiguous`

#### 3. Apply rankings to `PitchSpellingNode` objects

For each `PitchSpellingRanking` structure:
- Apply rankings to `PitchSpellingNode` objects contained therein (`Determinate` / `SemiAmbiguous`) or `PitchSpellingEdge` (`FullyAmbiguous`).

> In the case that there are no objectively spellable `Pitch` values in the given `PitchSet`, no `PitchSpellingNode` objects are ranked. 
>
> Instead, the `PitchSpellingEdge` objects are ranked.

#### 4. Apply rankings of `PitchSpellingEdge` objects to `PitchSpellingNode` objects
Penalize the `PitchSpellingNode` objects that are found in poorest-rated `PitchSpellingEdge` objects.

#### 5. `return`
Return the the set composed of the spellings of the highest ranked `PitchSpellingNode` for each `Pitch`.

---

# PitchSequenceSpeller

> Work-in-progress

## Goal
Find the optimum way to spell a sequence of vertical `PitchSet` values.

> **TODO:** Determine rules for segmentation

### Thoughts on sub-segmentation
Use finite state machine to well-define possible transitions from `PitchSet` values with `spellability` values:
- `.objective`
- `.semiAmbiguous`
- `.fullyAmbiguous`

|                | `objective` | `semiAmbiguous`   | `fullyAmbiguous` |
| -------------- | --------- | --------------  | -------------- |
| `objective`      | commit    | add to current  | add to current |
| `semiAmbiguous`  | commit    | add to current  | add to current |
| `fullyAmbiguous` | commit    | add to current  | add to current |


- Only start completely clean after O -> O
- Special case for adjacent linked with `semiAmbiguous`
- Special case for adjacent linked with `objective`

---

## Rules not yet considered
- Spelling preferences guided by ascending / descending linear structures

## Reading

- "Automatic Pitch Spelling: From Numbers to Sharps and Flats", Cambouropoulos [[PDF](http://users.auth.gr/emilios/papers/fortaleza2001.pdf)]
- "Pitch Spelling Algorithms", Meredith [[PDF](http://www.titanmusic.com/papers/public/ps13-escom-paper.pdf)]
- "Comparing Pitch Spelling Algorithms", Meredith, Wiggins [[PDF](http://ismir2005.ismir.net/proceedings/1004.pdf)]
- "PST: Pitch Spelling Technology", Chew, Chen [[PDF](http://infolab.usc.edu/imsc/research/project/pst/pst_nsf8.pdf)]
- State Machines in Swift [pt 1](http://www.figure.ink/blog/2015/1/31/swift-state-machines-part-1), [pt 2](http://www.figure.ink/blog/2015/2/1/swift-state-machines-part-2), [pt 3](http://www.figure.ink/blog/2015/2/8/swift-state-machines-part-3-follow-up), [pt 4](http://www.figure.ink/blog/2015/2/9/swift-state-machines-part-4-redirect)
