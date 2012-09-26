//use <peristalsic.scad>

module shaft(r= 8.81) {
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

projection(cut = true)
union() {
	motorshaft();
	translate([20,0,-2]) shaft();
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