$fn=100;

case_x = 114;
case_y = 91.8;
case_z = 41.8;
case_thickness = 2 ;

top_case_thickness = case_thickness ;
top_case_border = 6 ;

screw_support_x = 10 ;
screw_support_y = 5 ;
screw_support_z = 10 ;

nut_d = 6 ;
nut_t = 3 ;
nut_face_count = 6 ;

module mark(size) {
    color("red") {
        sphere(r=size);
    }
}
    
module hex_nut_die(nut_diameter, nut_thickness, faces_count) {
    diameter_outer = nut_diameter;  // Diamètre extérieur de l'écrou
    thickness = nut_thickness;       // Épaisseur de l'emporte-pièce

    difference() {
        cylinder(d=diameter_outer, h=thickness, $fn=faces_count, center=true);
    }
}

module rpi_case() {
    union() {
        difference() {
            cube([case_x, case_y, case_z],center=true);
            translate([0,case_thickness,case_thickness]) {
                cube([case_x-case_thickness * 2, case_y, case_z],center=true);
            }
        }

        translate([0,-case_y/2+case_thickness/2,case_z/2+(top_case_thickness + 0.2)/2]) {
            cube([case_x,case_thickness, top_case_thickness + 0.2],center=true);
            translate([0,top_case_border/2-case_thickness/2,(top_case_thickness + 0.2)/2+top_case_thickness/2]) {
                cube([case_x,top_case_border,case_thickness],center=true);
            }
        }

        translate([-case_x/2+case_thickness/2,case_y/2,case_z/2]) {
            translate([+screw_support_x/2-case_thickness/2,-screw_support_y/2,-screw_support_z/2]) {
                difference() {
                    difference() {
                        cube([screw_support_x,screw_support_y,screw_support_z],center=true);
                        translate([0,-screw_support_y/2+nut_t/2-0.1,0]) {
                            rotate([90,0,0]) {
                                hex_nut_die(nut_d,nut_t,nut_face_count);
                            }
                        }
                    }
                    rotate([90,0,0]) {
                        cylinder(h=10,d=3,center=true);
                    }
                }
            }
        }
        translate([-case_x/2+case_thickness/2,case_y/2,-case_z/2]) {
            translate([+screw_support_x/2-case_thickness/2,-screw_support_y/2,+screw_support_z/2]) {
                difference() {
                    difference() {
                        cube([screw_support_x,screw_support_y,screw_support_z],center=true);
                        translate([0,-screw_support_y/2+nut_t/2-0.1,0]) {
                            rotate([90,0,0]) {
                                hex_nut_die(nut_d,nut_t,nut_face_count);
                            }
                        }
                    }
                    rotate([90,0,0]) {
                        cylinder(h=10,d=3,center=true);
                    }
                }
            }
        }
        translate([case_x/2-case_thickness/2,case_y/2,-case_z/2]) {
            translate([-screw_support_x/2+case_thickness/2,-screw_support_y/2,+screw_support_z/2]) {
                difference() {
                    difference() {
                        cube([screw_support_x,screw_support_y,screw_support_z],center=true);
                        translate([0,-screw_support_y/2+nut_t/2-0.1,0]) {
                            rotate([90,0,0]) {
                                hex_nut_die(nut_d,nut_t,nut_face_count);
                            }
                        }
                    }
                    rotate([90,0,0]) {
                        cylinder(h=10,d=3,center=true);
                    }
                }
            }
        }
        translate([case_x/2-screw_support_x/2-case_thickness,0,case_z/2-screw_support_y/2]) {
            rotate([90,0,0]) {
                difference() {
                    difference() {
                        cube([screw_support_x,screw_support_y,screw_support_z],center=true);
                        translate([0,-screw_support_y/2+nut_t/2-0.1,0]) {
                            rotate([90,0,0]) {
                                hex_nut_die(nut_d,nut_t,nut_face_count);
                            }
                        }
                    }
                    rotate([90,0,0]) {
                        cylinder(h=10,d=3,center=true);
                    }
                }
            }
        }
        translate([-case_x/2+screw_support_x/2+case_thickness,0,case_z/2-screw_support_y/2]) {
            rotate([90,0,0]) {
                difference() {
                    difference() {
                        cube([screw_support_x,screw_support_y,screw_support_z],center=true);
                        translate([0,-screw_support_y/2+nut_t/2-0.1,0]) {
                            rotate([90,0,0]) {
                                hex_nut_die(nut_d,nut_t,nut_face_count);
                            }
                        }
                    }
                    rotate([90,0,0]) {
                        cylinder(h=10,d=3,center=true);
                    }
                }
            }
        }
    }
}

