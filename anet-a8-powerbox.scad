use <MCAD/boxes.scad>
$fa=1;
$fs=0.4;
wall_thickness=1.5;
box_length=129;
box_width=73;
box_height=140;
box_front_height=80;
powersupply_width=50;
powersupply_length=109;
front_rim_width=box_width - powersupply_width;
generic_rim=10;
generic_rim_height=generic_rim;
generic_rim_width=generic_rim;
side_rim_width_left=17;
side_rim_width_right=box_length-powersupply_length-side_rim_width_left;
overhang_angle=50;
h_domku=box_front_height-2*generic_rim_height;
domku_width=box_width-2*generic_rim_width;
h_daszka=h_domku-domku_width/2*tan(90-overhang_angle-0.5);
socket_length=27;
socket_height=56;
socket_offset_x=22; 
socket_offset_z=10;
//roundedBox(size=[129,73,140],radius=1,sidesonly=true);

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

/*difference() {
    cube(30, center=true);
    sphere(20);
}
translate([0, 0, 30]) {
    cylinder(h=40, r=10);
}
#box(3,4,5);
*/