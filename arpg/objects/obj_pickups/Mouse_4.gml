// Begin interacting

if (isInteracting == false && obj_player.isInteracting == false &&
	point_distance(x, y, obj_player.x, obj_player.y) <= pickupRadius)
{
	isInteracting = true;
	obj_player.isInteracting = true;
	obj_player.interactingWithID = id;
}