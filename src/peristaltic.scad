
//todo
//round off tube corners
//check shaft diams are right
//print out lasercut design
//a good shaft diameter is  a little less than 8.817mm corrected for kerf
//need to find good smooth rod, motorhole and screw hole diamters.


include <parameters.scad>

include <plasticparts.scad>
include <bearing.scad>
include <motor.scad>
include <gears.scad>
include <tubing.scad>


module shaft() {
	translate([0,0,-shaftlen/2]) color([0.5,0.5,0.5,0.6]) cylinder(r = shaftR, h = shaftlen, $fn = 6);
}

module remshaft() {
	difference() {child(0); scale([1,1,10]) shaft();}
}

module rembearingshafts() {
	difference() {child(0); scale([1,1,10]) bearingshafts();}
}

module arm() {
color(materialcolor)
rembearingshafts() 
remshaft()
	linear_extrude(height=materialwidth) hull() {
		translate([-((loopD - tubeOD)/2 - bearingrad),0,0]) circle(armwidth);
		translate([(loopD - tubeOD)/2 - bearingrad,0,0]) circle(armwidth);
	}

}

module holes() {
num = 8;
for(i=[0:num-1]){
rotate([0,0,i * (360/num)]){
translate([loopD/2 + wallwidth/2,0,-100]) cylinder(h = 200, r=holerad);
}
}
//some extra less parametric holes
translate([0,geardist + smallgearR + wallwidth/2 + lasgap,-100]) cylinder(h = 200, r=holerad);
translate([motorlength,geardist + smallgearR + wallwidth/2 + lasgap,-100]) cylinder(h = 200, r=holerad);
rotate([0,0,-45]) translate([0,biggearR + wallwidth,-100]) cylinder(h = 200, r=holerad);
rotate([0,0,20]) translate([0,biggearR + wallwidth,-100]) cylinder(h = 200, r=holerad);
}

module remholes() {
difference() {child(0); holes();}
}







//projection(cut=true)
union() {


translate([tile*-2,tile*0,(-materialwidth * 3) * explode])
rotate([0,0,-360 * $t * 2 * spin])
biggear();

translate([tile*-0,tile*-0,(-materialwidth * 3) * explode])
//projection(cut=true)
smallgear();

translate([tile*-2,tile*-1,(-materialwidth * 3) * explode])
rotate([0,0,-180*spread])
motorbracket();

translate([tile*-1,tile*-1,(-materialwidth * 2) * explode])
rotate([0,0,-180*spread])
backplate();

translate([tile*-1,tile*0,(-materialwidth * 1) * explode])
rotate([0,0,-360 * $t * 2 * spin])
arm();

translate([tile*-1,0,(-materialwidth * 1) * explode])
loopspacerring();

translate([tile*0,tile*0,(-materialwidth*0)*explode])
loopsupportring();

translate([tile*0,tile*-1,(materialwidth)*explode])
rotate([0,0,180*spread])
loopsupportring();

translate([tile,0,(materialwidth*2)*explode])
loopspacerring();

translate([tile*1,tile*0,(materialwidth * 2) * explode])
rotate([0,0,-360 * $t * 2 * spin])
arm();

translate([tile*1,tile*-1,(materialwidth * 3) * explode])
rotate([0,0,-180*spread])
frontplate();

if(onlymaterial == false) {


translate([tile*-0,tile*-1,0])
rotate([0,0,-360 * $t * 2 * spin])
translate([(loopD - tubeOD)/2 - bearingrad - sleeve - (5 * spread) ,0,0])
608sleeve();

translate([tile*-0,tile*-1,0])
rotate([0,0,-360 * $t * 2 * spin])
translate([-(loopD - tubeOD)/2 + bearingrad + sleeve + (5 * spread),0,0])
608sleeve();

translate([tile*-0,tile*-1,0])
rotate([0,0,-360 * $t * 2 * spin])
shaft(); 

translate([tile*-0,tile*-1,0])
rotate([0,0,-360 * $t * 2 * spin])
bearingshafts();

translate([tile*-1,tile*1,0])
motor();

loopoftube();

}
}





