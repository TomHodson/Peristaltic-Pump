use <peristalsic.scad>

projection(cut = true) {
difference() {

	translate([0,-60,0]) cube([10,140,5], center = true); 

	union() {

		for(i = [-12:0])
		assign(scale = 1 + i*0.01)
		translate([0,10*i,0])
		union() {
			#translate([0,0,-10]) scale([scale,scale,10]) motorshaft();
			echo("diam", i, 7*scale);
		}
		echo(scale);
	}
}
}