### Eighth-tone PitchSet Spelling Algorithm
Finds the optimum way to spell the pitches of a `PitchSet`, with a resolution of up to an eighth-tone.

A pitch set (in this case, an unordered, unique, unspelled collection of pitches) is composed of <sub>n</sub>C<sub>2</sub> dyads.

**Example**:
```Swift
// Consider a pitch set with midi note number values [62,63,66,67]
let pitchSet: PitchSet = [
  Pitch(noteNumber: 62),
  Pitch(noteNumber: 63), 
  Pitch(noteNumber: 66), 
  Pitch(noteNumber: 67)
]
pitchSet.dyads == [
  Dyad(Pitch(noteNumber: 62), Pitch(noteNumber: 63)),
  Dyad(Pitch(noteNumber: 62), Pitch(noteNumber: 66)),
  Dyad(Pitch(noteNumber: 62), Pitch(noteNumber: 67)),
  Dyad(Pitch(noteNumber: 63), Pitch(noteNumber: 66)),
  Dyad(Pitch(noteNumber: 63), Pitch(noteNumber: 67)),
  Dyad(Pitch(noteNumber: 66), Pitch(noteNumber: 67))
]
```
