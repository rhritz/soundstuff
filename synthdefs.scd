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