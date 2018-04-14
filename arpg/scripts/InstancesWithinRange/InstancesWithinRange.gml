
// the x and y coordinates that we are looking for objects near
var origin_x = argument0;
var origin_y = argument1;
// the distance from origin within which we are looking for objects
var radius = argument2; 
// the type of object that we are looking for instances of
var obj = argument3;

var total_instances = instance_number(obj);

var instances = ds_list_create();
var closest_dist = 10000;
var closest_inst = noone;
var closest_idx = -1;
for (var i = 0; i < total_instances; i++)
{
	var inst = instance_find(obj, i);
	var distance = point_distance(origin_x, origin_y, inst.x, inst.y)
	if (distance <= radius)
	{
		ds_list_add(instances, inst);
		if (distance < closest_dist)
		{
			closest_dist = distance;
			closest_inst = inst;
			closest_idx = i;
		}
	}
}
// if we found one or more instances within radius, return them all but put the closest one in front
// of list for simplicity when accessing later
if (closest_inst != noone) 
{
	ds_list_delete(instances, closest_idx);
	ds_list_insert(instances, 0, closest_inst);
}
return instances;