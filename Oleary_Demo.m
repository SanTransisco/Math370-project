clear all;
clc

figure(1);
clf
filename = "USGSDATA/Oleary_Peak.dem";
terrain  = Terrain(filename);
terrain.Display()


figure(2);clf;
terrain.Display();
deg = 10;

h = light();
az = 0;
lightangle(h,az,deg);
sunsetlights(h);
terrain.LookCircle();


figure(3); clf;
imshow(terrain.OrthoImage)



figure(4);clf;
terrain.Display();
deg = 10;
h = light();
az = 0;
lightangle(h,az,deg);
sunsetlights(h);
[camp, camt] = terrain.get_cam();
drone2 = Drone(camp,camt)
drone2.view();
%%Same as the 

