SynthDef(\kablooie, { |x = 0|
   "x: ".post; x.postln;
   "(x > 0): ".post; (x > 0).postln;
});

// Choosing one of two signals
// Select.kr(aKrSignal > anotherKrSignal, [false_signal, true_signal]);

// Generating triggers:
// A trigger occurs whenever a signal is <= 0, and then becomes > 0.
// For a simple example, take the case of sending a message to the language when the microphone input’s amplitude crosses a threshold.
// var mic = In.ar(8, 1),
//   amplitude = Amplitude.kr(mic);
// SendTrig.kr(amplitude > 0.2, 0, amplitude);
// timer = Timer.kr(trig),  // how long since the last trigger?

// Supplying the freq argument with an erronous value
SynthDef(\mySynthDef, {
    arg out=440, freq = 'this should not work';

    var sig = SinOsc.ar([freq, freq*1.01]);

    Out.ar(out, sig )
}, rates:  0.1).add;

// Doesn't produce any errors
Synth(\mySynthDef);

// http://supercollider.sourceforge.net/wiki/index.php/User_FAQ

// ( // run these first
SynthDef("spaceySynth", { arg freq, out;
	var x, env;
	x = RLPF.ar(
		LFSaw.ar( freq, mul: EnvGen.kr( Env.perc, levelScale: 0.3, doneAction: 2 ) ),
		LFNoise1.kr(2, 36, 110).midicps,
		0.2
	);
	Out.ar(out, x);
}).store;

SynthDef("reverb", {arg in;
	var x;
	x = In.ar(in);
	6.do({ x = AllpassN.ar(x, 0.05, [0.05.rand, 0.05.rand], 4) });
	Out.ar(0, x);
}).store;


(
var bus, groups;
bus = Bus.audio(s,1);
groups = Array.fill(2, {Group.new(s,\addToTail)});
Synth("reverb", [\in, bus.index], groups[1]);

Pbind(
	\instrument, "spaceySynth",
	\freq, Pseq( // Pseq = sequenced pattern
		[
			// bass run, happens half the time
			Prand([nil, Pseq(#[24, 31, 36, 43, 48, 55])]),

 			// middle bit - happens 2 to 5 times
			Pseq([60, Prand(#[63, 65]), 67, Prand(#[70, 72, 74]) ], {rrand(2, 5)}),

			// ending melody of 3 to 9 notes
			Prand(#[74, 75, 77, 79, 81], {rrand(3, 9)})
		].midicps,
	inf),
	\dur, 0.13,
	\group, groups[0].nodeID,
	\out, bus.index
).play;
)