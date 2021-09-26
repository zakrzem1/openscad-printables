use <MCAD/boxes.scad>
$fa=1;
$fs=0.4;
wall_thickness=3;
wall_thickerness=wall_thickness+1;
wall_screw_hole_diameter=5.5;
shower_pipe_hole_diameter=8;
shower_pipe_hole_thickness=6;
shower_pipe_hole_wall_distance=8;
mount_diameter=44;
pipe_diameter=20;
height=170; // 85
depth=64; // 32
wall_plate_cube_y_transposition=height - (mount_diameter/2);
wall_plate_cube_x_transposition=mount_diameter/2;
epsilon=0.1;
// pipeholder pipe-support
pipeholder_support_z_displacement=depth-pipe_diameter/2;
pipeholder_support_length=sqrt(pipeholder_support_z_displacement*pipeholder_support_z_displacement + wall_plate_cube_y_transposition*wall_plate_cube_y_transposition);
pipeholder_support_y_offset=wall_plate_cube_y_transposition-pipe_diameter/2;
pipeholder_support_angle=atan(pipeholder_support_y_offset/pipeholder_support_z_displacement);
echo("This is pipeholder_support_angle=", pipeholder_support_angle);
//roundedBox(size=[129,73,140],radius=1,sidesonly=true);

// pipeholder extruded triangle support

union(){
    // wall plate
    difference(){
        union(){
            cylinder(h=wall_thickerness, r=mount_diameter / 2);
            * translate([-wall_plate_cube_x_transposition,-wall_plate_cube_y_transposition,0]){
                // plate - cube
                cube([
                    mount_diameter,
                    wall_plate_cube_y_transposition+epsilon,
                    wall_thickerness
                ], false);                
            }
            // plate - extruded shape, narrowing down
            translate([-wall_plate_cube_x_transposition,0,0]){
                linear_extrude(height = wall_thickerness, center = false, convexity = 10, twist = 0) // , scale=3
                    polygon(points=[
                        [0,0],
                        [mount_diameter,0],
                        [mount_diameter-pipe_diameter/2+epsilon,-wall_plate_cube_y_transposition],
                        [pipe_diameter/2-epsilon,-wall_plate_cube_y_transposition]]);
            }
            
        }
        // wall screw hole
        translate([0,0,-epsilon]){
            cylinder(h=wall_thickerness+2*epsilon, r=wall_screw_hole_diameter / 2);
        }
    }
    // pipe holder
    difference(){
        // external
        cylinder(h=depth, r=pipe_diameter/2 + wall_thickness);
        // internal
        cylinder(h=depth+epsilon, r=pipe_diameter/2);
    }
    // pipeholder pipe-support
    * translate([0,-pipeholder_support_y_offset,0]){
        rotate([-pipeholder_support_angle,0,0])
        union(){
            cylinder(h=pipeholder_support_length, r=pipe_diameter / 2);        
        }
    }
    // pipeholder extruded-triangle-support
    difference(){
        translate([-pipe_diameter/2,0,0]){
            rotate([-90,0,-90])
            linear_extrude(height = pipe_diameter, center = false, convexity = 10, twist = 0)
            polygon(points=[[0,0],[pipeholder_support_y_offset,0],[0,-depth]]);
        }
        cylinder(h=depth, r=pipe_diameter/2);
    }

}



/*
difference(){
    cube([box_length,box_width, box_height], false); //base cube
    union(){
        // kostka drążąca górna:
        translate([wall_thickness,wall_thickness,box_front_height]){
            cube([
                box_length-2*wall_thickness,
                box_width-2*wall_thickness,
                box_height - box_front_height+3*wall_thickness
            ], false); 
        }
        // kostka drążąca dolna
        translate([wall_thickness,wall_thickness,wall_thickness]){
            cube([box_length-2*wall_thickness,box_width-2*wall_thickness,box_front_height-2*wall_thickness], false); 
        }
        translate([side_rim_width_left,front_rim_width,generic_rim_height]){
            cube([powersupply_length, powersupply_width+2*wall_thickness, box_height], false); // kostka drążąca msce na zasilacz
        }
        translate([-wall_thickness,-wall_thickness,box_front_height]){
            cube([
                box_length+2*wall_thickness,
                box_width-generic_rim_width,
                box_height - box_front_height+3*wall_thickness
            ], false); // kostka drążąca górna odsłaniająca front
        }
        // skosic prawy słupek
        translate([side_rim_width_left,4*wall_thickness,box_front_height]){
            cube([
                box_length,
                box_width,
                box_height - box_front_height+3*wall_thickness
            ], false); // kostka drążąca górna
        }        
        // dziura w podłodze:
        translate([generic_rim,generic_rim_width,-2*wall_thickness]){
            cube([box_length-2*generic_rim, box_width-2*generic_rim_width, box_height - box_front_height - 2*wall_thickness], false);
        }
        // dziura domkowa w lewej sciance:
        translate([-2*wall_thickness,generic_rim_width,generic_rim_height]){
            rotate([90,0,90])
            linear_extrude(height = 4*wall_thickness, center = false, convexity = 10, twist = 0)
            polygon(points=[[0,0],[domku_width,0],[domku_width,h_domku-h_daszka],[domku_width/2,h_domku], [0,h_domku-h_daszka]]);
        }
        // dziura na gniazdo zasilania 
        translate([socket_offset_x,-wall_thickness,socket_offset_z]){
            cube([socket_length,4*wall_thickness,socket_height], false); 
        }

    }
}
*/
/*difference() {
    cube(30, center=true);
    sphere(20);
}
translate([0, 0, 30]) {
    cylinder(h=40, r=10);
}
#box(3,4,5);
*/