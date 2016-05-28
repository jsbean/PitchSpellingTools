### Eighth-tone PitchSet Spelling Algorithm
Finds the optimum way to spell the pitches of a `PitchSet`, with a resolution of up to an eighth-tone.

A pitch set (in this case, an unordered, unique, unspelled collection of pitches) is composed of <sub>n</sub>C<sub>2</sub> dyads.

**Example**:
```Swift
// Consider a pitch set with midi note number values [62, 63, 66, 67]
let pitchSet: PitchSet = [
  Pitch(noteNumber: 62),
  Pitch(noteNumber: 63), 
  Pitch(noteNumber: 66), 
  Pitch(noteNumber: 67)
]

// In this case, there are 6 dyads
pitchSet.dyads == [
  Dyad(Pitch(noteNumber: 62), Pitch(noteNumber: 63)),
  Dyad(Pitch(noteNumber: 62), Pitch(noteNumber: 66)),
  Dyad(Pitch(noteNumber: 62), Pitch(noteNumber: 67)),
  Dyad(Pitch(noteNumber: 63), Pitch(noteNumber: 66)),
  Dyad(Pitch(noteNumber: 63), Pitch(noteNumber: 67)),
  Dyad(Pitch(noteNumber: 66), Pitch(noteNumber: 67))
]
```

When considering the most coherent pitch spelling for a pitch set, one could attempt to spell dyads wih certain interval classes first, to ensure that salient relationships are the clearest. In this case, the ordered is done [here](https://github.com/dn-m/PitchSpellingTools/blob/bean-comparisonstage/PitchSpellingTools/IntervalClass%2BPitchSpelling.swift). 







### Rules not yet considered
- Spelling preferences guided by ascending / descending linear structures

