use <../MCAD/bearing.scad>;

module 608sleeve() {
	bearing();
}
module bearingshafts() {
	color([0.5,0.5,0.5,0.6])
	union() {
			translate([-((loopD - tubeOD)/2 - bearingrad),0,0]) cylinder(r = shaftR, h =  bearingwidth + 2 * materialwidth);
			translate([(loopD - tubeOD)/2 - bearingrad,0,0]) cylinder(r = shaftR, h =  bearingwidth + 2 * materialwidth);
	}
}