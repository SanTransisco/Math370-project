
%This is used to initialize the terrain
%Create a figure and open up the data and display the surface.
figure(1);
clf
filename = "USGSDATA/sanfranciscos.dem";
terrain  = Terrain(filename);
terrain.Display()
%This will then display a zoomed out view of the Bay Area

%This will have us place the camera at the peak of the sanfrancisco hills
%Then we will pan the camera around the mounting to take in the view of 
%San Fransisco

%Display a new figure of San Francisco
figure(2);clf;
terrain.Display();
%Define some lighting elements
%height at 10 will be mid sunrise, a red hue
%0 will be darkness
%>20 will result in a yellow hue
height = 10;
h = light();
az = 0;
%This function places the light
lightangle(h,az,height);
%This will set the color of the light
sunsetlights(h);
%This function will turn the camera round and 
terrain.LookCircle();

%This is just a simple figure, display the orthoimage just for reference
%purposes
figure(3); clf;
imshow(terrain.OrthoImage)

%This is the demo of the drone 
figure(4);clf;
terrain.Display();
%Define some lighting elements
%height at 10 will be mid sunrise, a red hue
%0 will be darkness
%>20 will result in a yellow hue
height = 10;
h = light();
az = 0;
%This function places the light
lightangle(h,az,height);
%This will set the color of the light
sunsetlights(h);
%Initialize the Drone Camera so it starts where the Camera is currently at.
%Otherwise it gets a bit disorienting
[camp, camt] = terrain.get_cam();
%Create the drone object using the position
drone2 = Drone(camp,camt)
%View the terrain from the drones perspective
drone2.view()
%Fly to various points.
drone2 = drone2.fly_to([37.62884,-122.4555,2000],50)
drone2 = drone2.fly_to([37.71453,-122.4902,1500],50)
drone2 = drone2.fly_to([37.729535,-122.4088,2000],50)
drone2 = drone2.fly_to([37.74535,-122.3588,2100],50)
drone2 = drone2.fly_to([37.74535,-122.3588,2400],50)

%%After this code is finished you can call more drone2.fly_to functions to
%%keep experimenting by flying around to different points.