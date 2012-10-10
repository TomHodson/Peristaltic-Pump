//use <peristalsic.scad>
gengears = true;

module shaft(r= 8.81/2.0 - 0.2) {
	translate([0,0,1]) color([0.5,0.5,0.5,0.6]) cylinder(r = r, h = 100, $fn = 6);
}

module motorshaft(r = 3.4,width = 4.7) {
color("blue")
scale([])
rotate([0,0,-360 * $t * 2 * spin * gearratio + (360/bigteeth)])
linear_extrude(height = 5)
	intersection() {
		circle(r = r);
		translate([-5,-(2.5)]) square([10,width]);
	}
}

module smallgear() {
translate([0,geardist*(1-spread),0]) 
rotate([0,0,360 * $t * 2 * spin * gearratio])
if(gengears) {
difference() {


gear(
number_of_teeth = smallteeth,
circular_pitch=circular_pitch,
pressure_angle = pressure_angle,
gear_thickness = materialwidth,
rim_thickness = materialwidth,
hub_thickness = materialwidth,
backlash = backlash,
bore_diameter=0,
roundsize = 1s
);
translate([0,0,-10]) scale([1,1 - 0.03,20]) motorshaft();
}
}
else {
echo("importing smallgear.stl");
import("../stl/smallgear.stl");
}
}

projection(cut = true)
union() {
	translate([32,0,0]) smallgear();
}

// projection(cut = true)
// 	union() {

// 		for(i = [-6:0])
// 		assign(d = (9.237 - 0.3) + i*0.02)
// 		translate([0,20*i,0])
// 		union() {
// 			#translate([0,0,-30]) motorshaft(d);
// 			//translate([0,0,0]) cube(8, center = true);
// 			echo("diam", d);
// 		}
// 	}