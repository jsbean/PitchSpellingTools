## Eighth-tone PitchSet Spelling Algorithm
Finds the optimum way to spell the pitches of a `PitchSet`, with a resolution of up to an eighth-tone.

### PitchSet

A pitch set is considered here an unordered, unique, unspelled collection of pitches. There is no inherent assumption that this pitch set is a vertical, horizontal, or diagonal collection.

By nature, a pitch set is composed of <sub>n</sub>C<sub>2</sub> dyads.

**Example**:
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

### How to start

Dyads wih certain interval classes first are examined first, to ensure that salient relationships are the clearest. In this case, the ordering is done [here](https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/PitchSpellingTools/IntervalClass%2BPitchSpelling.swift). 


#### Rules not yet considered
- Spelling preferences guided by ascending / descending linear structures

