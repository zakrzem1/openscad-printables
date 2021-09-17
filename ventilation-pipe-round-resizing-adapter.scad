$fa=1;
$fs=0.4;
wall_thickness=1.5;
epsilon=0.2;
lowerpart_height=67;
lowerpart_fi= 120; // internal diameter
upperpart_fi_pipe_internal = 101.4;
upperpart_fi = upperpart_fi_pipe_internal - wall_thickness; // internal
middlepart_height=30;
upperpart_height=30;
union(){
    // lower part
    difference(){
        // lower part - external
        cylinder(h=lowerpart_height, r=(lowerpart_fi + wall_thickness) / 2);
        // lower part - internal
        translate([0,0,-epsilon]){
            cylinder(h=lowerpart_height+2*epsilon, r=lowerpart_fi / 2);
        }
    }
    // middle part (adapter)
    translate([0,0,lowerpart_height - epsilon]){
        difference(){
            // external
            cylinder(h=middlepart_height, r1=(lowerpart_fi + wall_thickness) / 2, r2=(upperpart_fi + wall_thickness) / 2);
            // internal
            translate([0,0,-epsilon]){
                cylinder(h=middlepart_height+2*epsilon, r1=lowerpart_fi / 2, r2=upperpart_fi / 2);
            }
        }
    }
    //upper part
    translate([0,0,lowerpart_height + middlepart_height - epsilon]){
        difference(){
            // upper part - external
            cylinder(h=upperpart_height, r=(upperpart_fi + wall_thickness) / 2);
            // upper part - internal
            translate([0,0,-epsilon]){
                cylinder(h=lowerpart_height+2*epsilon, r=upperpart_fi / 2);
            }
        }
    }
    
}

//difference(){
//    cube([box_length,box_width, box_height], false); //base cube
//    union(){
//        // kostka drążąca górna:
//        translate([wall_thickness,wall_thickness,box_front_height]){
//            cube([
//                box_length-2*wall_thickness,
//                box_width-2*wall_thickness,
//                box_height - box_front_height+3*wall_thickness
//            ], false); 
//        }
//        // kostka drążąca dolna
//        translate([wall_thickness,wall_thickness,wall_thickness]){
//            cube([box_length-2*wall_thickness,box_width-2*wall_thickness,box_front_height-2*wall_thickness], false); 
//        }
//        translate([side_rim_width_left,front_rim_width,generic_rim_height]){
//            cube([powersupply_length, powersupply_width+2*wall_thickness, box_height], false); // kostka drążąca msce na zasilacz
//        }
//        translate([-wall_thickness,-wall_thickness,box_front_height]){
//            cube([
//                box_length+2*wall_thickness,
//                box_width-generic_rim_width,
//                box_height - box_front_height+3*wall_thickness
//            ], false); // kostka drążąca górna odsłaniająca front
//        }
//        // skosic prawy słupek
//        translate([side_rim_width_left,4*wall_thickness,box_front_height]){
//            cube([
//                box_length,
//                box_width,
//                box_height - box_front_height+3*wall_thickness
//            ], false); // kostka drążąca górna
//        }        
//        // dziura w podłodze:
//        translate([generic_rim,generic_rim_width,-2*wall_thickness]){
//            cube([box_length-2*generic_rim, box_width-2*generic_rim_width, box_height - box_front_height - 2*wall_thickness], false);
//        }
//        // dziura domkowa w lewej sciance:
//        translate([-2*wall_thickness,generic_rim_width,generic_rim_height]){
//            rotate([90,0,90])
//            linear_extrude(height = 4*wall_thickness, center = false, convexity = 10, twist = 0)
//            polygon(points=[[0,0],[domku_width,0],[domku_width,h_domku-h_daszka],[domku_width/2,h_domku], [0,h_domku-h_daszka]]);
//        }
//        // dziura na gniazdo zasilania 
//        translate([socket_offset_x,-wall_thickness,socket_offset_z]){
//            cube([socket_length,4*wall_thickness,socket_height], false); 
//        }
//
//    }
//}

/*difference() {
    cube(30, center=true);
    sphere(20);
}
translate([0, 0, 30]) {
    cylinder(h=40, r=10);
}
#box(3,4,5);
*/