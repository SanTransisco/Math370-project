clear all;
clc

figure(1);
clf
filename = "USGSDATA/San_Fran_North.dem";
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
zoom(3)
drone2 = drone2.fly_to([37.7544,-122.4380,1000],50)
drone2 = drone2.fly_to([37.7808,-122.4380,500],50)
drone2.view();
drone2 = drone2.change_target([37.871,-122.4953,300],50)
drone2 = drone2.fly_to([37.800,-122.4380,800],50)
