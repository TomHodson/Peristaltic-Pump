use <peristalsic.scad>

difference() {

	cube(h = 5, l = 20, w = 30); 

	union() {

		for(i = [-2:2])
		assign(scale = 1 + i*0.01)
		translate([0,10*i,0])
		union() {
			#translate([0,0,-10]) scale([scale,scale,10]) motorshaft();
			echo("diam", i, 7*scale);
		}
	}
}