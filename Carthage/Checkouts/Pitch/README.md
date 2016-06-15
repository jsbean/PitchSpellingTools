# Pitch

[![Build Status](https://travis-ci.org/dn-m/Pitch.svg?branch=master)](https://travis-ci.org/dn-m/Pitch)

## Create a `Pitch`

You can create a `Pitch` value in a variety of ways:

### MIDI NoteNumber or Frequency
```Swift
let pitchWithNoteNumber = Pitch(noteNumber: 60) // middle c
let pitchWithFrequency = Pitch(frequency: 440) // a below middle c
```
In either case, you can retrieve the MIDI NoteNumber or frequency:

```Swift
let nn = pitchWithFrequency.noteNumber
let freq = pitchWithNoteNumber.frequency
```

### FloatLiteral or IntegerLiteral

You can create a `Pitch` with only a `FloatLiteral` or an `IntegerLiteral`. In this case, the `Pitch` value is instaniated using the given literal as the MIDI `NoteNumber`.

```Swift
let pitchWithInt: Pitch = 60 // middle c
let pitchWithFloat: Pitch = 72.25 // eighth-tone above the octave above middle c
```
