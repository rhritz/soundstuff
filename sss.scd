(
{
	SinOsc.ar(100, 0, 0.1)
  +
  SinOsc.ar(200, 0, 0.4)
  +
  SinOsc.ar(400, 0, 0.2)
	+
  SinOsc.ar(599, 0, 0.05)
  +
  SinOsc.ar(600, 0, 0.05)
  +
  SinOsc.ar(601, 0, 0.05)
  +
  SinOsc.ar(602, 0, 0.05)
  +
  SinOsc.ar(603, 0, 0.05)
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
}.scope;
)

{
	Pan2.ar( SinOsc.ar(300, 0, 0.3) + SinOsc.ar(100, 0, 0.1) +  SinOsc.ar(200, 0, 0.4), SinOsc.ar( SinOsc.ar(0.1, 0, 5), 0, 1))
	+
	Pan2.ar( SinOsc.ar(500, 0, 0.1) + SinOsc.ar(600, 0, 0.1) +  SinOsc.ar(700, 0, 0.1), SinOsc.ar( SinOsc.ar(0.1, 1, 5), 1, 1))
}.scope;

// SinOsc.ar(1, 0, 1)
{SinOsc.ar(1, 0, 1, -1)}.scope;

{Pan2.ar(WhiteNoise.ar(0.1), MouseX.kr(-1,1))}.scope;

// ---------------------------------------------------------------------------
// modulate the frequency with an exponential ramp
{ SinOsc.ar(XLine.kr(2000, 200), 0, 0.5) }.play;

// more complex frequency modulation
{ SinOsc.ar(SinOsc.ar(XLine.kr(1, 1000, 9), 0, 200, 800), 0, 0.25) }.play;

// phase modulation (see also PMOsc)
{ SinOsc.ar(800, SinOsc.ar(XLine.kr(1, 1000, 9), 0, 2pi), 0.25) }.play;

// ---------------------------------------------------------------------------
// Bell:
{Mix(SinOsc.ar(500*[0.5,1,1.19,1.56,2,2.51,2.66,3.01,4.1],0,0.1))}.scope;
// Bell spectra, different volumes for partials
{Pan2.ar(SinOsc.ar(500*[0.5,1,1.19,1.56,2,2.51,2.66,3.01,4.1],0,0.1*[0.25,1,0.8,0.5,0.9,0.4,0.3,0.6,0.1]), 0)}.scope;
// Here is a generalisable patch that uses the variable n to hold the number of sine tones desired for each run of the code:
(
var n = 10;
{Mix(SinOsc.ar(250*(1..n),0,1/n))}.scope;
)

(
{
	SinOsc.ar(300, 0, 0.3)
  +
  SinOsc.ar(366, 0, 0.2)
  +
  SinOsc.ar(432, 0, 0.2)
	+
  SinOsc.ar(500, 0, 0.2)

}.scope;
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

// fasa veci:
{PMOsc.ar(300,575,2,mul:0.3).dup}.play;

Routine({
	loop{
		{
			LinPan2.ar(
				EnvGen.ar(Env.linen(2, 5, 2), doneAction: 2)
				*
				PMOsc.ar(2000.rand, 800.rand, Line.kr(0.0, 12.0.rand, 9), 0, 0.1),
				1.0.rand2
			)
		}.play;
		2.wait;
	};
}).play;

// TODO rand.. co tak skusit samplovat z inej distribucie?