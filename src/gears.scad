use <../MCAD/involute_gears.scad>;


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