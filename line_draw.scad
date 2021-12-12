//welcome to line_draw
//see https://github.com/cee-jay-aitch/line_draw
// GNU3.0



module cp_line_internal(point_array,t_array,e_array)
{
    union(){
        for (i=[0:1:len(point_array)-2]){   
            hull(){
                translate([point_array[i  ][0],point_array[i  ][1],0]){cylinder(r=t_array[i]  ,h=e_array[i]  ,center=false);}
                translate([point_array[i+1][0],point_array[i+1][1],0]){cylinder(r=t_array[i+1],h=e_array[i+1],center=false);}
            }
        }
    }
}


module cp_line(point_array,t,e)
{
    one_array=[for(i=[0:1:len(point_array)-1]) 1];
    cp_line_internal(point_array,t*one_array,e*one_array);
}    



//rectangles
function cp_rectangle_points(dx,dy)=[[dx,dy],[-dx,dy],[-dx,-dy],[dx,-dy],[dx,dy]]/2;
function cp_rectangle_points_delta(dx,dy,delta)=[[dx+delta,dy+delta],[-dx-delta,dy+delta],[-dx-delta,-dy-delta],[dx+delta,-dy-delta],[dx+delta,dy+delta]]/2;

module cp_rect(dx,dy,t,e)
{
    point_array=cp_rectangle_points(dx,dy);
    cp_line(point_array,t,e);
}

module ip_rect(dx,dy,t,e)
{
    cp_rect(dx+2*t,dy+2*t,t,e);
}

module op_rect(dx,dy,t,e)
{
    cp_rect(dx-2*t,dy-2*t,t,e);
}

//filled rectangles

module cp_rect_filled(dx,dy,t,e)
{
    union(){
        cp_rect(dx,dy,t,e);
        linear_extrude(height=e,center=false){polygon(points=cp_rectangle_points(dx,dy));};
    }
}

module ip_rect_filled(dx,dy,t,e)
{
    cp_rect_filled(dx+2*t,dy+2*t,t,e);
}

module op_rect_filled(dx,dy,t,e)
{
    cp_rect_filled(dx-2*t,dy-2*t,t,e);
}









            
