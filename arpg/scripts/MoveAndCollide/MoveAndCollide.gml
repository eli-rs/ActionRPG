var xmovement = argument0;
var ymovement = argument1;

	
//Horizontal collision to avoid getting stuck in wall
if (place_meeting(obj_player.x  + xmovement, obj_player.y  + ymovement, obj_player))
{
	show_debug_message("THERE WILL BE A COLLISION, TRYING TO APPROACH COLLISION WITHOUT TOUCHING IT:");
	while (!place_meeting(obj_player.x +sign(xmovement), obj_player.y +sign(ymovement),obj_player))
	{
		obj_player.x += sign(xmovement);
		obj_player.y += sign(ymovement);
	}
} 
else
{
	obj_player.x += xmovement;
	obj_player.y += ymovement;
}