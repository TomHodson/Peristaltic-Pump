use <../MCAD/involute_gears.scad>;
use <../MCAD/bearing.scad>;

//todo
//do away with bearing sleeves
//round off tube corners
//check shaft diams are right
//print out lasercut design
//a good shaft diameter is  a little less than 8.817mm corrected for kerf


$fn =20;
cyc = (1 + sin($t*360))/2;
echo(cyc);

//============= motor vars ==================
motorlength = 26;
mround = 5;
mwidth = 22.3;
mlength = 30;
mheight = 21;
mholer = 1.5; //hole radius
//=======================================

materialwidth = 4; //width of the lasercut material (not used everwhere yet)
tubeOD = 6;   //Outer Diameter of the tube
loopD = 80;    //Diameter of the tube loop
sleeve = 3.2;  //width of the sleeve around the bearings
armwidth = 10;  //width of the piece of material holding the bearings

bearingwidth = 7; //height
bearingrad = 11; //radius
bearingID = 8; //internal diameter

shaftR = 8.817/2.0; // radius of the central shaft
shaftlen = 100;

wallwidth = 10; //width of the outer ring
tubewall = 1;
gap = 7; //gap between in and out tube
holerad = 1;

backlash = 0.2;
geardist = loopD/2+wallwidth+14; 
bigteeth = 40; //1 + round((1 + sin($t*180)) * 40);
smallteeth = 10;
gearratio = bigteeth/smallteeth;
circular_pitch = (360*geardist) / ((bigteeth) + (smallteeth));
toothsize = circular_pitch/180;
echo("tsize",toothsize);
pressure_angle = 30;
smallgearR = (smallteeth * circular_pitch / 180) / 2;
biggearR = (bigteeth * circular_pitch / 180) / 2;


lasgap = 2;
spread = 1;//1 - ((cyc) * (cyc));
explode = 1;//1 + (cyc) * 10;
spin = 1;
materialcolor = [0,0.5,0,0.8];
tile = (max(biggearR*2, loopD + wallwidth*2) + lasgap)*spread;//(loopD + wallwidth*2 + lasgap)*spread;
onlymaterial = false;
gengears = true;

module 608sleeve() {
	bearing();
}

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

module shaft() {
	translate([0,0,-shaftlen/2]) color([0.5,0.5,0.5,0.6]) cylinder(r = shaftR, h = shaftlen, $fn = 6);
}

module bearingshafts() {
	color([0.5,0.5,0.5,0.6])
	union() {
			translate([-((loopD - tubeOD)/2 - bearingrad),0,0]) cylinder(r = shaftR, h =  bearingwidth + 2 * materialwidth);
			translate([(loopD - tubeOD)/2 - bearingrad,0,0]) cylinder(r = shaftR, h =  bearingwidth + 2 * materialwidth);
	}
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
}

module remholes() {
difference() {child(0); holes();}
}

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

module biggear() {
if(gengears) {
remshaft() 
gear(
number_of_teeth = bigteeth,
circular_pitch=circular_pitch,
pressure_angle = pressure_angle,
gear_thickness = materialwidth,
rim_thickness = materialwidth,
hub_thickness = materialwidth,
backlash = backlash,
roundsize = 0.7
); }
else {
echo("importing biggear.stl");
import("../stl/biggear.stl");
}
}

module motoraddon() {
hull() {
translate([0,geardist,0]) cylinder(h = materialwidth, r = smallgearR + toothsize + wallwidth);
translate([motorlength,geardist,0]) cylinder(h = materialwidth, r = smallgearR + toothsize + wallwidth);
child(0);
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
roundsize = 1
);
translate([0,0,-10]) scale([1,1 - 0.03,20]) motorshaft();
}
}
else {
echo("importing smallgear.stl");
import("../stl/smallgear.stl");
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
translate([-11,-mwidth/2 + geardist,(-materialwidth*2)*explode]) 
{
difference() {
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

		union() {
			translate([30+mholer,1+mholer, -50])
			cylinder(r = mholer, h = 100);
			translate([30+mholer,mwidth-1-mholer, -50])
			cylinder(r = mholer, h = 100);
			}
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

//projection(cut=true)
union() {


translate([tile*-2,tile*0,(-materialwidth * 3) * explode])
rotate([0,0,-360 * $t * 2 * spin])
biggear();

translate([tile*-0,tile*-0,(-materialwidth * 3) * explode])
//projection(cut=true)
smallgear();

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





