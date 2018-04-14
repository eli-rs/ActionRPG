
var frames = argument0;
var start_val = argument1;
var end_val = argument2;

var t = 1 / frames;

var new_val = start_val + (t * (end_val - start_val));
return new_val;