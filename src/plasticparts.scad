module loopsupportring() {
color(materialcolor)
remmotorbody()
remholes()
	difference() {
		difference() {
			motoraddon()
			cylinder(r = loopD/2 + wallwidth, h = materialwidth);
			translate([0,0,-1]) cylinder(r = loopD/2+tubeOD/2, h = materialwidth+2);
		}
	
		translate([0,-tubeOD-gap,-tubeOD]) 
		cube([loopD + 30,tubeOD * 2 + gap*2,tubeOD*2]);
		}
}

module loopspacerring() {
color(materialcolor)
remmotorbody() 
remholes()
		difference() {
			motoraddon()
			cylinder(r = loopD/2 + wallwidth, h = materialwidth);
			translate([0,0,-1]) cylinder(r = loopD/2-tubeOD/2, h = materialwidth+2);
		}

}

module frontplate() {
color(materialcolor)
remmotorbody()
remholes()
difference() {
			motoraddon()
			cylinder(r = loopD/2 + wallwidth, h = materialwidth);
			translate([0,0,-1]) cylinder(r = shaftR, h = materialwidth+2);
		}
}

module backplate() {
color(materialcolor)
remmotorbody()
remholes()
difference() {
			motoraddon()
			cylinder(r = loopD/2 + wallwidth, h = materialwidth);
			translate([0,0,-1]) cylinder(r = shaftR, h = materialwidth+2);
		}
}

module motorbracket() {
color(materialcolor)
remmotorholes()
remholes()
difference() {
			motoraddon()
			cylinder(r = loopD/2 + wallwidth, h = materialwidth);
			union() {
				translate([0,0,-1]) cylinder(r = biggearR + toothsize + lasgap, h = materialwidth+2);
				translate([0,geardist,-1]) cylinder(r = smallgearR + toothsize + lasgap/2, h = materialwidth+2);
			}
		}	
}