### Eighth-tone PitchSet Spelling Algorithm
Finds the optimum way to spell the pitches of a `PitchSet`, with a resolution of up to an eighth-tone.

A pitch set (in this case, an unordered, unique, unspelled collection of pitches) is composed of <sub>n</sub>C<sub>2</sub> dyads.

**Example**:
```
pitchSet = [62, 63, 66, 67] // midi nn
pitchSet.dyads = [[62,63],[62,66],[62,67],[63,66],[63,67],[66,67]]
```
