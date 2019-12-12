%This is used to initialize the terrain
%Create a figure and open up the data and display the surface.
figure(1);clf;
filename = "USGSDATA/sanfranciscos.dem";
terrain  = Terrain(filename);
terrain.Display()


%From there we can define the lighthandle we are gonna use to "shade"
%or light the terrain
h = light();
%Turn on the setting for the interpolated lights.
lighting gouraud
%Essentially saying for every angle from -8 to 90
%Project and color the light on the terrain surface.
for i = 1:99
    height= i-9;
    az =0;
    %Set the angle of the light. AKA change the position of the sun
    lightangle(h,az,heigh);
    %Set the color of the sun to the correct value.
    sunsetlights(h)
    %Pause so the transition from sunrise to noon can be observed
    %If it it too fast change this to a larger value
    pause(.05)
end