 (
// run this first
SynthDef("imp", {
	var sig, ender;
	sig = Impulse.ar(freq: 1);
	DetectSilence.ar(in: sig, amp: 0.001, time: 0.01, doneAction: 2);
	sig = Pan2.ar(in: sig, pos: 0);
	Out.ar(bus: 0, channelsArray: sig);
}).add;
)

(
// run this second
var create_clock, win, clock;

create_clock = {

	if(clock.notNil, {clock.clear});

	clock = TempoClock.new(tempo: 2);  // as in: "2 beat per second"

	/* clocks can schedule functions in time, and if these functions end with a number, then that number is the number of beats in the future to re-schedule the functions.  This makes it easy to create cyclic behavior. */

	clock.schedAbs(clock.beats.ceil, { // schedule starting on the next whole beat
		Synth("imp"); // play the implulse
		1; // wait one beat then repeat
	});
};

win = Window.new(name: "press space-bar to set/reset metronome", bounds: 400@200);
win.alwaysOnTop=true;
win.front;

win.view.keyDownAction = {|view, char|
	if(char==$ , {
		create_clock.value;
	})
};

win.onClose = {if(clock.notNil, {clock.clear})}; // kill the clock if you close the window

)