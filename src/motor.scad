//============= motor vars ==================
motorlength = 26;
mround = 5;
mwidth = 22.3;
mlength = 30;
mheight = 21;
mholer = 1.5; //hole radius
//=======================================

module motoraddon() {
hull() {
translate([0,geardist,0]) cylinder(h = materialwidth, r = smallgearR + toothsize + wallwidth);
translate([motorlength,geardist,0]) cylinder(h = materialwidth, r = smallgearR + toothsize + wallwidth);
child(0);
}
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

module motor() {
remmotorholes()
translate([-11,-mwidth/2 + geardist,(-materialwidth*2)*explode]) 
{
	union() {
		color("white")
		linear_extrude(height = mheight)
		hull() 
		{
			translate([mround,0]) square([mlength,mwidth]);
			translate([mround,mround]) circle(r=mround);
			translate([mround,-mround+mwidth]) circle(r=mround);
		}

		color("white")
		translate([35,mwidth/2,10])
		rotate([90,0,90])
		cylinder(r = 10, h = 30);

		translate([11,mwidth/2,-5])
		motorshaft();
	}

	}
}

module remmotorbody() {
difference() {
	child(0);

	translate([0,geardist,0])
	translate([-11,-mwidth/2,-20])
	color("white")
	linear_extrude(height = mheight*3)
	hull() {
	translate([mround,0]) square([mlength*3,mwidth]);
	translate([mround,mround]) circle(r=mround);
	translate([mround,-mround+mwidth]) circle(r=mround);
	}

}
}

module remmotorholes() {
difference() {
	child(0);
	translate([-11,-mwidth/2 + geardist,(-materialwidth*2)*explode]) 
	union() {
		translate([30+mholer,1+mholer, -50])
		cylinder(r = mholer, h = 100);
		translate([30+mholer,mwidth-1-mholer, -50])
		cylinder(r = mholer, h = 100);
		}
	}
}