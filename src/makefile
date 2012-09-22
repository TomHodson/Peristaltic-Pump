
.PHONY
default : laid-out-flat.stl, main.stl

laid-out-flat.stl : peristaltic.scad
	openscad peristaltic.scad  -D onlymaterial=true -D explode=0 -D spread=1 -D \$fn=10 -o ../stl/laid-out-flat.stl

main.stl : peristaltic.scad
	openscad peristaltic.scad  -D onlymaterial=false -D explode=1 -D spread=0 -D \$fn=10 -o ../stl/laid-out-flat.stl
