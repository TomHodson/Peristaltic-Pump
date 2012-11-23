$fn =20;
cyc = (1 + sin($t*360))/2;


bearingwidth = 7; //height
bearingrad = 11; //radius
bearingID = 8; //internal diameter

materialwidth = 4; //width of the lasercut material (not used everwhere yet)
tubeOD = 6;   //Outer Diameter of the tube
loopD = 80;    //Diameter of the tube loop
sleeve = 3.2;  //width of the sleeve around the bearings
armwidth = 10;  //width of the piece of material holding the bearings

shaftR = 8.817/2.0; // radius of the central shaft
shaftlen = 100;

wallwidth = 10; //width of the outer ring
tubewall = 1;
gap = 7; //gap between in and out tube
holerad = 1;

gengears = true;

backlash = 0.2;
geardist = loopD/2+wallwidth+14; 
bigteeth = 40; //1 + round((1 + sin($t*180)) * 40);
smallteeth = 10;
gearratio = bigteeth/smallteeth;
circular_pitch = (360*geardist) / ((bigteeth) + (smallteeth));
toothsize = circular_pitch/180;
echo("toothsize",toothsize);
pressure_angle = 30;
smallgearR = (smallteeth * circular_pitch / 180) / 2;
biggearR = (bigteeth * circular_pitch / 180) / 2;


lasgap = 2;
spread = 0;//1 - ((cyc) * (cyc));
explode = 10;//1 + (cyc) * 10;
spin = 1;
materialcolor = [0,0.5,0,0.8];
tile = (max(biggearR*2, loopD + wallwidth*2) + lasgap)*spread;//(loopD + wallwidth*2 + lasgap)*spread;
onlymaterial = false;