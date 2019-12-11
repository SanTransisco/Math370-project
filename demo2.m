figure(1);
clf
filename = "USGSDATA/sanfranciscos.dem";
terrain  = Terrain(filename);
terrain.Display()

h = light()
lighting gouraud
for i = 1:99
    deg= i-9;
    az =0;
    lightangle(h,az,deg);
    sunsetlights(h)
    pause(.05)
end