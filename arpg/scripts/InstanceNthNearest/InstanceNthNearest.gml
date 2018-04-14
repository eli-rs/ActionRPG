/// instance_nth_nearest(x,y,obj,n)
//
//  Returns the id of the nth nearest instance of an object
//  to a given point or noone if none is found.
//
//      x,y       point coordinates, real
//      obj       object index (or all), real
//      n         proximity, real
//
/// 

// IF WE NEED ONLY THE CLOSEST OBJECT, USE INSTANCE_NEAREST()
{
    var pointx,pointy,object,n,list,nearest;
	
    var pointx = argument0;
    var pointy = argument1;
    var object = argument2;
	
    var n = argument3;
    n = min(max(1,n),instance_number(object));
    var list = ds_priority_create();
    var nearest = noone;
    with (object) ds_priority_add(list,id,distance_to_point(pointx,pointy));
    repeat (n) nearest = ds_priority_delete_min(list);
    ds_priority_destroy(list);
    return nearest;
}