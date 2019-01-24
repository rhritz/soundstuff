
SynthDef("sine", {arg freq,amp,fxOut,fxLvl;
	var x;
	x = SinOsc.ar(freq,0,amp);
	Out.ar(0,x!2);
	Out.ar(fxOut,x*fxLvl);
}).store;

SynthDef("reverb", {arg in, amp;
	var x;
	x = In.ar(in);
	x = GVerb.ar(x,57,57,0.7,spread:15);
	Out.ar(0,x*amp);
}).store;


(
var fx, osc, reverb;

fx = Bus.audio(s,1);
osc = Synth("sine", [\freq, 100, \amp, 0.5, \fxOut, fx.index], s);
reverb = Synth("reverb", [\in, fx.index, \amp, 0.5], s, \addToTail);

Task({
	var harmonics;
	loop({
		harmonics = rrand(2,20); // random integer between 2 and 20
		harmonics.do({arg i; // do this "harmonics" # of times, i is the iterator
			osc.set(\freq, i*100, \fxLvl, i * 0.02);
			0.1.wait;
		});
	});
}).play;
)