module drilling(diameter, lenght, thickness) {
    hull() {
        translate([0,lenght/2-diameter/2,0]) {
            rotate([0,90,0])
            cylinder(h=thickness, d=diameter, center=true);
        }
        translate([0,-lenght/2+diameter/2,0]) {
            rotate([0,90,0])
            cylinder(h=thickness, d=diameter, center=true);
        }
    }
}

drilling_diameter = 3 ;
drilling_length = 10 ;
drilling_thickness = 3 ;

drilling_space = 2 ;

drilling_alim_jack_diameter = 8 ;
drilling_alim_jack_length = 58 ;
drilling_alim_jack_thickness = 3 ;

module rpi_case_aeration() {
    difference() {
        rpi_case() ;
        translate([case_x/2-case_thickness/2,-1*(drilling_length+drilling_space),case_z/2-4*case_z/10]) {
            drilling(drilling_alim_jack_diameter,drilling_alim_jack_length,drilling_alim_jack_thickness);
        }
        
        translate([case_x/2-case_thickness/2,0,case_z/2-3*case_z/10]) {
            for(i = [2:3]) {
                translate([0,i*(drilling_length+drilling_space),0]) {
                    drilling(drilling_diameter,drilling_length,drilling_thickness);
                }
            }
        }

        translate([case_x/2-case_thickness/2,0,case_z/2-4*case_z/10]) {
            for(i = [2:3]) {
                translate([0,i*(drilling_length+drilling_space),0]) {
                    drilling(drilling_diameter,drilling_length,drilling_thickness);
                }
            }
        }

        translate([-(case_x/2-case_thickness/2),0,case_z/2-3*case_z/10]) {
            drilling(drilling_diameter,drilling_length,drilling_thickness);
            for(i = [1:3]) {
                translate([0,i*(drilling_length+drilling_space),0]) {
                    drilling(drilling_diameter,drilling_length,drilling_thickness);
                }
                translate([0,-i*(drilling_length+drilling_space),0]) {
                    drilling(drilling_diameter,drilling_length,drilling_thickness);
                }
            }
        }

        translate([-(case_x/2-case_thickness/2),0,case_z/2-4*case_z/10]) {
            drilling(drilling_diameter,drilling_length,drilling_thickness);
            for(i = [1:3]) {
                translate([0,i*(drilling_length+drilling_space),0]) {
                    drilling(drilling_diameter,drilling_length,drilling_thickness);
                }
                translate([0,-i*(drilling_length+drilling_space),0]) {
                    drilling(drilling_diameter,drilling_length,drilling_thickness);
                }
            }
        }
        
        translate([0,-case_y/2+case_thickness/2,case_z/2-1*case_z/10]) {
            rotate([0,0,90]) {
                drilling(drilling_diameter,drilling_length,drilling_thickness);
            }
            for(i = [1:4]) {
                translate([i*(drilling_length+drilling_space),0,0]) {
                    rotate([0,0,90]) {
                        drilling(drilling_diameter,drilling_length,drilling_thickness);
                    }
                }
                translate([-i*(drilling_length+drilling_space),0,0]) {
                    rotate([0,0,90]) { 
                        drilling(drilling_diameter,drilling_length,drilling_thickness);
                    }
                }
            }
        }

        translate([0,-case_y/2+case_thickness/2,case_z/2-3*case_z/10]) {
            rotate([0,0,90]) {
                drilling(drilling_diameter,drilling_length,drilling_thickness);
            }
            for(i = [1:3]) {
                translate([i*(drilling_length+drilling_space),0,0]) {
                    rotate([0,0,90]) {
                        drilling(drilling_diameter,drilling_length,drilling_thickness);
                    }
                }
                translate([-i*(drilling_length+drilling_space),0,0]) {
                    rotate([0,0,90]) { 
                        drilling(drilling_diameter,drilling_length,drilling_thickness);
                    }
                }
            }
        }    
    }
}

module top_drilling() {
    rotate([0,90,90]) {
        drilling(drilling_diameter,drilling_length,drilling_thickness);
    }
}

module top_line_drilling() {
    top_drilling();
    for(i = [1:3]) {
        translate([i*(drilling_length+drilling_space),0,0]) {
            top_drilling();
        }
        translate([-i*(drilling_length+drilling_space),0,0]) {
            top_drilling();
        }
    }
}

