

// Edge rule generation:

|             A           |            B            | Rule broken?            |
|-------------------------|-------------------------|-------------------------|
| c natural               | c natural up            | unisons                 |
| --                      | c quarterSharp down     | no unisons              |
| --                      | d threeQuarterFlat down | good                    |
| --                      | d bb up                 | good                    |
| -- 					  | b sharp up              | reacharound             |
| d bb                    | c natural up 		    | reacharound 			  |
| -- 					  | c q


// 60.0:
c natural
d bb
b sharp

// 60.25
c natural up
c quarterSharp down
d threeQuarterFlat down
d bb up
b sharp up

// 60.0 : 60.25
c natural : c natural up // no unisons
c natural : c quarterSharp down // no unisons
c natural : d threeQuarterFlat down // all good
c natural : d bb up // fine, though d bb has node penalty
c natural : b sharp up // reacharound

d bb : c natural up // reacharound
d bb : c quarterSharp down // reacharound
d bb : d threeQuarterFlat down // reacharound good
d bb : d bb up // no unisons
d bb : b sharp up // quarterStepModifier compatibility

b sharp : c natural up // fine, though b sharp has node penalty
b sharp : c quarterSharp down // all good
b sharp : d threeQuarterFlat down // quarterStepModifier compatibility
b sharp : d bb up // quarterStepModifier compatibility
b sharp : b sharp up // no unisons

// -----------------------------------------------------------------------

// 60 60.5
// 60.5
c quarterSharp
d threeQuarterFlat
b threeQuarterSharp

c natural : c quarterSharp
c natural : d threeQuarterFlat
c natural : b threeQuarterSharp



// 60 60.75

// 60 61

// c c#

