# Math370-project
Using Matlab I use USGS DEM data and the mapping toolbox in matlab to simulate terrain. In combination with satelite imagery we drape the image over the altitude data to create a recreation of the terrain only using the DEM data as input.
# Demos
There are 2 Main demos in the project
1.) Sunrise_Demo.m
2.) San_Fran_Demo.m

Go ahead and run any of those matlab files to get a general idea for the program.
Things like
1.) San_Fran_2.m
2.) Oleary_Demo.m

Follow the same process as San_Fran_Demo.m
Figure 1 is just an overview of the terrain from a far out perspective
Figure 2 is is a view of the terrain from the center of the area, then roatated around to get a good view of the entire area
Figure 3 is the orthographic image of the area we are observing
Figure 4 is a demo of the drone. Some of the demos have pre-determined flight paths.


# IF you want to give it a shot!
So the steps to initialize a terrain and drone as are follows
Make sure you have internet connection or else matlab can query the Web Map Service.

## Terrain Initialization
1.) Download some of the Dem terrain data from http://www.webgis.com/terr_us75m.html
2.) Open up matlab and initialize an empty Figure
  i.e.) figure(1)
3.) Call the Terrain object's contructor to load in the data from the .dem file and get the orthographic image from the WMSServer
  e.x.) San_fran_terrain = Terrain("USGSDATA/sanfranciscos.dem")
4.) Call the display function to display the terrain on the Figure
  e.x.) San_fran_terrain.Display()
Then you can do some basic stuff like Line, and Circle.
  ex.) San_fran_terrain.Circle()

## Drone Initialization
After you have initialized the Terrain object go ahead and grab the current camera location of the figure.
ex.) [camp,camt] = San_fran_terrain.get_cam()
Now you can create the drone object so that it starts at the same camera position as the current camera. (this is to avoid some disorienting images)
ex.) drone = Drone(camp,camt)

From here you can play around with the camera controls
### Move the Drone position
Substitute values for latitude, longitude, altitude, and speed
drone = drone.fly_to([latitude, longitude, altitude],speed)

### Move the Drone Target
Substitute values for latitude, longitude, altitude, and speed
drone = drone.change_target([latitude, longitude, altitude],speed)

If you have problems trying to find good latitude and longitudes you can
reference the workspace window in matlab.
Expand the terrain object to look at the attributes and if you look at the limit
vectors in the terrain object you can get a sense for the range of values that are
decent choices for coordinate positions.
