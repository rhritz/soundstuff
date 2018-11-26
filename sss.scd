(
{
  SinOsc.ar(400, 0, 0.1)
  +
  SinOsc.ar(888, 0, 0.1)
  +
  SinOsc.ar(1289, 0, 0.1)
	/*
  +
  SinOsc.ar(1623, 0, 0.1)
  +
  SinOsc.ar(2047, 0, 0.1)
  +
  SinOsc.ar(2416, 0, 0.1)
  +
  SinOsc.ar(2835, 0, 0.1)
  +
  SinOsc.ar(3266, 0, 0.1)
	*/
}.play;
)

{
({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 14)
* 400 + 500, 0.03, 0.003)}!2)
+ ({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 20)
* 800 + 1000, 0.03, 0.005)}!2)
* 4
}.play;

// This one-liner by Lance Putnam is an example of SuperCollider’s expressive power.
// It modulates the pitch of a single sine-wave oscillator.

play{SinOsc.ar(
	OnePole.ar(
		Mix(
         LFSaw.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1]),0.98
		)
     ).dup*0.1
}

// http://supercollider.sourceforge.net/audiocode-examples/
// http://doc.sccode.org/Guides/GUI-Introduction.html

// http://doc.sccode.org/Classes/FSinOsc.html

// http://doc.sccode.org/Classes/DynKlang.html

// modulate a sine frequency and a noise amplitude with another sine
// whose frequency depends on the horizontal mouse pointer position
{
        var x = SinOsc.ar(MouseX.kr(1, 100));
        SinOsc.ar(300 * x + 800, 0, 0.1)
        +
        PinkNoise.ar(0.1 * x + 0.1)
}.play;

// http://doc.sccode.org/Classes/LFPar.html

// http://doc.sccode.org/Tutorials/Streams-Patterns-Events1.html

// http://doc.sccode.org/Classes/MultiSliderView.html

// http://doc.sccode.org/Browse.html#UGens%3EReverbs

// http://doc.sccode.org/Classes/AtsFile.html

// http://doc.sccode.org/Tutorials/Mark_Polishook_tutorial/13_BinaryOp_synthesis.html#Additive%2520Synthesis

// http://doc.sccode.org/Tutorials/Mark_Polishook_tutorial/15_Groups.html

// comb example
(
{
    CombN.ar(
        SinOsc.ar(500.rrand(1000), 0, 0.2) * Line.kr(1, 0, 0.1),
        0.3,
        0.25,
        6
    )
}.scope;
)


(
{
var s, z, y;
    // 10 voices of a random sine percussion sound :
s = Mix.ar(Array.fill(10, { Resonz.ar(Dust.ar(0.2, 50), 200 + 3000.0.rand, 0.003)}) );
    // reverb predelay time :
z = DelayN.ar(s, 0.048);
    // 7 length modulated comb delays in parallel :
y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, LFNoise1.kr(0.1.rand, 0.04, 0.05), 15) }));
    // two parallel chains of 4 allpass delays (8 total) :
4.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1) });
    // add original sound to reverb and play it :
s+(0.2*y)
}.scope
)

// http://doc.sccode.org/Tutorials/Streams-Patterns-Events1.html