module rpi_case_top() {
    difference() {
        cube([case_x, case_y-case_thickness, case_thickness],center=true);
        
        top_line_drilling();
        for(i = [1:4]) {
            translate([0,i*(drilling_diameter+2*drilling_space),0]) {
                top_line_drilling();
            }
            translate([0,-i*(drilling_diameter+2*drilling_space),0]) {
                top_line_drilling();
            }
        }
        translate([-case_x/2+screw_support_x/2+case_thickness,0,0]) {
            cylinder(h=10,d=3,center=true);
        }
        translate([+case_x/2-screw_support_x/2-case_thickness,0,0]) {
            cylinder(h=10,d=3,center=true);
        }
    }
}

module front_drilling() {
    rotate([0,0,90]) {
        drilling(drilling_diameter,drilling_length,drilling_thickness);
    }
}

module front_line_drilling() {
    for(i = [1:3]) {
        translate([-i*(drilling_length+drilling_space),0,0]) {
            front_drilling();
        }
    }
}

shift = 3 ;

usb_2_x = 4 + shift;
usb_2_y = 4 ;
usb_2_w = (19 + shift) - usb_2_x ;
usb_2_h = 21 - usb_2_y ;
usb_2_x_center = usb_2_x + usb_2_w/2 ;
usb_2_y_center = usb_2_y + usb_2_h/2 ;

usb_3_x = 22 + shift ;
usb_3_y = 4 ;
usb_3_w = (38 + shift) - usb_3_x ;
usb_3_h = 31 - usb_3_y ;
usb_3_x_center = usb_3_x + usb_3_w/2 ;
usb_3_y_center = usb_3_y + usb_3_h/2 ;

eth_x = 42 + shift ;
eth_y = 6 ;
eth_w = (58 + shift) - eth_x ;
eth_h = 21 - eth_y ;
eth_x_center = eth_x + eth_w/2 ;
eth_y_center = eth_y + eth_h/2;

module rpi_case_front() {
    difference() {
        difference() {
            echo("x=",case_x," z=",case_z+case_thickness);
            cube([case_x,case_thickness,case_z+case_thickness],center=true);
            front_line_drilling();
            for(i = [1:2]) {
                translate([0,0,i*(drilling_diameter+2*drilling_space)]) {
                    front_line_drilling();
                }
                translate([0,0,-i*(drilling_diameter+2*drilling_space)]) {
                    front_line_drilling();
                }
            }
        }
        translate([-case_x/2+case_thickness/2,0,case_z/2-case_thickness/2]) {
            translate([+screw_support_x/2-case_thickness/2,-screw_support_y/2,-screw_support_z/2]) {
                rotate([90,0,0]) {
                    cylinder(h=10,d=3,center=true);
                }
            }
        }
        translate([-case_x/2+case_thickness/2,0,-case_z/2-case_thickness/2]) {
            translate([+screw_support_x/2-case_thickness/2,-screw_support_y/2,+screw_support_z/2]) {
                rotate([90,0,0]) {
                    cylinder(h=10,d=3,center=true);
                }
            }
        }
        translate([case_x/2-case_thickness/2,0,-case_z/2-case_thickness/2]) {
            translate([-screw_support_x/2+case_thickness/2,-screw_support_y/2,+screw_support_z/2]) {
                rotate([90,0,0]) {
                    cylinder(h=10,d=3,center=true);
                }
            }
        }
        translate([case_x/2-usb_2_x_center,0,(case_z+case_thickness)/2-usb_2_y_center]) {
            cube([usb_2_w,2*case_thickness,usb_2_h],center=true);
        }
        translate([case_x/2-usb_3_x_center,0,(case_z+case_thickness)/2-usb_3_y_center]) {
            cube([usb_3_w,2*case_thickness,usb_3_h],center=true);
        }
        translate([case_x/2-eth_x_center,0,(case_z+case_thickness)/2-eth_y_center]) {
            cube([eth_w,2*case_thickness,eth_h],center=true);
        }

    }
}

rpi_case_aeration() ;
translate([0,case_thickness/2,case_z/2+case_thickness/2]) {
    color("silver") {
        rpi_case_top();
    }
}

translate([0,case_y/2+case_thickness/2,case_thickness/2]) {
    color("gray") {
        rpi_case_front() ;
    }
}

//rpi_case_top();
//rotate([90,0,0]) rpi_case_front() ;

translate([-(case_x+20),0,0]) {
    rpi_case_aeration() ;
    translate([0,case_thickness/2,case_z/2+case_thickness/2+20]) {
        color("silver")
        rpi_case_top();
    }


    translate([0,case_y/2+case_thickness/2+20,case_thickness/2]) {
        color("gray") {
            rpi_case_front() ;
        }
    }
}
