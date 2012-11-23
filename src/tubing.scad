module _loopoftube() {
color([0.3,0.5,0.6,0.5])
rotate_extrude()
 translate([loopD/2,0,0]){
difference() {
 circle(r = tubeOD/2);
//circle(r = tubeOD/2 - tubewall);
}}
}

module loopoftube() {
color([0.3,0.5,0.6])
translate([0,0,tubeOD/2]) {
difference() {
_loopoftube();
translate([0,-tubeOD/2 - gap,0-tubeOD/2])
cube([loopD + 30,tubeOD * 2 - tubeOD + gap*2,tubeOD]);
}
intersection() {
	_loopoftube();
	translate([0,tubeOD/2+gap,0]) rotate([0,90,0])
	 cylinder(r = tubeOD/2, h = loopD + 30);
}
translate([loopD/2,tubeOD/2+gap,0]) rotate([0,90,0])
cylinder(r = tubeOD/2, h = loopD/2);

intersection() {
	_loopoftube();
	translate([0,-tubeOD/2-gap,0]) rotate([0,90,0])
	 cylinder(r = tubeOD/2, h = loopD + 30);
}
translate([loopD/2,-tubeOD/2-gap,0]) rotate([0,90,0])
cylinder(r = tubeOD/2, h = loopD/2);
}
}