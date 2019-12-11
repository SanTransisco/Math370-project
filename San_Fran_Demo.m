clear all;
clc

figure(1);
clf
filename = "USGSDATA/sanfranciscos.dem";
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
drone2.view()
drone2 = drone2.fly_to([37.62884,-122.4555,2000],50)
drone2 = drone2.fly_to([37.71453,-122.4902,1500],50)
drone2 = drone2.fly_to([37.729535,-122.4088,2000],50)
drone2 = drone2.fly_to([37.74535,-122.3588,2100],50)
drone2 = drone2.fly_to([37.74535,-122.3588,2400],50)